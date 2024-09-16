.PHONY: all \
        start_containers \
        register_sqlserver_apicurio_converter \
        register_mysql_apicurio_converter \
        register_clickhouse_sink_sqlserver \
        register_clickhouse_sink_mysql \
        install_dbt_packages \
        build_dbt_project

start_containers:
	docker compose -f docker-compose.yml up -d
	sleep 10

register_sqlserver_apicurio_converter:
	curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ -d @debezium/connector-registration/register-sqlserver-apicurio-converter-avro.json
	sleep 5

register_mysql_apicurio_converter:
	curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ -d @debezium/connector-registration/register-mysql-apicurio-converter-avro.json
	sleep 5

register_clickhouse_sink_sqlserver:
	curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ -d @debezium/connector-registration/register-clickhouse-sink-sqlserver.json
	sleep 5

register_clickhouse_sink_mysql:
	curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ -d @debezium/connector-registration/register-clickhouse-sink-mysql.json
	sleep 5

install_dbt_packages:
	docker exec -it dbt dbt deps
	sleep 5

build_dbt_project:
	docker exec -it dbt dbt build
