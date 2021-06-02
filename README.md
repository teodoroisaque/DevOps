# DevOps

- Pensei em uma alta disponibilidade, escalabilidade e redundância, todo o projeto foi desenvolvido na AWS, de inicio pensei em usar o Ubuntu mas me lembrei que as imagens para containers full possuem várias vulnerabilidades, sendo assim fiz um build da api disponibilizada utilizando o Alpine, uma imagem bem exuta.

- Primeiramente fiz os testes com a api no Alpine que se encontra "DevOps/esx_app/Dockerfile", após concluir os testes com a api com sucesso, montei o código do terraform.

# Infraestrutura

## VPC
- Pensando em alta disponibilidade, escalabilidade e redundância, criei uma vpc com 6 subnets sendo 3 publicas e 3 privadas, uma em cada AZ da AWS, pensando na segurança do ambiente e nas melhores práticas, para as subnets públicas foi criado um internet gateway, e para as vpc privadas foi criado um nat gateway, utilizando um Module Community do terraform.

## EC2
- Criei um módulo padrão para as ec2 "DevOps/terraform/modules/ec2/", assim podendo trabalhar com mais facilidade e flexibilidade no arquivo esx.tf, trabalhando com as váriaveis de ambiente, a intenção foi ter autonomia para lançar máquinas em qualquer AZ pública ou privada atravez do módulo.

## DYNAMODB
- Foi usado uma table do dynamodb para fazer um lock no state do terraform nos momentos de uso para não gerar conflitos em um ambiente com vários colaboradores.

## S3
- Criado um bucket s3 para armazenar nosso statefile de forma remota para não gerar conflitos com os deploys do terraform se ficasse localmente.

# TERRAFORM
- Disponibilizei o Dockerfile da imagem que uso para trabalhar localmente com o terraform de uma forma mais ágil "DevOps/terraform/Dockerfile"

- No terraform procurei diversificar o máximo possível do uso da ferramenta utilizando modulos community (vpc), módulos que criei (ec2), interpolações nos nomes aplicados, utilizando data, resources, outputs e claro variáveis de ambiente.

# ANSIBLE
- Utilizei o ansible para fazer a instalação de todos os componentes necessários para subir a imagem com a api que criei, o ansible instalada o docker, docker-compose, após esses processos é somente iniciar o docker swarm para funcionar o cluster, **optei em não utilizar ECS** para poder utilizar o ansible nesse momento e uma possível instalação de agents do Zabbix para monitorar os servidores.
'''
https://github.com/teodoroisaque/DevOps/blob/master/ansible/install_docker/tasks/main.yml
'''
![ev_ansible](https://user-images.githubusercontent.com/42479203/120551761-c6252580-c3cc-11eb-965f-522ae083c84c.jpeg)



# CI/CD
- Para o ci/cd no início pensei em usar o Jenkins, mas como não sei se será necessário aprensetar o teste todo, mudei para o github utilizando actions

'''
https://github.com/teodoroisaque/DevOps/actions
'''

- Na primeira action  possível acompanhar a criação toda com o terraform a partir do Pull Request e o Merge, tudo foi criado, para efeitos de testes simulei um erro com o terraform fmt -check, analisando a sintaxe do código, o erro a seguir eu havia removido a access key e secret key da aws, após esses erros foi possível adicionar o lock no state como era o foco.

- No CI/CD utilizei os steps de melhores práticas do github, última versão do ubuntu, checkout, setup do terraform, faço uma validação do código com o teraform fmt, e também se caso no terraform plan o status for 'FAILURE' o deploy não é realizado segue:

'''
https://github.com/teodoroisaque/DevOps/blob/master/.github/workflows/esx-ci-cd.yml#L50
'''


# IMAGEM COM A API
- Para facilitar o uso com os containers realizei um build da imagem e em seguid disponibilizei no docker hub, seria ideal um registry próprio para versionamentos das imagens também.

'''
https://hub.docker.com/r/isaqueteodoro/esx
'''
- Segue uma evidência do funcionamento da imagem buildada com a api em funcionamento:
![ev_api](https://user-images.githubusercontent.com/42479203/120552719-f620f880-c3cd-11eb-8cee-912f0c8ccffa.jpeg)

- Ao lado esquerdo é possível notar a consulta aos cometários realizados, e ao lado direito o log da api, para facilitar na hora do teste elaborei um simples Shell Script para auxiliar. Primeiramente eu forço o 404 com um GET, e após os POST, eu retorno o resultado como evidenciado.
 
'''
https://github.com/teodoroisaque/DevOps/blob/master/esx_app/teste.sh
'''


# MONITORIA E MÉTRICAS
- Para monitorias e métricas utilizo cloudwatch e zabbix digamos que como "backend" e o Grafana como "frontend".

![ev_grafana](https://user-images.githubusercontent.com/42479203/120553431-dd651280-c3ce-11eb-8d2c-9ba394c14a15.jpeg)

- Assim podendo ter uma visão unificada de ambas monitorias, criando dashboards personalizadas.

![ev_dash](https://user-images.githubusercontent.com/42479203/120553781-4ba9d500-c3cf-11eb-9ad9-defbf7cb22a8.jpeg)

- Também podendo criar webscenarios para monitoriar urls e disponibilidade das api e páginas web, sem custo adicional.

O exemplo a seguir, se a url da api retornar o status 200 tudo OK, se caso mudar de status o zabbix alerta e atravez de uma webhook envia mensagens. (Slack, Google Chat, etc)

![ev_webscenario](https://user-images.githubusercontent.com/42479203/120554083-b4914d00-c3cf-11eb-82c5-89e2eaa797e7.jpeg)

Segue evidência do envio do alerta.

![ev_alerta](https://user-images.githubusercontent.com/42479203/120554370-0a65f500-c3d0-11eb-8ecc-aab14d9c216d.jpeg)

- No alerta é possível ver rapidamente o um problema ou o recovery da trigger, o tempo de downtime e a severidade da problema.

# CONCLUSÃO

- Eu utilizaria instâncias reservadas da aws para reduzir custos (No upfront ou Upfront) dependendo do budget diponível, utilizaria também se possível o data center da Virgina, pois toda inovação da AWS é primeiramente disponibilizada nesse data center, depois migram para os outros, pensei em uma arquitetura resiliente, escalável e tolerante a falhas com alta disponibilidade (3 AZS), uma arquitetura modular onde é possível trabalhar com micro serviços em containers, utilizei o docker swarm, mas poderiamos utilizar também o Kubernetes o importante é utilizarmos cluster, para acesso as subnets privadas é imporante uma vpn site to site, ou um bastion host em uma subnet publica, com a vpn o acesso fica muito mais fácil.


