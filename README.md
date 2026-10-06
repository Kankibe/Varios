# Laboratorio de Temas Varios

**Universidad Tecnológica de Panamá**

Facultad de Ingeniería en Sistemas Computacionales – Campus Víctor Levis Sasso

**Materia:** Herramientas de la Programación Aplicada III (.NET)

**Instructora:** Ing. Irina Fong

**Grupo:** 1IL133 – II Semestre 2026

**Módulo IV:** Acceso a Base de Datos – Aplicaciones en Capas

**Estudiante:** Kankibe Gonzalez – Cédula: 10-716-96

---

## Descripción

Laboratorio sobre la seguridad en bases de datos (inyección SQL y consultas parametrizadas), la programación orientada a objetos con métodos sobrecargados, la recursividad y el análisis de frecuencias en C#.

## Versiones de tecnologías

| Tecnología | Versión |
|---|---|
| SDK de .NET | .NET 10.0 |
| Lenguaje | C# 14 |
| IDE | Visual Studio 2026 |
| Tipo de proyecto | Aplicación de consola |

## Guía de instalación y uso (onboarding)

1. Instalar el [SDK de .NET 10](https://dotnet.microsoft.com/download) (se puede verificar con `dotnet --version`).
2. Clonar el repositorio:
```bash
   git clone [PONER URL DEL REPOSITORIO]
   cd [PONER NOMBRE DE LA CARPETA DEL REPO]
```
3. Abrir la solución (`.slnx`) de cada proyecto en Visual Studio, o usar la terminal.
4. Restaurar dependencias y ejecutar cada proyecto:
```bash
   cd Cadenas
   dotnet restore
   dotnet run
```
   Hacer lo mismo en las carpetas `Sobrecarga de metodos`, `Factorial` y `Estadistica`.

## Estructura del repositorio

| Carpeta / archivo | Problema |
|---|---|
| `Consultas_sql.sql` | Consultas SQL (inyección SQL) |
| `Sobrecarga de metodos/` | Métodos sobrecargados |
| `Factorial/` | Recursividad (factorial) |
| `Estadistica/` | Frecuencia |

---
## Script de la base de datos

Archivo: `script_sistema_permisos.sql` (MySQL).

El script crea la base de datos `sistema_permisos` y las tablas `permisos` y `datospersonales`, e inserta los registros iniciales correspondientes.

### Estructura de la tabla `permisos`

| Columna | Tipo | Descripción |
|---|---|---|
| `id` | INT, AUTO_INCREMENT, PK | Identificador único del registro |
| `Usuario` | VARCHAR(50) | Nombre de usuario |
| `Contrasena` | VARCHAR(255) | Contraseña del usuario |
| `Administrador` | TINYINT(1) | Indica si es administrador (`1` = Sí, `0` = No) |
| `Correo` | VARCHAR(100) | Correo electrónico del usuario |
| `UsuarioSistema` | TINYINT(1) | Estado o tipo de usuario en el sistema |
| `FechaModificacion` | DATE | Fecha de última modificación |
| `Modulo_Personal` | TINYINT(1) | Permiso para el módulo de Personal (`1` = Permitido, `0` = Denegado) |
| `Modulo_Horario` | TINYINT(1) | Permiso para el módulo de Horarios (`1` = Permitido, `0` = Denegado) |
| `Modulo_Vacaciones` | TINYINT(1) | Permiso para el módulo de Vacaciones (`1` = Permitido, `0` = Denegado) |

### Estructura de la tabla `datospersonales`

| Columna | Tipo | Descripción |
|---|---|---|
| `id` | INT, AUTO_INCREMENT, PK | Identificador del registro |
| `nombre` | VARCHAR(100) | Nombre de prueba o auxiliar |

---

### Cómo usarlo:

1. Abrir **MySQL Workbench** (o el cliente MySQL que utilices) y conectarse al servidor.
2. Abrir el archivo `script_sistema_permisos.sql` y ejecutarlo completo.
3. Asegurarse de ejecutar la línea `SET SQL_MODE = 'ALLOW_INVALID_DATES';` para admitir valores de fecha cero (`0000-00-00`).
4. Verificar que se cargaron los datos ejecutando la consulta:

```sql
SELECT * FROM permisos;
SELECT * FROM datospersonales;
```

> **Nota:** El script habilita explícitamente `ALLOW_INVALID_DATES` para permitir la inserción de registros con fechas iniciales `0000-00-00`.

**Captura de pantalla (tabla `permisos` con los datos):**


<img width="1248" height="151" alt="image" src="https://github.com/user-attachments/assets/22dc77a6-20b9-4e78-90ff-e2c49b4557e4" />


## Consultas SQL (Inyección SQL)

Archivo: `Consultas_sql.sql`. Se muestran tres consultas que demuestran cómo se puede explotar una aplicación que arma sus consultas concatenando texto.

```sql
-- 1) Condición siempre verdadera (tautología)
SELECT * FROM permisos WHERE Usuario = '' or '1'='1' AND Contrasena = '' OR '1'='1';

-- 2) Uso de comentario para ignorar el resto de la consulta
SELECT * FROM permisos WHERE Usuario = 'root'; -- ' AND password = 'mypassword';

-- 3) Inyección basada en tiempo (blind SQL injection)
SELECT * FROM datospersonales WHERE id=1-SLEEP(1);
```

**Explicación:**

- **Consulta 1:** `'1'='1'` siempre es verdadero, así que el `WHERE` se cumple para todas las filas y se evita la validación de usuario y contraseña (bypass de login).
- **Consulta 2:** el `--` convierte en comentario todo lo que sigue, por lo que se anula la verificación de la contraseña.
- **Consulta 3:** `SLEEP(1)` hace que la base de datos se demore. Si la respuesta tarda, el atacante confirma que la aplicación es vulnerable aunque no vea ningún resultado en pantalla.

**Captura de pantalla:**

consulta 1

<img width="1265" height="204" alt="image" src="https://github.com/user-attachments/assets/b855fb36-859c-4737-8276-a49343471585" />

consulta 2

<img width="1217" height="91" alt="image" src="https://github.com/user-attachments/assets/a585e182-52fb-4462-8b31-3eca4db03870" />

## Métodos sobrecargados

Carpeta: `Sobrecarga de metodos/`. La clase `SobreCarga` define dos métodos `Cuadrado` con el mismo nombre pero distinta firma: uno recibe un `int` y el otro un `double`. C# decide cuál ejecutar según el tipo del argumento.

```csharp
public int Cuadrado(int valorInt) { ... }
public double Cuadrado(double valorDouble) { ... }
```

**Captura de pantalla (salida de consola):**

<img width="590" height="173" alt="image" src="https://github.com/user-attachments/assets/06d3f803-7651-49f8-8e96-0a09684f766f" />


---

## Recursividad (Factorial)

Carpeta: `Factorial/`. Método recursivo que calcula n! y muestra el factorial de 0 a 10. El **caso base** (`numero <= 1` devuelve 1) es lo que detiene las llamadas y evita un desbordamiento de pila (*StackOverflow*).

```csharp
public static long Factorial(long numero)
{
    if (numero <= 1)
        return 1;                              // caso base
    else
        return numero * Factorial(numero - 1); // paso recursivo
}
```

<img width="231" height="266" alt="image" src="https://github.com/user-attachments/assets/ed62c492-dfa0-479e-8651-5618e3d01c4f" />

---

## Frecuencia

Carpeta: `Estadistica/`. Se simula el lanzamiento de un dado 6000 veces con `Random` y se cuenta cuántas veces sale cada cara (1 al 6) usando un contador por cara y un `switch`. Al final se muestra una tabla con las frecuencias; cada cara debería salir cerca de 1000 veces.

**Captura de pantalla (salida de consola):**

<img width="334" height="171" alt="image" src="https://github.com/user-attachments/assets/e99eef8c-90c2-4d22-8e41-9eebe8f837be" />

---

## Referencias

- Material del curso Herramientas de la Programación Aplicada III (.NET) – Ing. Irina Fong.
- Documentación oficial de .NET: https://learn.microsoft.com/dotnet/

---

*Universidad Tecnológica de Panamá – Herramientas de la Programación Aplicada III (.NET) 
