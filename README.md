# localenv

The purpose of this project is to set up an entire network of individually running local applications

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development

### Prerequisites

- [Docker Compose](https://docs.docker.com/compose/install/)

### Installation

#### 1. Clone the Repo

```
git clone https://github.com/jmieleiii/localenv
```

#### 2. Change Directory

Enter into the newly created `localenv` directory:

```
cd localenv
```

#### 3. Initialize

```
bin/init
```

#### 4. Enjoy!

Each defined application (See [Configuration](#configuration) section below), if set up properly, should now be running on the localenv network

## Scripts

There are a handful of useful scripts to manage the network of application in localenv

### Init

This will initialize the entire network of applications and is the first script to be run

```
bin/init
```

Running this script will:

- Clone all configured application repositories (See [Configuration](#configuration) section below)
- Set up a docker network, namely `localenv_network`
- Initialize the databases (i.e. `mysql`, `postgres`)
- Initialize the cache servers (i.e. `redis`)
- Run each application's own implementation of a `bin/local-init` script

### Start

This will start the entire network of applications

```
bin/start
```

Running this script will:

- Start the databases (i.e. `mysql`, `postgres`)
- Start the cache servers (i.e. `redis`)
- Run each application's own implementation of a `bin/local-start` script

### Stop

This will stop the entire network of applications

```
bin/stop
```

Running this script will:

- Stop the databases (i.e. `mysql`, `postgres`)
- Stop the cache servers (i.e. `redis`)
- Run each application's own implementation of a `bin/local-stop` script

## Configuration

### Application Repositories

The list of individual applications to manage can be configured via `configs/repos.json`

### Databases

Databases can be configured via `configs/global-databases-compose.yml`

### Cache

Cache servers can be configured via `configs/global-cache-compose.yml`
