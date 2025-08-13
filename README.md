# Grupo-4-2CCOA/infra
Pasta para armazenar os códigos de Infraestrutura

## Diagramas
Para visualizar os diagramas, é recomendado o uso da ferramenta `pipenv`, que isola seu ambiente de desenvolvimento e abstrai a criação desse ambiente.

### Como instalar o pipenv
Com o python e o pip já instalados, digite o seguinte comando no terminal e pressione <kbd>Enter</kbd>:
```bash
pip install --user pipenv
```

### Como rodar o arquivo diagrama.py (atualizar o diagrama)
Com o `pipenv` baixado, abra **O DIRETÓRIO DO REPOSITÓRIO** na linha de comando por meio do comando `cd`:
```bash
cd <diretorio-do-repositorio>
```
Depois disso, use este comando para baixar as dependências e atualizar o diagrama
```bash
pipenv install
pipenv run python diagrama.py
```
