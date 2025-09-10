from diagrams import Diagram, Cluster, Edge, Node
from diagrams.custom import Custom
from diagrams.aws.general import General
from diagrams.onprem.container import Docker
from diagrams.onprem.database import Mysql
from diagrams.onprem.compute import Server
from diagrams.programming.language import Java
from diagrams.programming.framework import React
from diagrams.onprem.client import Client

with Diagram("Desenho da solução", show=False, direction="LR"):
    
    with Cluster("AWS"):
        with Cluster("Docker1"):
            with Cluster("Servidor Privado"):
                mysql = Mysql("MySQL")
                java = Java("Java App")
                

                mysql - Edge(label="Conexão Interna") - java
                
        with Cluster("Docker2"):
            with Cluster("Servidor Público"):
                react = React("Frontend React")
                

    # Integração Google Agenda
    gcalendar = Custom("Google agenda", "googleCalendar.png")

    # Usuários
    cliente = Client("Cliente")
    admin = Client("Administrador")
    beneficiario = Client("Beneficiário")

    # Conexões
    react >> Edge(color="green", label="Acesso") >> cliente
    react >> Edge(color="green", label="Acesso") >> admin
    react >> Edge(color="green", label="Acesso") >> beneficiario

    java >> Edge(color="blue", style="dashed", label="Interno") >> react
    gcalendar >> Edge(color="blue", label="Integração") >> react
