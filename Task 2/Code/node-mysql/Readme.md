# Run Code Manually

## Prerequisites

- Need to have docker installed
- Need to have node running

## Start Database

```
docker run --name mysql-container-test   -e MYSQL_ROOT_PASSWORD=my-secret-pw   -e MYSQL_DATABASE=mydatabase   -d -p 3307:3306   -v mysql_data:/var/lib/mysql   mysql:latest

```
## Install dependencies

```
npm i
```

## Run Code Manually

```
npm start
```

## Run Tests

```
npm test
```

