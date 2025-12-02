cd terraform;
chmod 400 grupo4-key-pub-local.pem;
ssh -i grupo4-key-pub-local.pem -L 15672:10.1.0.37:15672 ubuntu@3.225.148.41