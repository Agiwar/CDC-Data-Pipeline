#!/bin/bash

sleep 30s
/opt/mssql-tools/bin/sqlcmd -S sqlserver -U sa -P 'Password!' -d master -i init_PurchaseMain.sql