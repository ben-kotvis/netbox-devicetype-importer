#yes password | passwd vscode
adduser vscode sudo

service postgresql restart

sudo -i -u postgres bash << EOF
psql -c "CREATE DATABASE netbox;"
psql -c "CREATE USER netbox WITH PASSWORD 'FxHZsQCr6s3qj6EK';"
psql -c "ALTER DATABASE netbox OWNER TO netbox;"
psql -c "GRANT CREATE ON SCHEMA public TO netbox;"
EOF

sudo -i -u vscode bash << EOF
redis-cli config set requirepass 'FxHZsQCr6s3qj6EK'
EOF
