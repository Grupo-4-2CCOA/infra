# Grupo-4-2CCOA/infra
Pasta para armazenar os códigos de Infraestrutura

## Diagramas
Para visualizar os diagramas, é recomendado o uso da ferramenta `pipenv`, que isola seu ambiente de desenvolvimento e abstrai a criação desse ambiente.

### Como instalar o pipenv
Com o python e o pip já instalados, caso queira atualizar o pip, rode o seguinte comando:
```bash
python -m pip install --upgrade pip
```
Agora digite o seguinte comando no terminal e pressione <kbd>Enter</kbd>:
```bash
python -m pip install --user pipenv
```

### Como rodar o arquivo diagrama.py
O programa irá atualizar o diagrama de acordo com o script.
Usando o `pipenv`, abra o **DIRETÓRIO DO REPOSITÓRIO** no terminal por meio do comando `cd`:
```bash
cd <caminho-para-o-diretorio-do-repositorio>
```
Depois disso, use este comando para baixar as dependências e atualizar o diagrama
```bash
python -m pipenv install
python -m pipenv run python diagrama.py
```
