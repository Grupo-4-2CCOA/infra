#!/usr/bin/env bash
set -euo pipefail

DB_HOST="127.0.0.1"
DB_PORT="3306"
DB_USER="root"
DB_PASSWORD="senha"
DB_NAME="grupo4"
BACKUP_DIR="/mysql_backups"

sudo mkdir -p "$BACKUP_DIR"

DATE=$(date -I)
FILENAME="${DB_NAME}_${DATE}.sql"
FILEPATH="${BACKUP_DIR}/${FILENAME}"
S3_URI="s3://beauty-barreto-backup/database/${FILENAME}"

echo "Gerando backup completo do banco '${DB_NAME}'..."
sudo mysqldump \
  --host="$DB_HOST" \
  --port="$DB_PORT" \
  --user="$DB_USER" \
  --password="$DB_PASSWORD" \
  --single-transaction \
  --quick \
  --triggers \
  --routines \
  --events \
  --no-tablespaces \
  --set-gtid-purged=OFF \
  "$DB_NAME" \
| sudo /usr/bin/tee "$FILEPATH" > /dev/null

if [[ -s "$FILEPATH" ]]; then
  echo "[SUCESSO] Backup gerado em: $FILEPATH"
else
  echo "[ERRO] Arquivo de backup está vazio!" >&2
  exit 1
fi

echo "Enviando backup para o bucket S3..."
aws s3 cp "$FILEPATH" "$S3_URI" --region "us-east-1"

if [[ $? -eq 0 ]]; then
  echo "[SUCESSO] Backup enviado para $S3_URI"
else
  echo "[ERRO] Falha ao enviar backup para o S3!" >&2
  exit 1
fi
