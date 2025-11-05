import boto3, io
import pandas as pd
from io import StringIO
import unicodedata

s3 = boto3.client("s3", region_name="us-east-1")

TRUSTED_BUCKET = "beauty-barreto-trusted"
RAW_BUCKET = "beauty-barreto-raw"
KEY = "weathers/weather_data.csv"
OUT_KEY = "treated_weather_data.csv"

def _read_header_line(bucket: str, key: str, max_bytes: int = 64 * 1024) -> str:
    r = s3.get_object(Bucket=bucket, Key=key, Range=f"bytes=0-{max_bytes-1}")
    chunk = r["Body"].read()
    nl = chunk.find(b"\n")
    header = chunk if nl == -1 else chunk[:nl+1]
    return header.decode("utf-8", errors="replace")

def _select_station(station_name: str):
    expr = f'SELECT * FROM S3Object s WHERE UPPER(s."station") = \'{station_name.upper()}\''
    return s3.select_object_content(
        Bucket=RAW_BUCKET,
        Key=KEY,
        ExpressionType='SQL',
        Expression=expr,
        InputSerialization={'CSV': {'FileHeaderInfo': 'USE'}},
        OutputSerialization={'CSV': {}},
    )

def _norm_col(name: str) -> str:
    n = unicodedata.normalize("NFD", str(name)).encode("ascii", "ignore").decode("ascii")
    return "".join(ch for ch in n.lower() if ch.isalnum())

def lambda_handler(event, context):
    try:
        station_name = "SAO PAULO - INTERLAGOS"

        header = _read_header_line(RAW_BUCKET, KEY)
        resp = _select_station(station_name)

        buf = io.StringIO()
        buf.write(header)

        found_records = False
        for ev in resp["Payload"]:
            if "Records" in ev:
                buf.write(ev["Records"]["Payload"].decode("utf-8"))
                found_records = True

        data = buf.getvalue()

        if not found_records:
            s3.put_object(Bucket=TRUSTED_BUCKET, Key=OUT_KEY, Body=header, ContentType="text/csv")
            return {"status": "OK", "rows_written": 0, "note": "sem linhas para a estacao"}

        df = pd.read_csv(StringIO(data), low_memory=False)

        extra_drop = [
            "index",
            "region",
            "station_code",
            "latitude",
            "longitude",
            "height",
            "PRESSAO ATMOSFERICA AO NIVEL DA ESTACAO, HORARIA (mB)",
            "PRESSÃO ATMOSFERICA MAX.NA HORA ANT. (AUT) (mB)",
            "PRESSÃO ATMOSFERICA MIN. NA HORA ANT. (AUT) (mB)",
            "RADIACAO GLOBAL (Kj/m²)",
            "VENTO, DIREÇÃO HORARIA (gr) (° (gr))",
            "VENTO, RAJADA MAXIMA (m/s)",
            "UMIDADE REL. MAX. NA HORA ANT. (AUT) (%)",
            "UMIDADE REL. MIN. NA HORA ANT. (AUT) (%)",
            "TEMPERATURA DO PONTO DE ORVALHO (°C)",
            "TEMPERATURA MÁXIMA NA HORA ANT. (AUT) (°C)",
            "TEMPERATURA MÍNIMA NA HORA ANT. (AUT) (°C)",
            "TEMPERATURA ORVALHO MAX. NA HORA ANT. (AUT) (°C)",
            "TEMPERATURA ORVALHO MIN. NA HORA ANT. (AUT) (°C)",
        ]
        to_drop_norm = set(_norm_col(c) for c in extra_drop)
        norm_map = {c: _norm_col(c) for c in df.columns}
        cols_to_drop = [c for c in df.columns if norm_map[c] in to_drop_norm]
        if cols_to_drop:
            df = df.drop(columns=cols_to_drop, errors="ignore")

        negative_cols_pt = [
            "PRECIPITAÇÃO TOTAL, HORÁRIO (mm)",
            "UMIDADE RELATIVA DO AR, HORARIA (%)",
            "TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)",
            "VENTO, VELOCIDADE HORARIA (m/s)",
        ]
        neg_norm = set(_norm_col(x) for x in negative_cols_pt)
        cols_present = [c for c in df.columns if _norm_col(c) in neg_norm]
        for col in cols_present:
            df[col] = pd.to_numeric(df[col], errors="coerce")
            df.loc[df[col] < 0, col] = pd.NA

        rename_pairs = {
            "PRECIPITAÇÃO TOTAL, HORÁRIO (mm)": "Precipitacao",
            "TEMPERATURA DO AR - BULBO SECO, HORARIA (°C)": "Temperatura",
            "UMIDADE RELATIVA DO AR, HORARIA (%)": "Umidade",
            "VENTO, VELOCIDADE HORARIA (m/s)": "Velocidade do Vento",
        }
        
        rename_map = {}
        df_norm_cols = {_norm_col(c): c for c in df.columns}
        for src, dst in rename_pairs.items():
            key = _norm_col(src)
            if key in df_norm_cols:
                rename_map[df_norm_cols[key]] = dst
        if rename_map:
            df = df.rename(columns=rename_map)

        required_cols = ["Precipitação (mm)", "Temperatura (°C)", "Umidade (%)", "Velocidade do Vento (m/s)"]
        final_required = []
        curr_norm = {_norm_col(c): c for c in df.columns}
        for want in required_cols:
            if want in df.columns:
                final_required.append(want)
            else:
                k = _norm_col(want)
                if k in curr_norm:
                    final_required.append(curr_norm[k])
        before = len(df)
        
        for c in final_required:
            if df[c].dtype == object:
                df[c] = df[c].replace(r"^\s*$", pd.NA, regex=True)
        df = df.dropna(subset=final_required, how="any")
        removed_rows = before - len(df)

        out_buf = io.StringIO()
        df.to_csv(out_buf, index=False)
        s3.put_object(Bucket=TRUSTED_BUCKET, Key=OUT_KEY, Body=out_buf.getvalue(), ContentType="text/csv")

        return {
            "status": "OK",
            "rows_written": int(df.shape[0])
        }

    except Exception as e:
        print(f"Erro ao processar o arquivo: {repr(e)}")
        return {"status": "ERRO", "message": repr(e)}
