cd terraform;
chmod 400 grupo4-key-pub-local.pem;
ssh -i grupo4-key-pub-local.pem -L 8080:10.1.0.37:8080 ubuntu@3.225.148.41