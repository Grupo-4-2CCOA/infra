from diagrams import Cluster, Diagram, Edge
from diagrams.custom import Custom
from diagrams.aws.compute import EC2, Lambda
from diagrams.aws.storage import EBS, EFS, S3
from diagrams.aws.network import VPC, ALB, IGW, RouteTable, NATGateway
from diagrams.aws.general import Client
from diagrams.aws.analytics import Glue
from diagrams.aws.management import Cloudwatch
from diagrams.programming.language import Java, Python
from diagrams.programming.framework import React
from diagrams.onprem.database import Mysql
from diagrams.onprem.inmemory import Redis
from diagrams.onprem.queue import Rabbitmq
from diagrams.onprem.monitoring import Grafana
from diagrams.onprem.container import Docker
from diagrams.programming.framework import Spring

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

with Diagram("Infraestrutura - Beauty Barreto", show=False, node_attr=node_font_style, graph_attr=diagram_font_style, direction="TB"):
  client = Client("Cliente")
  employee = Client("Funcionário")
  admin = Client("Administrador")
  
  google = Custom("Google", "assets/google.png")
  google_calendar = Custom("Google Calendar", "assets/google_calendar.png")
  
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
    
    cloudwatch = Cloudwatch("CloudWatch")
    
    with Cluster("VPC", graph_attr=cluster_font_style):
      vpc = VPC("VPC")
      route_table = RouteTable("Tabela de Rotas")
      nat_gateway = NATGateway("NAT Gateway")
      
      acl_private = Custom("ACL Privada", "assets/acl.png")
      acl_public = Custom("ACL Pública", "assets/acl.png")
      
      alb = ALB("Application Load Balancer")
      
      with Cluster("Zona de Disponibilidade 1a", graph_attr=cluster_font_style):
        with Cluster("Subnet Pública 1a", graph_attr=cluster_font_style):
          with Cluster("Servidor Frontend (az1a_pub)", graph_attr=cluster_font_style):
            ec2_az1a_pub = EC2("EC2")
            ebs_az1a_pub = EBS("EBS")
            sg_az1a_pub = Custom("Grupo de Segurança", "assets/securityGroup.png")
            with Cluster("Docker", graph_attr=cluster_font_style):
              docker_react_1a = Docker("Container")
              react_az1a = React("React")
              docker_react_1a >> Edge() << react_az1a
            
            ebs_az1a_pub >> Edge() << ec2_az1a_pub
            ec2_az1a_pub >> Edge() << docker_react_1a
            sg_az1a_pub >> Edge() << ec2_az1a_pub
        
        with Cluster("Subnet Privada 1a", graph_attr=cluster_font_style):
          with Cluster("Servidor Backend (az1a_pri)", graph_attr=cluster_font_style):
            ec2_az1a_pri = EC2("EC2")
            ebs_az1a_pri = EBS("EBS")
            sg_az1a_pri = Custom("Grupo de Segurança", "assets/securityGroup.png")
            
            with Cluster("Docker Compose", graph_attr=cluster_font_style):
              with Cluster("Container Java", graph_attr=cluster_font_style):
                docker_spring = Docker("Container")
                java_backend = Java("Java")
                springboot = Spring("SpringBoot")
                docker_spring >> Edge() << java_backend
                java_backend >> Edge() << springboot
              
              with Cluster("Container RabbitMQ", graph_attr=cluster_font_style):
                docker_rabbit = Docker("Container")
                rabbitmq = Rabbitmq("RabbitMQ")
                docker_rabbit >> Edge() << rabbitmq
              
              with Cluster("Container Redis", graph_attr=cluster_font_style):
                docker_redis = Docker("Container")
                redis = Redis("Redis")
                docker_redis >> Edge() << redis
              
              with Cluster("Container Consumer", graph_attr=cluster_font_style):
                docker_consumer = Docker("Container")
                consumer = Python("Consumer")
                docker_consumer >> Edge() << consumer
              
              springboot >> Edge() << rabbitmq
              springboot >> Edge() << redis
              rabbitmq >> Edge() << consumer
            
            ebs_az1a_pri >> Edge() << ec2_az1a_pri
            ec2_az1a_pri >> Edge() << docker_spring
            sg_az1a_pri >> Edge() << ec2_az1a_pri
          
          with Cluster("Servidor de Banco de Dados (az1a_db)", graph_attr=cluster_font_style):
            ec2_az1a_db = EC2("EC2")
            ebs_az1a_db = EBS("EBS")
            sg_az1a_db = Custom("Grupo de Segurança", "assets/securityGroup.png")
            
            with Cluster("Docker", graph_attr=cluster_font_style):
              docker_mysql = Docker("Container")
              mysql = Mysql("MySQL")
              docker_mysql >> Edge() << mysql
            
            ebs_az1a_db >> Edge() << ec2_az1a_db
            ec2_az1a_db >> Edge() << docker_mysql
            sg_az1a_db >> Edge() << ec2_az1a_db
          
          # Consumer conecta ao MySQL
          consumer >> Edge() << mysql
      
      with Cluster("Zona de Disponibilidade 1b", graph_attr=cluster_font_style):
        with Cluster("Subnet Pública 1b", graph_attr=cluster_font_style):
          with Cluster("Servidor Frontend (az1b_pub)", graph_attr=cluster_font_style):
            ec2_az1b_pub = EC2("EC2")
            ebs_az1b_pub = EBS("EBS")
            sg_az1b_pub = Custom("Grupo de Segurança", "assets/securityGroup.png")
            with Cluster("Docker", graph_attr=cluster_font_style):
              docker_react_1b = Docker("Container")
              react_az1b = React("React")
              docker_react_1b >> Edge() << react_az1b
            
            ebs_az1b_pub >> Edge() << ec2_az1b_pub
            ec2_az1b_pub >> Edge() << docker_react_1b
            sg_az1b_pub >> Edge() << ec2_az1b_pub
      
      with Cluster("Zona de Disponibilidade 1c", graph_attr=cluster_font_style):
        with Cluster("Subnet Pública 1c", graph_attr=cluster_font_style):
          with Cluster("Servidor de Monitoramento (az1c_pub)", graph_attr=cluster_font_style):
            ec2_az1c_pub = EC2("EC2")
            ebs_az1c_pub = EBS("EBS")
            grafana = Grafana("Grafana")
            sg_az1c_pub = Custom("Grupo de Segurança", "assets/securityGroup.png")
            
            ebs_az1c_pub >> Edge() << ec2_az1c_pub
            ec2_az1c_pub >> Edge() << grafana
            sg_az1c_pub >> Edge() << ec2_az1c_pub
      
      efs = EFS("EFS")
      sg_efs = Custom("Grupo de Segurança EFS", "assets/securityGroup.png")
      sg_efs >> Edge() << efs
    
    client >> Edge() << internet_gateway
    employee >> Edge() << internet_gateway
    admin >> Edge() << internet_gateway
    internet_gateway >> Edge() << vpc
    vpc >> Edge() << route_table
    route_table >> Edge() << alb
    route_table >> Edge() << nat_gateway
    nat_gateway >> Edge() << internet_gateway
    
    admin >> Edge() << alb
    admin >> Edge() << grafana
    
    acl_public >> Edge() << sg_az1a_pub
    acl_public >> Edge() << sg_az1b_pub
    acl_public >> Edge() << sg_az1c_pub
    acl_public >> Edge() << sg_efs
    acl_private >> Edge() << sg_az1a_pri
    acl_private >> Edge() << sg_az1a_db
    
    alb >> Edge() << ec2_az1a_pub
    alb >> Edge() << ec2_az1b_pub
    
    react_az1a >> Edge() << springboot
    react_az1b >> Edge() << springboot
    
    springboot >> Edge() << mysql
    
    google >> Edge() << springboot
    google_calendar >> Edge() << springboot
    
    # EFS para Frontend
    efs >> Edge() << ec2_az1a_pub
    efs >> Edge() << ec2_az1b_pub
    
    s3_raw >> Edge() << lambda_treatment
    lambda_treatment >> Edge() << s3_trusted
    s3_trusted >> Edge() << lambda_flattened
    lambda_flattened >> Edge() << s3_client
    s3_client >> Edge() << glue_crawler
    glue_crawler >> Edge() << glue_db
    glue_db >> Edge() << grafana
    
    # CloudWatch Monitoring (apenas supervisiona instâncias EC2)
    cloudwatch >> Edge() << ec2_az1a_pub
    cloudwatch >> Edge() << ec2_az1b_pub
    cloudwatch >> Edge() << ec2_az1a_pri
    cloudwatch >> Edge() << ec2_az1a_db
    cloudwatch >> Edge() << alb

