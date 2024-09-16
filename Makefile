.PHONY: all start_containers register_connectors install_dbt_packages build_dbt_project

# Variables
COMPOSE_FILE = docker-compose.yml
CONNECTORS_URL = http://localhost:8083/connectors/
HEADERS = -H "Accept:application/json" -H "Content-Type:application/json"

# JSON Files for connector registrations
SQLSERVER_APICURIO_JSON = debezium/connector-registration/register-sqlserver-apicurio-converter-avro.json
MYSQL_APICURIO_JSON = debezium/connector-registration/register-mysql-apicurio-converter-avro.json
CLICKHOUSE_SINK_SQLSERVER_JSON = debezium/connector-registration/register-clickhouse-sink-sqlserver.json
CLICKHOUSE_SINK_MYSQL_JSON = debezium/connector-registration/register-clickhouse-sink-mysql.json

all: start_containers register_connectors install_dbt_packages build_dbt_project

start_containers:
	docker compose -f $(COMPOSE_FILE) up -d
	$(call wait_for,10)

# Define a function for making curl POST requests to register connectors
define register_connector
	@echo "Registering connector: $(1)"
	curl -i -X POST $(HEADERS) $(CONNECTORS_URL) -d @$(2)
	$(call wait_for,5)
endef

# Register all connectors
register_connectors: register_sqlserver_apicurio_converter register_mysql_apicurio_converter register_clickhouse_sink_sqlserver register_clickhouse_sink_mysql

register_sqlserver_apicurio_converter:
	$(call register_connector,SQL Server Apicurio Converter,$(SQLSERVER_APICURIO_JSON))

register_mysql_apicurio_converter:
	$(call register_connector,MySQL Apicurio Converter,$(MYSQL_APICURIO_JSON))

register_clickhouse_sink_sqlserver:
	$(call register_connector,ClickHouse Sink for SQL Server,$(CLICKHOUSE_SINK_SQLSERVER_JSON))

register_clickhouse_sink_mysql:
	$(call register_connector,ClickHouse Sink for MySQL,$(CLICKHOUSE_SINK_MYSQL_JSON))

install_dbt_packages:
	docker exec -it dbt dbt deps
	$(call wait_for,5)

build_dbt_project:
	docker exec -it dbt dbt build

# Helper function for waiting
define wait_for
	@echo "Waiting for $(1) seconds..."
	sleep $(1)
endef