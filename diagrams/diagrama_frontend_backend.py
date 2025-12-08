from diagrams import Cluster, Diagram, Edge
from diagrams.custom import Custom
from diagrams.aws.compute import EC2
from diagrams.aws.storage import EBS
from diagrams.aws.network import VPC, ALB, IGW
from diagrams.aws.general import Client
from diagrams.programming.framework import React, Spring
from diagrams.programming.language import Python
from diagrams.onprem.database import Mysql
from diagrams.onprem.inmemory import Redis
from diagrams.onprem.queue import Rabbitmq
from diagrams.onprem.container import Docker

diagram_font_style = {
  "labelloc": "t",
  "fontname": "Helvetica Bold",
  "fontsize": "72",
  "rankdir": "LR",
  "splines": "ortho",
  "nodesep": "0.8",
  "ranksep": "1.5",
}
cluster_font_style = {
  "labelloc": "t",
  "fontname": "Helvetica Bold",
  "fontsize": "42",
}
node_font_style = {
  "labelloc": "b",
  "fontname": "Helvetica",
  "fontsize": "24",
}

with Diagram("Aplicação - Beauty Barreto", show=False, node_attr=node_font_style, graph_attr=diagram_font_style, direction="LR", outformat="png"):
  client = Client("Cliente")
  employee = Client("Funcionário")
  admin = Client("Administrador")
  
  google = Custom("Google", "assets/google.png")
  googleCalendar = Custom("Google Calendar", "assets/google_calendar.png")
  
  with Cluster("AWS", graph_attr=cluster_font_style):
    internet_gateway = IGW("Gateway de Internet")
    
    with Cluster("VPC", graph_attr=cluster_font_style):
      vpc = VPC("VPC")
      alb = ALB("Application\nLoad Balancer")
      
      with Cluster("Subnets Públicas (Frontend)", graph_attr=cluster_font_style):
        with Cluster("AZ 1a", graph_attr=cluster_font_style):
          ec2_frontend_1a = EC2("EC2")
          with Cluster("Docker", graph_attr=cluster_font_style):
            docker_react_1a = Docker("Container")
            react_1a = React("React")
            docker_react_1a >> Edge() << react_1a
          ec2_frontend_1a >> Edge() << docker_react_1a
        
        with Cluster("AZ 1b", graph_attr=cluster_font_style):
          ec2_frontend_1b = EC2("EC2")
          with Cluster("Docker", graph_attr=cluster_font_style):
            docker_react_1b = Docker("Container")
            react_1b = React("React")
            docker_react_1b >> Edge() << react_1b
          ec2_frontend_1b >> Edge() << docker_react_1b
      
      with Cluster("Subnet Privada (Backend)", graph_attr=cluster_font_style):
        ec2_backend = EC2("EC2")
        with Cluster("Docker Compose", graph_attr=cluster_font_style):
          with Cluster("Container Java", graph_attr=cluster_font_style):
            docker_spring = Docker("Container")
            springboot = Spring("SpringBoot")
            docker_spring >> Edge() << springboot
          
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
        
        ec2_backend >> Edge() << docker_spring
      
      with Cluster("Subnet Privada (Database)", graph_attr=cluster_font_style):
        ec2_db = EC2("EC2")
        with Cluster("Docker", graph_attr=cluster_font_style):
          docker_mysql = Docker("Container")
          mysql = Mysql("MySQL")
          docker_mysql >> Edge() << mysql
        ec2_db >> Edge() << docker_mysql
      
      consumer >> Edge() << mysql
  
  client >> Edge() << internet_gateway
  employee >> Edge() << internet_gateway
  admin >> Edge() << internet_gateway
  internet_gateway >> Edge() << vpc
  vpc >> Edge() << alb
  
  alb >> Edge() << ec2_frontend_1a
  alb >> Edge() << ec2_frontend_1b
  react_1a >> Edge() << springboot
  react_1b >> Edge() << springboot
  mysql >> Edge() << springboot
  
  google >> Edge() << springboot
  googleCalendar >> Edge() << springboot
