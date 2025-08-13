from diagrams import Cluster, Diagram, Edge
from diagrams.onprem.database import Mysql

with Diagram("Arquitetura de Rede", show=False):
  database = Mysql("Banco de dados")
