#!/bin/bash

# Wait for SQL Server to be available
echo "Waiting for SQL Server to start..."
until /opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P 'Password!' -Q "SELECT 1" &> /dev/null; do
    echo "SQL Server is not ready yet. Sleeping for 5 seconds..."
    sleep 5
done

echo "SQL Server is up. Running initialization script..."
/opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P 'Password!' -d master -i init_PurchaseMain.sql