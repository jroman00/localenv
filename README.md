# localenv

The purpose of this project is to set up an entire network of individually running local applications

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development

## Prerequisites

- **Programs**: The following programs are required in order for localenv to work as expected
    - [Docker Compose](https://docs.docker.com/compose/install/)
    - [jq](https://stedolan.github.io/jq/)
- **Applications**: Each application that's being included should fulfill the following requirements:
    - Contain a `docker-compose.json` file with the following entry for a network:
    ```
      networks:
        localenv_network:
          external: true
    ```
    - Contain the following scripts:
        - `bin/local-init` - The script used to initialize the application (i.e. build the images, install dependencies, run migration scripts, and start the container via `docker-compose up -d`). This script is also where setting up database credentials should occur by using built-in utilities in localenv such as:
            - `bin/utils/setup-local-mysql-database`
            - `bin/utils/setup-local-postgres-database`
        - `bin/local-start` - The script used to start the application after it's already been initialized. This script should at least contain `docker-compose up -d`)
        - `bin/local-stop` - The script used to stop the application after it's already been initialized. This script should at least contain `docker-compose stop -d`)

## Configuration

### Databases

Databases can be configured (e.g. image, ports) via `configs/global-databases-compose.yml`

### Cache

Cache servers can be configured (e.g. image, ports) via `configs/global-cache-compose.yml`

## Installation

### 1. Fork the Repo

Create a fork of [https://github.com/jroman00/localenv](https://github.com/jroman00/localenv). For the rest of the installation, we'll assume your company/account name is `acme` and your one application is `foo`. **Please update any references below where appropriate**

### 2. Clone the Repo

```
git clone https://github.com/acme/localenv
```

### 2. Change Directory

Enter into the newly created `localenv` directory:

```
cd localenv
```

### 3. Configure Your Application Repositories

Update `configs/repos.json` with your application names and URLs

For example:

```
{
    "foo": {
        "git_url": "git@github.com:acme/foo.git"
    }
}
```

### 4. Initialize

```
bin/init
```

### 5. Enjoy!

Each defined application (See [Prerequisites](#prerequisites) section above), if set up properly, should now be running on the localenv network

## Scripts

There are a handful of useful scripts to manage the network of applications in localenv

### Init

This will initialize the entire network of applications and is the first script to be run

```
bin/init
```

Running this script will:

- Clone all configured application repositories (See [Prerequisites](#prerequisites) section below)
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
