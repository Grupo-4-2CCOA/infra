import boto3
import pandas as pd
from io import StringIO

s3 = boto3.client("s3", region_name="us-east-1")

TRUSTED_BUCKET = "beauty-barreto-trusted"
KEY = "schedules/schedule_data.csv"

def lambda_handler(event, context):
    try:
        obj = s3.get_object(Bucket="beauty-barreto-raw", Key=KEY)
        csv_data = obj["Body"].read().decode("utf-8")
        print("Arquivo lido com sucesso do S3.")

        df = pd.read_csv(StringIO(csv_data))

        if "created_at" in df.columns:
            df = df.drop(columns=["created_at"])

        status_map = {
            "CONCLUÍDO": "Concluído",
            "CANCELADO": "Cancelado",
            "ATIVO": "Ativo",
        }
        
        df["status"] = df["status"].map(status_map).fillna(df["status"])

        df["appointment_datetime"] = pd.to_datetime(df["appointment_datetime"], errors="coerce")

        minutos_dia = df["appointment_datetime"].dt.hour * 60 + df["appointment_datetime"].dt.minute
        mask_horario = (minutos_dia >= 9 * 60) & (minutos_dia <= 18 * 60)
        df = df[mask_horario].copy()

        df["appointment_datetime"] = df["appointment_datetime"].dt.strftime("%d/%m/%Y %H:%M")

        df = df.rename(
            columns={
                "status": "status",
                "appointment_datetime": "data_hora_agendamento",
                "duration": "duracao",
                "service": "servico"
            }
        )

        csv_buffer = StringIO()
        df.to_csv(csv_buffer, index=False)

        s3.put_object(
            Bucket=TRUSTED_BUCKET,
            Key="treated_schedule_data.csv",
            Body=csv_buffer.getvalue(),
            ContentType="text/csv"
        )

        print(f"Tratado e enviado: s3://{TRUSTED_BUCKET}/treated_schedule_data.csv")
        return {"status": "OK"}
    except Exception as e:
        print(f"Erro ao processar o arquivo: {e}")
        return {"status": "ERRO", "message": str(e)}
