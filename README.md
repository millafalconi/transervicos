# Transerviços
---------------------
[![Stories in Ready](https://badge.waffle.io/ThoughtWorksInc/transervicos.png?label=ready&title=Ready)](https://waffle.io/ThoughtWorksInc/transervicos)
[![Build Status](https://snap-ci.com/ThoughtWorksInc/transervicos/branch/master/build_image)](https://snap-ci.com/ThoughtWorksInc/transervicos/branch/master)

## Primeiros passos

### Fazendo setup do projeto

Para setup completo da aplicação, são necessários:
1. Virtual Box
2. Vagrant
3. Ansible, a partir da versão 1.9
4. Plugins do Vagrant:
4.1. Vagrant cashier
4.2. Vagrant  vbguest

Disponibilizamos uma dev-cli para setup rápido da aplicação.

#### Usando a dev-cli

1. Pelo terminal, vá para a pasta do projeto (`$ cd caminho_do_projeto`)
2. Na raíz do projeto, onde está o arquivo `trans.d`, execute:
`./trans setup install` e siga as instruções

#### Fazendo Setup Manual

##### Instalando o Vagrant e o Ansible

1. Instale o [Ansible](http://www.ansible.com "ansible") **a partir da versão 1.9**
2. Instale o [Vagrant](http://www.vagrantup.com/ "vagrant")
3. Instale o [VirtualBox](https://www.virtualbox.org/wiki/Downloads "virtualbox")

#### Instalando o Vagrant Cashier

O Cashier é um plugin para o Vagrant que permite a utilização de cache de provisionamente, permitindo maior rapidez ao efetuar futuros provisionamentos.

1. No terminal, vá para o diretório onde se encontra o projeto (`$ cd caminho_do_projeto`)
2. Na raíz do projeto (ou na pasta onde se encontra o arquivo Vagrantfile) execute o seguinte comando:
`vagrant plugin install vagrant-cachier`

### O Vagrant: Provisionando e Utilizando

#### Provisionando o vagrant

Para efetuar o provisionamento, execute os seguintes comandos:

1. `cd caminho_do_projeto`
2. `vagrant up --no-provision`
3. `vagrant provision` (A primeira execução será um pouco lenta)

#### Utilizando o Vagrant

Para utilizar o Vagrant, execute os seguintes comandos:

1. `cd caminho_do_projeto`
2. `vagrant up`
3. `vagrant ssh` (entra na máquina e abre o terminal do Linux)
4. `cd /vagrant/transervicos`
5. `rake db:migrate db:seed server:start` (roda migrações, popula tabelas essenciais e inicia o servidor)
6. Abra seu browser e acesse `http:localhost:8000`

### Setup do banco de dados

A estrutura do banco de dados é configurada por migrações, que são executadas após o provisionamento da máquina virtual. Veja no tópico anterior, o passo 5:
- `db:migrate` - para migrações;
- `db:seed` - para popular as tabelas necessárias para iniciar a aplicação

#### Criando um usuário admin

Para execução da aplicação, é preciso a criação de um usuário administrador. Para tal,
1. Execute o comando `rails c`
2. Insira o comando `us = User.create(password: 'password',password_confirmation: 'password',email: <email>,social_name: <nome>,civil_name: <nome>,birth_date: 20.years.ago,username: <usuario>,phone_number: "12346789",name_preference: User::SOCIAL_NAME_PREFERENCE)`
3. Configure o usuário criado acima como administrador: `us.admin = true`
4. Salve o usuário no banco de dados: `us.save`

Na aplicação que está rodando no seu browser em (http://localhost:8000):
1. Faça login com o novo usuário criado;
2. Visite `http://localhost:8000/admin`

Em caso de erro, no terminal, execute para ter acesso às mensagens de erro: `us.errors.full_messages`.

### Testes
- Temos três diferentes níveis de testes: 1. Testes unitários; 2. Testes unitários de UI (Javascript); além do analisador de código ruby.

Para execução de comandos de testes:
1. Na raiz do projeto, logue na máquina virtual via ssh: `vagrant ssh`;
2. Vá até o diretório do projeto na máquina virtual: `cd /vagrant/transervicos`;

#### Para rodar os testes unitários de ruby

1. `rake spec`

#### Para rodar os testes unitários de Javascript

1. `grunt karma`

#### Analisar o código de ruby

1. `rubocop`
