# localenv

The purpose of this project is to help with local development by setting up an entire network of individually running local applications and any needed backing services

## Getting Started

These instructions will get you a copy of an example project up and running on your local machine for development

**NOTE**: The example application is defined in `configs/repos.json` and its source code can be found at [https://github.com/jroman00/localenv-example](https://github.com/jroman00/localenv-example)

**IMPORTANT**: For the rest of the installation, we will assume your company/account name is `acme`. **Please update any references below where appropriate**

## Prerequisites

The following programs are required in order for localenv to work as expected

  - [Docker Compose](https://docs.docker.com/compose/install/)
  - [jq](https://stedolan.github.io/jq/)

## Installation

The following installation steps will get an example application up and running without any additional configuration on your part. You may customize your application(s) later by following steps in the [Applications](#applications) section

### 1. Fork the Repo

Create a fork of [https://github.com/jroman00/localenv](https://github.com/jroman00/localenv)

### 2. Clone the Repo

```bash
git clone https://github.com/acme/localenv
```

### 3. Change Directory

Enter into the newly created `localenv` directory:

```bash
cd localenv
```

### 4. Initialize

```bash
bin/init
```

### 5. Enjoy!

The example application should now be running in the localenv ecosystem. To access it, please point your browser to [http://localhost:8080/](http://localhost:8080/)

## Configuration

### Applications

For demonstration purposes, an example application was preloaded, however, in order to take full advantage of localenv, you will need to update `configs/repos.json` with your own application names and URLs

Assuming your company/account name is `acme` and your application names are `foo` and `bar`, your `config/repos.json` would look like this:

```javascript
{
    "foo": {
        "git_url": "git@github.com:acme/foo.git"
    },
    "bar": {
        "git_url": "git@github.com:acme/bar.git"
    }
}
```

Each application that is being included in the localenv ecosystem should fulfill the following requirements:

- Contain a `docker-compose.yml` file with the following entry for a network:
    ```
      ...

      networks:
        localenv_network:
          external: true
    ```
- Contain the following scripts (**NOTE**: See the [example application bin scripts](https://github.com/jroman00/localenv-example/tree/master/bin) for examples):
  - `bin/local-init` - The script used to initialize the application (i.e. build the images, install dependencies, run migration scripts, and start the container via `docker-compose up -d`). This script is also where setting up database credentials should occur by using built-in utilities in localenv such as:
    - `bin/utils/setup-local-mysql-database`
    - `bin/utils/setup-local-postgres-database`
  - `bin/local-start` - The script used to start the application after it has already been initialized. This script may run anything necessary before starting a container and should at least contain `docker-compose up -d`)
  - `bin/local-stop` - The script used to stop the application after it has already been initialized. This script may run anything necessary before stopping a container and should at least contain `docker-compose stop -d`)

### Databases

Database names, images, and ports can be configured via `configs/global-databases-compose.yml`

### Cache

Cache server names, images, and ports can be configured via `configs/global-cache-compose.yml`

## Scripts

There are a handful of useful scripts to manage the network of applications in localenv

### Init

This will initialize the entire network of applications and is the first script to be run

```bash
bin/init
```

Running this script will:

- Clone all configured application repositories (See the [Applications](#applications) section below)
- Set up a docker network, namely `localenv_network`
- Initialize the databases (i.e. `mysql`, `postgres`)
- Initialize the cache servers (i.e. `redis`)
- Run each application's own implementation of a `bin/local-init` script

### Start

This will start the entire network of applications

```bash
bin/start
```

Running this script will:

- Start the databases (i.e. `mysql`, `postgres`)
- Start the cache servers (i.e. `redis`)
- Run each application's own implementation of a `bin/local-start` script

### Stop

This will stop the entire network of applications

```bash
bin/stop
```

Running this script will:

- Stop the databases (i.e. `mysql`, `postgres`)
- Stop the cache servers (i.e. `redis`)
- Run each application's own implementation of a `bin/local-stop` script

## Additional Customization

### Avoiding the Use of localhost

During local development, you may want to avoid using `localhost` and instead use custom URLs. If that is the case, simply update your `/etc/hosts` file. For example:

```bash
127.0.0.1 localenv-example.it
```

Remember that you will still need to include the port. In this case, you can visit [http://localenv-example.it:8080/](http://localenv-example.it:8080/)
