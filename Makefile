.PHONY: all start_containers register_sqlserver register_mysql register_clickhouse_sqlserver register_clickhouse_mysql dbt_deps dbt_build

all: start_containers register_sqlserver register_mysql register_clickhouse_sqlserver register_clickhouse_mysql dbt_deps dbt_build

start_containers:
	docker compose -f docker-compose.yml up -d
	sleep 120

register_sqlserver:
	curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ -d @debezium/connector-config/register-sqlserver-apicurio-converter-avro.json
	sleep 30

register_mysql:
	curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ -d @debezium/connector-config/register-mysql-apicurio-converter-avro.json
	sleep 30

register_clickhouse_sqlserver:
	curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ -d @debezium/connector-config/register-clickhouse-sink-sqlserver.json
	sleep 120

register_clickhouse_mysql:
	curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ -d @debezium/connector-config/register-clickhouse-sink-mysql.json
	sleep 60

dbt_deps:
	docker exec -it dbt dbt deps
	sleep 30

dbt_build:
	docker exec -it dbt dbt build
