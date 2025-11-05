import boto3
import pandas as pd
from io import StringIO

s3 = boto3.client("s3", region_name="us-east-1")

TRUSTED_BUCKET = "beauty-barreto-trusted"
KEY = "holidays/holiday_data.csv"

def lambda_handler(event, context):
    try:
        obj = s3.get_object(Bucket="beauty-barreto-raw", Key=KEY)
        csv_data = obj["Body"].read().decode("utf-8")
        print("Arquivo lido com sucesso do S3.")

        df = pd.read_csv(StringIO(csv_data))

        df["data"] = pd.to_datetime(df["data"], format="%Y-%m-%d")
        df = df.sort_values("data")
        df["data"] = df["data"].dt.strftime("%d/%m/%Y")

        csv_buffer = StringIO()
        df.to_csv(csv_buffer, index=False)

        s3.put_object(
            Bucket=TRUSTED_BUCKET,
            Key="treated_holiday_data.csv",
            Body=csv_buffer.getvalue(),
            ContentType="text/csv"
        )

        print(f"Tratado e enviado: s3://{TRUSTED_BUCKET}/treated_holiday_data.csv")
        return {"status": "OK"}
    except Exception as e:
        print(f"Erro ao processar o arquivo: {e}")
        return {"status": "ERRO", "message": str(e)}
