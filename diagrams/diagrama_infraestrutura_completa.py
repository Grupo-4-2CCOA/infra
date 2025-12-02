from diagrams import Cluster, Diagram, Edge
from diagrams.custom import Custom
from diagrams.aws.compute import EC2, Lambda
from diagrams.aws.storage import EBS, EFS, S3
from diagrams.aws.network import VPC, ALB, IGW, NATGateway, RouteTable
from diagrams.aws.general import Client
from diagrams.aws.integration import SNS
from diagrams.aws.management import Cloudwatch, CloudwatchAlarm
from diagrams.aws.analytics import Glue, Athena
from diagrams.onprem.database import Mysql
from diagrams.programming.language import Java

diagram_font_style = {
    "labelloc": "t",
    "fontname": "Helvetica Bold",
    "fontsize": "50px",
}
cluster_font_style = {
    "labelloc": "t",
    "fontname": "Helvetica Bold",
    "fontsize": "25px",
}
node_font_style = {
    "labelloc": "b",
    "fontname": "Helvetica",
    "fontsize": "12px",
}

with Diagram("Infraestrutura Completa - Beauty Barreto", show=False, 
             direction="TB", node_attr=node_font_style, graph_attr=diagram_font_style):
    
    # Cliente
    client = Client("Cliente")
    
    with Cluster("AWS Cloud", graph_attr=cluster_font_style):
        
        # Internet Gateway
        igw = IGW("Internet Gateway")
        
        # S3 Buckets
        with Cluster("S3 Storage", graph_attr=cluster_font_style):
            s3_raw = S3("Raw\nbeauty-barreto-raw")
            s3_trusted = S3("Trusted\nbeauty-barreto-trusted")
            s3_client = S3("Client\nbeauty-barreto-client")
            s3_backup = S3("Backup\nbeauty-barreto-backup")
        
        # Lambda Functions
        with Cluster("Lambda Functions", graph_attr=cluster_font_style):
            lambda_holiday = Lambda("Treat Holiday\nData")
            lambda_schedule = Lambda("Treat Schedule\nData")
            lambda_weather = Lambda("Treat Weather\nData")
            lambda_flattened = Lambda("Create Flattened\nFile")
        
        # Glue e Athena
        with Cluster("Data Processing", graph_attr=cluster_font_style):
            glue = Glue("Glue Crawler\n& Catalog")
            athena = Athena("Athena\nQueries")
        
        # CloudWatch
        with Cluster("Monitoring", graph_attr=cluster_font_style):
            cloudwatch = Cloudwatch("CloudWatch\nLogs & Metrics")
            alarm = CloudwatchAlarm("CloudWatch\nAlarms")
            sns = SNS("SNS\nNotifications")
            cloudwatch >> alarm >> sns
        
        # VPC
        with Cluster("VPC (10.1.0.0/26)", graph_attr=cluster_font_style):
            vpc = VPC("VPC")
            
            # Route Tables
            rtb_default = RouteTable("Route Table\nDefault (Public)")
            rtb_private = RouteTable("Route Table\nPrivate")
            
            # NAT Gateway
            nat_gateway = NATGateway("NAT Gateway\nAZ1a")
            
            # Load Balancer
            alb = ALB("Application\nLoad Balancer")
            
            # ACLs
            acl_public = Custom("ACL Pública", "assets/acl.png")
            acl_private = Custom("ACL Privada", "assets/acl.png")
            
            # Availability Zone 1a
            with Cluster("Availability Zone 1a", graph_attr=cluster_font_style):
                
                # Subnet Pública AZ1a
                with Cluster("Subnet Pública\n(10.1.0.0/28)", graph_attr=cluster_font_style):
                    with Cluster("Frontend Server", graph_attr=cluster_font_style):
                        ec2_az1a_pub = EC2("EC2 Frontend\nNginx")
                        ebs_az1a_pub = EBS("EBS 8GB")
                        sg_web = Custom("SG Web", "assets/securityGroup.png")
                        sg_remote = Custom("SG Remote", "assets/securityGroup.png")
                        sg_efs = Custom("SG EFS", "assets/securityGroup.png")
                        
                        ec2_az1a_pub >> ebs_az1a_pub
                        sg_web >> ec2_az1a_pub
                        sg_remote >> ec2_az1a_pub
                        sg_efs >> ec2_az1a_pub
                
                # Subnet Privada AZ1a
                with Cluster("Subnet Privada\n(10.1.0.32/28)", graph_attr=cluster_font_style):
                    
                    # Backend Server
                    with Cluster("Backend Server\nIP: 10.1.0.36", graph_attr=cluster_font_style):
                        ec2_az1a_pri = EC2("EC2 Backend\nSpring Boot")
                        ebs_az1a_pri = EBS("EBS 8GB")
                        sg_private = Custom("SG Private", "assets/securityGroup.png")
                        java_app = Java("Spring Boot\nAPI :8080")
                        rabbitmq = Custom("RabbitMQ\n:5672, :15672", "assets/securityGroup.png")
                        
                        ec2_az1a_pri >> ebs_az1a_pri
                        sg_private >> ec2_az1a_pri
                        ec2_az1a_pri >> java_app
                        ec2_az1a_pri >> rabbitmq
                    
                    # Database Server
                    with Cluster("Database Server\n(10.1.0.41)", graph_attr=cluster_font_style):
                        ec2_az1a_db = EC2("EC2 Database\nMySQL")
                        ebs_az1a_db = EBS("EBS 24GB")
                        mysql = Mysql("MySQL\n:3306")
                        
                        ec2_az1a_db >> ebs_az1a_db
                        sg_private >> ec2_az1a_db
                        ec2_az1a_db >> mysql
                
                # EFS Mount Target AZ1a
                efs_mount_az1a = EFS("EFS Mount\nTarget AZ1a")
            
            # Availability Zone 1b
            with Cluster("Availability Zone 1b", graph_attr=cluster_font_style):
                
                # Subnet Pública AZ1b
                with Cluster("Subnet Pública\n(10.1.0.16/28)", graph_attr=cluster_font_style):
                    with Cluster("Frontend Server", graph_attr=cluster_font_style):
                        ec2_az1b_pub = EC2("EC2 Frontend\nNginx")
                        ebs_az1b_pub = EBS("EBS 8GB")
                        
                        ec2_az1b_pub >> ebs_az1b_pub
                        sg_web >> ec2_az1b_pub
                        sg_remote >> ec2_az1b_pub
                        sg_efs >> ec2_az1b_pub
                
                # EFS Mount Target AZ1b
                efs_mount_az1b = EFS("EFS Mount\nTarget AZ1b")
            
            # Availability Zone 1c
            with Cluster("Availability Zone 1c", graph_attr=cluster_font_style):
                
                # Subnet Pública AZ1c
                with Cluster("Subnet Pública\n(10.1.0.48/28)", graph_attr=cluster_font_style):
                    with Cluster("Monitoring Server", graph_attr=cluster_font_style):
                        ec2_az1c_pub = EC2("EC2 Grafana")
                        ebs_az1c_pub = EBS("EBS 8GB")
                        
                        ec2_az1c_pub >> ebs_az1c_pub
                        sg_remote >> ec2_az1c_pub
                
                # EFS Mount Target AZ1c
                efs_mount_az1c = EFS("EFS Mount\nTarget AZ1c")
            
            # EFS File System
            efs = EFS("EFS File System\nEncrypted")
            efs >> efs_mount_az1a
            efs >> efs_mount_az1b
            efs >> efs_mount_az1c
            
            # Conexões de Rede
            igw >> rtb_default
            rtb_default >> acl_public
            acl_public >> alb
            alb >> ec2_az1a_pub
            alb >> ec2_az1b_pub
            
            rtb_private >> nat_gateway
            nat_gateway >> rtb_default
            acl_private >> rtb_private
            
            # Conexões entre instâncias
            ec2_az1a_pub >> Edge(label=":8080", style="dashed") >> ec2_az1a_pri
            ec2_az1b_pub >> Edge(label=":8080", style="dashed") >> ec2_az1a_pri
            ec2_az1a_pri >> Edge(label=":3306", style="dashed") >> ec2_az1a_db
            
            # EFS connections
            ec2_az1a_pub >> Edge(style="dotted") >> efs_mount_az1a
            ec2_az1b_pub >> Edge(style="dotted") >> efs_mount_az1b
        
        # Conexões Cliente -> Internet
        client >> igw >> alb
        
        # Conexões Lambda -> S3
        lambda_holiday >> Edge(label="Process") >> s3_raw
        lambda_holiday >> Edge(label="Write") >> s3_trusted
        lambda_schedule >> Edge(label="Process") >> s3_raw
        lambda_schedule >> Edge(label="Write") >> s3_trusted
        lambda_weather >> Edge(label="Process") >> s3_raw
        lambda_weather >> Edge(label="Write") >> s3_trusted
        lambda_flattened >> Edge(label="Read") >> s3_trusted
        lambda_flattened >> Edge(label="Write") >> s3_client
        
        # Conexões Glue/Athena -> S3
        glue >> Edge(label="Crawl") >> s3_client
        athena >> Edge(label="Query") >> s3_client
        
        # Conexões CloudWatch -> EC2
        cloudwatch >> Edge(style="dotted") >> ec2_az1a_pub
        cloudwatch >> Edge(style="dotted") >> ec2_az1b_pub
        cloudwatch >> Edge(style="dotted") >> ec2_az1a_pri
        cloudwatch >> Edge(style="dotted") >> ec2_az1a_db
        cloudwatch >> Edge(style="dotted") >> ec2_az1c_pub
        
        # Backup connections
        ec2_az1a_db >> Edge(label="Backup", style="dotted") >> s3_backup

