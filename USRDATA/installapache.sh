#!/bin/bash
set -e

if command -v apt-get >/dev/null 2>&1; then
	apt-get update -y
	DEBIAN_FRONTEND=noninteractive apt-get install -y apache2
	systemctl enable --now apache2
elif command -v dnf >/dev/null 2>&1; then
	dnf install -y httpd
	systemctl enable --now httpd
elif command -v yum >/dev/null 2>&1; then
	yum install -y httpd
	systemctl enable --now httpd
else
	echo "No supported package manager found" >&2
	exit 1
fi

echo "<h1>Hello world from Terraform</h1>" > /var/www/html/index.html