# Ejecución de respald.sh con cron, el guion medio indica que debes colocar un valor de tu preferencia
- Creación mensual `- - - * *`
- Creación semanal `- - * * -`
- Creación anual `- - - - *`
- Creación diaria `- - * * *`

Ejemplos
- Creación mensual `0 22 1 * *` El dia primero de cada més se ejecuta
- Creación semanal `0 22 * * 0` Cada domingo a las 22:00
- Creación anual `0 22 1 1 *` Cada primero de enero a las 22:00
- Creación diaria `0 22 * * *` Todos los dias a las 22:00, no se recomienda su uso
