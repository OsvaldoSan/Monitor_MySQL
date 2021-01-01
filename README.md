# Uso de servidor web
Para que se ejecute el servidor web se requiere que se inicialice *firewalld* con `systemctl start firewalld` y se añada a la lista de 
servicios web permitidos http con `firewall-cmd --permanent --add-service=http` y por supuesto tener activo el servicio de *httpd*

# Ejecución de Monitor
Se requiere que se activen unas banderas en Mariadb para que ejecute el historial de queries.
- `SET GLOBAL general_log_file="/var/run/mariadb/mariadb_query.log" `
- `SET GLOBAL general_log="ON"`
Activando esas dos variables se podra acceder al historial de consultas.

## Ejecución de Monitor como cron job
La ejecución recomendad es la configuración: `* * * * * /ruta/monitor.sh`, pues se quiere estar supervisandlo en todo momento.
Como recordartorio un cron job se añade con `crontab -e` y para ver los que estan activos se usa `crontab -l`

