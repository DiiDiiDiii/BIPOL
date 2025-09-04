# 🚔 BIPOL – Bitácora Institucional Policial

## 📌 Descripción
BIPOL es un prototipo de sistema web desarrollado como proyecto de título para la carrera de **Ingeniería en Computación e Informática** en la Universidad Andrés Bello.  
El sistema busca **digitalizar la gestión de las bitácoras vehiculares** utilizadas en la Escuela de Investigaciones Policiales (PDI), reemplazando los registros manuales en libros físicos por un entorno digital más seguro, trazable y eficiente.

## 🛠️ Tecnologías utilizadas
- **ASP.NET Core MVC (.NET 6.0)**
- **C#** para la lógica de negocio
- **SQL Server 2022** para la gestión de datos
- **Entity Framework y procedimientos almacenados**
- **Razor Pages** para la capa de presentación
- **Bootstrap 5 / CSS personalizado** para la interfaz

## ⚙️ Funcionalidades principales
- Autenticación de usuarios (Administrador, Supervisor y Conductor).
- Registro y cierre de eventos vehiculares.
- Validación de kilometrajes y estados.
- Consulta de eventos con filtros por fecha, vehículo y estado.
- Generación de reportes exportables en Excel.
- Administración de usuarios y vehículos (alta, edición y actualización).
- Recuperación de contraseña (simulada en entorno local).

## 📂 Estructura del proyecto
- `/Controllers` → Controladores MVC.  
- `/Models` → Modelos de datos.  
- `/Views` → Vistas Razor organizadas por rol.  
- `/Datos` → Clases de acceso a datos y conexión con la BD.  
- `/ScriptsSQL` → Script de creación de tablas y procedimientos almacenados.  
- `/wwwroot/css` → Archivos CSS personalizados.  

## 💻 Requisitos de instalación
1. **SQL Server 2022** instalado y configurado.  
2. Crear la base de datos ejecutando los scripts de `/ScriptsSQL`.  
3. Abrir el proyecto en **Visual Studio 2022** o **Visual Studio Code**.  
4. Configurar la cadena de conexión en `appsettings.json`.  
5. Ejecutar el proyecto con **IIS Express** o **Kestrel**.  
6. Ingresar al sistema desde el navegador en `https://localhost:xxxx`.

## 👩‍💻 Roles disponibles
- **Administrador**: gestiona usuarios, vehículos y puede editar eventos.  
- **Supervisor**: consulta eventos y genera reportes.  
- **Conductor**: registra y cierra eventos de salida y regreso de vehículos.  

## 📊 Estado actual
Este sistema corresponde a un **prototipo académico en entorno local**, no desplegado aún en servidores institucionales.  
Las funcionalidades de recuperación de contraseña y envío de correos fueron implementadas en forma simulada.  

## 🚀 Próximas mejoras recomendadas
- Implementar historial de cambios para eventos editados.  
- Incorporar OCR para lectura automática de kilometraje.  
- Bloqueo de vehículos con eventos abiertos.  
- Validación continua de kilometraje entre eventos sucesivos.  
- Integración con autenticación institucional (Active Directory).  
- Habilitar recuperación real de contraseñas vía correo institucional.  

## 👩‍🎓 Autora
**Diandra Oyarzún Carrasco**  
Proyecto de Título – Ingeniería en Computación e Informática  
Universidad Andrés Bello – 2025  
