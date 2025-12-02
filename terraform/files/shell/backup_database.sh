#!/usr/bin/env bash
set -e

CONTAINER_NAME="mysql-database"

DB_USER="root"
DB_PASSWORD="infra"
DB_NAME="grupo4"

BACKUP_DIR="/mysql_backups"

AWS_REGION="us-east-1"
S3_BUCKET="beauty-barreto-backup"
S3_PREFIX="database"

sudo mkdir -p "$BACKUP_DIR"

DATE=$(date +"%Y-%m-%d_%H-%M-%S")
FILENAME="${DB_NAME}_${DATE}.sql.gz"
FILEPATH="${BACKUP_DIR}/${FILENAME}"
S3_URI="s3://${S3_BUCKET}/${S3_PREFIX}/${FILENAME}"

echo "[$(date)] Gerando backup completo do banco '${DB_NAME}'..."

sudo docker exec "$CONTAINER_NAME" sh -c "
  mysqldump \
    --user='${DB_USER}' \
    --password='${DB_PASSWORD}' \
    --single-transaction \
    --quick \
    --triggers \
    --routines \
    --events \
    --no-tablespaces \
    --set-gtid-purged=OFF \
    '${DB_NAME}'
" | gzip > "$FILEPATH"

if [[ -s "$FILEPATH" ]]; then
  echo "[$(date)] [SUCESSO] Backup gerado em: $FILEPATH"
else
  echo "[$(date)] [ERRO] Arquivo de backup está vazio!" >&2
  exit 1
fi

echo "[$(date)] Enviando backup para o bucket S3: $S3_URI ..."
sudo aws s3 cp "$FILEPATH" "$S3_URI" --region "$AWS_REGION"

echo "[$(date)] [SUCESSO] Backup enviado para $S3_URI"
