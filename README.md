# CDC Data-Pipeline

## Concept
To overcome data incorrectness and inconsistency issue when doing data report, developing this Change Data Capture (CDC) system to make sure the data in data warehouse is available.

### Data Sourcing
Use `Debezium` to capture any row-level DML operations (INSERT, UPDATE, and DELETE) in databases, and then the data is streamed into `Kafka` topics.

Where
+ Data Sources:
    - `MySQL`
    - `SQL Server`
+ Data Warehouse:
    - `ClickHouse`

The CDC data is consumed from `Kafka` into `ClickHouse` via `clickhouse-kafka-connect`.

To reduced network congestion and faster data transmission times, the CDC data is serialized from `JSON` to `Avro`. Before CDC data consumed, these data will be deserialized where its schema is registered on `Apicurio`.

### Data Transformation
Avoid always hardcoding SQL code, use `dbt` tool to do data transformation. With dbt model, this process is more secure and easily to maintain.

## Usage
+ Prerequisites
    + Docker
    + docker compose
    + Install Rosetta 2 (if not already installed) for Mac with Apple Silicon chip.

1. Clone repo to your machine
```bash
git clone https://github.com/Agiwar/CDC-Data-Pipeline.git
```

2. Go to `CDC-Data_pipeline`.
```bash
cd CDC-Data-Pipeline
```

3. run service

    The Makefile includes the followings:
    
    (1). Build the required images (`Debezium` & `dbt`) and start the services below;

    - zookeeper
    - kafka
    - kafka-ui
    - apicurio
    - debezium
    - sqlserver
    - sqlcmd (it's for Sql Server initialization)
    - mysql
    - clickhouse
    - tabix (it's an web interface for ClickHouse)
    - dbt
    
    (2). Register `SQL Server` & `MySQL` connector to monitor LSN in SQL Server and binlog in MySQL, respectively.

    (3). Register the kafka connect for `ClickHouse` to load data from kafka.

    (4). Install the required dbt packages.

    (5). Build dbt project, this includes running dbt model and doing testing it.

```bash
make all
```

<!-- ## Diagram
![CDC Data Pipeline](data-pipeline-diagram/data-pipeline-diagram.jpg) -->
