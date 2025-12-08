cd terraform;
chmod 400 grupo4-key-pub-local.pem;
ssh -i grupo4-key-pub-local.pem -L 5540:10.1.0.37:5540 ubuntu@100.30.131.174