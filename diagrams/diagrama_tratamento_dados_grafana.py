from diagrams import Cluster, Diagram, Edge
from diagrams.custom import Custom
from diagrams.aws.compute import EC2, Lambda
from diagrams.aws.storage import EBS, S3
from diagrams.aws.network import VPC, IGW
from diagrams.aws.general import Client
from diagrams.aws.analytics import Glue
from diagrams.onprem.monitoring import Grafana

diagram_font_style = {
  "labelloc": "t",
  "fontname": "Helvetica Bold",
  "fontsize": "50px",
}
cluster_font_style = {
  "labelloc": "t",
  "fontname": "Helvetica Bold",
  "fontsize": "30px",
}
node_font_style = {
  "labelloc": "b",
  "fontname": "Helvetica",
  "fontsize": "15px",
}

with Diagram("Tratamento de Dados e Grafana - Beauty Barreto", show=False, node_attr=node_font_style, graph_attr=diagram_font_style, direction="TB"):
  admin = Client("Administrador")
  
  with Cluster("AWS", graph_attr=cluster_font_style):
    internet_gateway = IGW("Gateway de Internet")
    with Cluster("Armazenamento S3", graph_attr=cluster_font_style):
      s3_raw = S3("Raw")
      s3_trusted = S3("Trusted")
      s3_client = S3("Client")
    
    with Cluster("Funções Lambda", graph_attr=cluster_font_style):
      lambda_treatment = Lambda("Tratamento de Dados")
      lambda_flattened = Lambda("Criar Arquivo Flattened")
    
    with Cluster("Processamento de Dados", graph_attr=cluster_font_style):
      glue_db = Glue("Banco de Dados Glue")
      glue_crawler = Glue("Glue Crawler")
    
    with Cluster("VPC", graph_attr=cluster_font_style):
      vpc = VPC("VPC")
      
      with Cluster("Subnet Pública", graph_attr=cluster_font_style):
        with Cluster("Servidor de Monitoramento", graph_attr=cluster_font_style):
          ec2_grafana = EC2("EC2")
          ebs_grafana = EBS("EBS")
          grafana = Grafana("Grafana")
          sg_grafana = Custom("Grupo de Segurança", "assets/securityGroup.png")
          
          ebs_grafana >> Edge() << ec2_grafana
          ec2_grafana >> Edge() << grafana
          sg_grafana >> Edge() << ec2_grafana
  
  # Fluxo de tratamento de dados
  s3_raw >> Edge() << lambda_treatment
  lambda_treatment >> Edge() << s3_trusted
  s3_trusted >> Edge() << lambda_flattened
  lambda_flattened >> Edge() << s3_client
  s3_client >> Edge() << glue_crawler
  glue_crawler >> Edge() << glue_db
  glue_db >> Edge() << grafana
  
  # Conexões de rede
  admin >> Edge() << internet_gateway
  internet_gateway >> Edge() << vpc
  vpc >> Edge() << ec2_grafana
  
  # Acesso ao Grafana
  admin >> Edge() << grafana
