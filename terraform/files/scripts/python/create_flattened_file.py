import boto3
import pandas as pd
from io import StringIO

s3 = boto3.client("s3", region_name="us-east-1")
BUCKET = "beauty-barreto-trusted"

FILES = [
    "treated_weather_data.csv",
    "treated_schedule_data.csv",
    "treated_holiday_data.csv"
]

OUTPUT_KEY = "flattened/flattened_dataset.csv"

def read_csv_from_s3(bucket, key):
    obj = s3.get_object(Bucket=bucket, Key=key)
    csv_data = obj["Body"].read().decode("utf-8", errors="replace")
    df = pd.read_csv(StringIO(csv_data), low_memory=False)
    return df

def lambda_handler(event, context):
    try:
        df1 = read_csv_from_s3(BUCKET, FILES[0])
        df2 = read_csv_from_s3(BUCKET, FILES[1])
        df3 = read_csv_from_s3(BUCKET, FILES[2])

        if "data" in df3.columns:
            df3 = df3.rename(columns={"data": "data_feriado"})

        if "Data" in df1.columns:
            df1 = df1.drop(columns=["Data"])

        if "Hora" in df1.columns:
            df1 = df1.drop(columns=["Hora"])

        df2["data_str"] = pd.to_datetime(
            df2["data_hora_agendamento"],
            format="%d/%m/%Y %H:%M",
            errors="coerce"
        ).dt.strftime("%d/%m/%Y")

        df3["data_feriado_str"] = pd.to_datetime(
            df3["data_feriado"],
            format="%d/%m/%Y",
            errors="coerce"
        ).dt.strftime("%d/%m/%Y")

        feriados_set = set(df3["data_feriado_str"].dropna().tolist())

        df2["feriado"] = df2["data_str"].apply(lambda d: "Sim" if d in feriados_set else "Não")

        df2 = df2.drop(columns=["data_str"])

        df_final = pd.concat([df1, df2], axis=1)

        csv_buffer = StringIO()
        df_final.to_csv(csv_buffer, index=False)
        s3.put_object(
            Bucket="beauty-barreto-client",
            Key=OUTPUT_KEY,
            Body=csv_buffer.getvalue(),
            ContentType="text/csv"
        )

        return {
            "status": "OK",
            "output": OUTPUT_KEY
        }

    except Exception as e:
        print(f"Erro ao gerar flattened: {repr(e)}")
        return {"status": "ERRO", "message": repr(e)}
