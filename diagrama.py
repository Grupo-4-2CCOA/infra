from diagrams import Cluster, Diagram, Edge
from diagrams.onprem.database import Mysql
from diagrams.generic.os import Windows
from diagrams.aws.compute import EC2
from diagrams.aws.storage import EBS
from diagrams.aws.network import VPC

with Diagram("Arquitetura de Rede", show=False):
  ec2_az1a_front = EC2("ec2_az1a_front")
  ebs_ec2_az1a_front = EBS("ebs_ec2_az1a_front")

  database = Mysql("Banco de dados")
  client = Windows("Cliente")

  ec2_az1a_front << Edge() << ebs_ec2_az1a_front

  client >> database
