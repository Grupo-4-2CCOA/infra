from diagrams import Cluster, Diagram, Edge
from diagrams.custom import Custom
from diagrams.aws.compute import EC2
from diagrams.aws.storage import EBS, EFS, S3
from diagrams.aws.network import VPC, ALB, IGW, RouteTable
from diagrams.aws.general import Client
from diagrams.aws.integration import SNS
from diagrams.aws.management import Cloudwatch, CloudwatchAlarm

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

with Diagram("Arquitetura de Rede", show=False, node_attr=node_font_style, graph_attr=diagram_font_style):
  with Cluster("AWS", graph_attr=cluster_font_style):
    internet_gateway = IGW("Internet Gateway")

    with Cluster("S3", graph_attr=cluster_font_style):
      s3_raw = S3("Raw")
      s3_trusted = S3("Trusted")
      s3_curated = S3("Curated")

      internet_gateway >> Edge() << s3_raw
      internet_gateway >> Edge() << s3_trusted
      internet_gateway >> Edge() << s3_curated
    with Cluster("Observability", graph_attr=cluster_font_style):
      cloudwatch = Cloudwatch("CloudWatch")
      alarm = CloudwatchAlarm("Alarm")
      sns = SNS("SNS")

      # cloudwatch >> Edge(style="invis") << alarm >> Edge(style="invis") << sns

    with Cluster("VPC", graph_attr=cluster_font_style):
      vpc = VPC("VPC")
      route_table = RouteTable("Route Table")

      acl_private = Custom("ACL Privada", "assets/acl.png")
      acl_public = Custom("ACL Pública", "assets/acl.png")

      alb = ALB("ALB")

      with Cluster("Availability Zone 1a"):
        with Cluster("Subnet Pública (10.0.0.192/28 = 13 hosts)", graph_attr=cluster_font_style):
          with Cluster("Target Group", graph_attr=cluster_font_style):
            with Cluster("Frontend Server (10.0.0.195/28)", graph_attr=cluster_font_style):
              ec2_az1a_front = EC2("EC2")
              ebs_ec2_az1a_front = EBS("EBS")
              sg_ec2_az1a_front = Custom("Security Group", "assets/securityGroup.png")

              sg_ec2_az1a_front >> Edge() << ec2_az1a_front >> Edge() << ebs_ec2_az1a_front

          with Cluster("File Server (10.0.0.194/28)", graph_attr=cluster_font_style):
            efs = EFS("EFS")
            sg_efs = Custom("Security Group", "assets/securityGroup.png")

            sg_efs >> Edge() << efs
        with Cluster("Subnet Privada (10.0.0.224/28 = 13 hosts)", graph_attr=cluster_font_style):
          with Cluster("Backend Server (10.0.0.227/28)", graph_attr=cluster_font_style):
            ec2_az1a_back = EC2("EC2")
            ebs_ec2_az1a_back = EBS("EBS")
            sg_ec2_az1a_back = Custom("Security Group", "assets/securityGroup.png")

            sg_ec2_az1a_back >> Edge() << ec2_az1a_back >> Edge() << ebs_ec2_az1a_back
          with Cluster("Database Server (10.0.0.226/28)", graph_attr=cluster_font_style):
            ec2_az1a_db = EC2("EC2")
            ebs_ec2_az1a_db = EBS("EBS")
            sg_ec2_az1a_db = Custom("Security Group", "assets/securityGroup.png")

            sg_ec2_az1a_db >> Edge() << ec2_az1a_db >> Edge() << ebs_ec2_az1a_db
      with Cluster("Availability Zone 1b"):
        with Cluster("Subnet Pública (10.0.0.208/28 = 13 hosts)", graph_attr=cluster_font_style):
          with Cluster("Target Group", graph_attr=cluster_font_style):
            with Cluster("Frontend Server (10.0.0.211/28)", graph_attr=cluster_font_style):
              ec2_az1b_front = EC2("EC2")
              ebs_ec2_az1b_front = EBS("EBS")
              sg_ec2_az1b_front = Custom("Security Group", "assets/securityGroup.png")

              sg_ec2_az1b_front >> Edge() << ec2_az1b_front >> Edge() << ebs_ec2_az1b_front

      ebs_ec2_az1b_front >> Edge(style="invis") << sg_ec2_az1a_front
      s3_raw >> Edge(style="invis") << vpc

      acl_public >> Edge() << sg_ec2_az1a_front
      acl_public >> Edge() << sg_efs
      acl_public >> Edge() << sg_ec2_az1b_front
      route_table >> Edge() << acl_public
      route_table >> Edge() << alb
      alb >> Edge() << acl_public

      acl_private >> Edge() << sg_ec2_az1a_back
      acl_private >> Edge() << sg_ec2_az1a_db
      route_table >> Edge() << acl_private

  client = Client("Cliente")
  client >> internet_gateway >> vpc >> route_table
