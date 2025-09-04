create table rol (
  id int primary key,
  nombre_rol varchar (20) not null
);

create table cargo (
  id int primary key,
  nombre_rol varchar (50) not null
);

create table usuario (
  id int primary key,
  nombre varchar (100),
  rut varchar (15),
  correo varchar (100),
  contrasena varchar (20)
);

create table funcionario (
  id int primary key,
  id_usuario int,
  grado varchar (200),
  unidad varchar (200),
  id_rol int not null,
  id_cargo int not null,
  foreign key (id_usuario) references usuario (id),
  foreign key (id_rol) references rol (id),
  foreign key (id_cargo) references cargo (id)
);

create table vehiculo (
  id int primary key,
  patente varchar (200),
  modelo varchar (200),
  marca varchar (200),
  anio varchar (200),
  estado varchar (200)
);

create table bitacora (
  id int primary key,
  nombre_bitacora varchar (200),
  fecha_creacion date,
  id_vehiculo int,
  foreign key (id_vehiculo) references vehiculo (id)
);

create table evento (
  id int primary key,
  fecha date,
  hora_salida time,
  hora_regreso time,
  destino varchar (200),
  kilometraje_inicio int,
  kilometraje_fin int,
  observaciones varchar (200),
  tripulantes varchar (200),
  id_funcionario int,
  id_bitacora int ,
  foreign key (id_funcionario) references funcionario (id),
  foreign key (id_bitacora) references bitacora (id)
);

alter table evento add  id_vehiculo int, foreign key (id_vehiculo) REFERENCES VEHICULO(id_vehiculo)

insert into cargo values (1,'Detective')
insert into cargo values (2,'Subinspector')
insert into cargo values (3,'Inspector')
insert into cargo values (4,'Subcomisario')
insert into cargo values (5,'Comisario')
insert into cargo values (6,'Subprefecto')
insert into cargo values (7,'Prefecto')
insert into cargo values (8,'Prefecto Inspector')
insert into cargo values (9,'Prefecto General')
insert into cargo values (10,'Director General')
insert into cargo values (11,'Oficial de los Servicios')
insert into cargo values (12,'Agente Policial')
insert into cargo values (13,'Profesional')
insert into cargo values (14,'Técnico')
insert into cargo values (15,'Auxiliar')
insert into cargo values (16,'Administrativo')


insert into rol values (1,'Administrador')
insert into rol values (2,'Conductor')
insert into rol values (3,'Supervisor')


CREATE PROCEDURE sp_Guardar
@v_nombre_usuario varchar(50),
@v_contraseña varchar(50),
@v_correo varchar(50),
@v_nombre_completo varchar(200),
@v_rut varchar(50),
@v_unidad varchar(200),
@v_id_rol int,
@v_id_cargo int
as
begin

INSERT INTO funcionario(nombre_usuario,contraseña,correo,nombre_completo,rut,unidad,id_rol,id_cargo) 
VALUES(@v_nombre_usuario,@v_contraseña,@v_correo,@v_nombre_completo,@v_rut,@v_unidad,@v_id_rol,@v_id_cargo);

end;

select * from funcionario

ALTER PROCEDURE sp_Guardar_Vehiculo
@v_patente varchar(50),
@v_modelo varchar(50),
@v_marca varchar(50),
@v_anio varchar(200),
@v_sigla varchar(200),
@v_kilometraje int
as
begin

INSERT INTO vehiculo(patente, modelo, marca, anio, estado, sigla, kilometraje) 
VALUES(@v_patente,@v_modelo,@v_marca,@v_anio,'Bueno',@v_sigla, @v_kilometraje);

end;

CREATE PROCEDURE sp_ListarFuncionario
as
begin

select id_funcionario,nombre_usuario, contraseña, correo, nombre_completo,rut, unidad, id_rol, id_cargo from funcionario

end;

ALTER PROCEDURE sp_ObtenerFuncionario
@v_id_funcionario int
as
begin

select id_funcionario,nombre_usuario, contraseña, correo, nombre_completo,rut, unidad, id_rol, id_cargo from funcionario
WHERE id_funcionario = @v_id_funcionario;


end;



CREATE PROCEDURE sp_ModificarFuncionario
@v_id_funcionario int,
@v_nombre_usuario varchar(50),
@v_contraseña varchar(50),
@v_correo varchar(50),
@v_nombre_completo varchar(200),
@v_rut varchar(50),
@v_unidad varchar(200),
@v_id_rol int,
@v_id_cargo int

as
begin

UPDATE funcionario
SET 
nombre_usuario = @v_nombre_usuario,
contraseña = @v_contraseña,
correo= @v_correo,
nombre_completo = @v_nombre_completo,
rut = @v_rut,
unidad = @v_unidad,
id_rol =@v_id_rol,
id_cargo = @v_id_cargo

WHERE id_funcionario = @v_id_funcionario;


end;

select * from vehiculo

CREATE PROCEDURE sp_ListarVehiculo
as
begin

select id_vehiculo,patente, modelo, marca, anio,estado,sigla,kilometraje from vehiculo

end;

CREATE PROCEDURE sp_ObtenerVehiculo

@v_id_vehiculo int

as

begin

select id_vehiculo,patente, modelo, marca, anio,estado,sigla,kilometraje from vehiculo
WHERE id_vehiculo = @v_id_vehiculo;

end;

CREATE PROCEDURE sp_ModificarVehiculo
@v_id_vehiculo int,
@v_patente varchar(50),
@v_modelo varchar(50),
@v_marca varchar(50),
@v_anio varchar(50),
@v_estado varchar(50),
@v_sigla varchar(200),
@v_kilometraje int


as
begin

UPDATE vehiculo
SET 
patente = @v_patente,
estado = @v_estado,
sigla = @v_sigla,
modelo = @v_modelo,
marca= @v_marca,
anio = @v_anio,
kilometraje =@v_kilometraje


WHERE id_vehiculo = @v_id_vehiculo;


end;


alter PROCEDURE sp_Vehiculo_ListarSigla
AS
BEGIN
    SET NOCOUNT ON;
    SELECT id_vehiculo, sigla
    FROM vehiculo
    WHERE sigla IS NOT NULL AND LTRIM(RTRIM(sigla)) <> ''
    ORDER BY sigla;
END

alter PROCEDURE sp_RegistrarEvento
@v_id_vehiculo int,
@v_destino varchar(200),
@v_tripulantes varchar(500),
@v_fecha_salida date,
@v_hora_salida time,
@v_kilometraje_salida int,
@v_observaciones_salida varchar(2000)
as
begin

INSERT INTO evento(id_vehiculo, destino, tripulantes,fecha_salida, hora_salida, kilometraje_salida, observaciones_salida, estado) 
VALUES(@v_id_vehiculo,@v_destino,@v_tripulantes,@v_fecha_salida,@v_hora_salida,@v_kilometraje_salida,@v_observaciones_salida, 'Abierto');

end;


ALTER PROCEDURE sp_ListarEventos
AS
BEGIN
    SELECT 
        e.id_evento,
        CONVERT (varchar (10), e.fecha_salida, 105) AS fecha_salida,
        e.hora_salida,
        ISNULL(CONVERT(varchar(10), e.hora_regreso, 105), '') AS hora_regreso,
        e.destino,
        e.kilometraje_salida,
        ISNULL (e.kilometraje_regreso, ' ') AS kilometraje_regreso,
        e.tripulantes,
       ISNULL(CONVERT(varchar(10), e.fecha_regreso, 105), '') AS fecha_regreso,
        v.sigla,
        e.estado
    FROM Evento e
    INNER JOIN Vehiculo v ON e.id_vehiculo = v.id_vehiculo
    ORDER BY e.fecha_salida DESC, e.hora_salida DESC;
END

alter PROCEDURE sp_ObtenerEvento
@v_id_evento int
as
begin
select v.sigla, e.fecha_salida, e.hora_salida,e.kilometraje_salida, 
COALESCE(CAST(fecha_regreso AS date), CAST(GETDATE() AS date)) AS fecha_regreso
from evento e
INNER JOIN vehiculo v
ON e.id_vehiculo = v.id_vehiculo
WHERE id_evento = @v_id_evento;


end;


ALTER PROCEDURE sp_ObtenerEvento
  @v_id_evento int
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        e.id_evento,
        v.sigla,
        TRY_CONVERT(date, e.fecha_salida)                                    AS fecha_salida,
        TRY_CONVERT(time(0), e.hora_salida)                                  AS hora_salida,
        e.kilometraje_salida,
        COALESCE(TRY_CONVERT(date, e.fecha_regreso), CAST(GETDATE() AS date)) AS fecha_regreso
    FROM evento e
    INNER JOIN vehiculo v ON e.id_vehiculo = v.id_vehiculo
    WHERE e.id_evento = @v_id_evento;
END


alter PROCEDURE sp_RegistrarRegreso
@v_hora_regreso time,
@v_kilometraje_regreso int,
@v_fecha_regreso date,
@v_bencina_litros int,
@v_bencina_cupon varchar(50),
@v_observaciones_regreso varchar(200),
@v_id_evento int


as
begin

UPDATE evento
SET 
hora_regreso = @v_hora_regreso,
kilometraje_regreso = @v_kilometraje_regreso,
fecha_regreso = @v_fecha_regreso,
bencina_litros = @v_bencina_litros,
bencina_cupon= @v_bencina_cupon,
observaciones_regreso = @v_observaciones_regreso,
estado = 'Cerrado'


WHERE id_evento = @v_id_evento;


end;
SELECT * from evento


------------------------------------------------------------------

ALTER PROCEDURE sp_ListarEventos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        e.id_evento,
        CAST(e.fecha_salida AS date)                  AS fecha_salida,   -- solo fecha
        CAST(e.hora_salida  AS time(0))               AS hora_salida,    -- hh:mm:ss
        CAST(e.hora_regreso AS time(0))               AS hora_regreso,   -- puede ser NULL
        e.destino,
        e.kilometraje_salida,
        e.kilometraje_regreso,                                         -- int (puede ser NULL)
        e.tripulantes,
        CAST(e.fecha_regreso AS date)                 AS fecha_regreso,  -- solo fecha (o usa COALESCE(..., CAST(GETDATE() AS date)))
        v.sigla,
        e.estado
    FROM Evento e
    INNER JOIN Vehiculo v ON e.id_vehiculo = v.id_vehiculo
    ORDER BY e.fecha_salida DESC, e.hora_salida DESC;
END


ALTER PROCEDURE sp_ListarEventos
AS
BEGIN
  SET NOCOUNT ON;

  SELECT 
    e.id_evento,
    CAST(e.fecha_salida AS date)                                  AS fecha_salida,              -- solo fecha
    CAST(e.hora_salida  AS time(0))                               AS hora_salida,               -- hh:mm:ss
    COALESCE(CAST(e.hora_regreso AS time(0)), CAST('00:00' AS time(0))) AS hora_regreso,   -- default si viene null
    e.destino,
    e.kilometraje_salida,
    COALESCE(e.kilometraje_regreso, 0)                            AS kilometraje_regreso,       -- default 0
    COALESCE(e.tripulantes, '')                                   AS tripulantes,               -- vacío si es null
    COALESCE(CAST(e.fecha_regreso AS date), CAST(GETDATE() AS date)) AS fecha_regreso,        -- hoy si es null
    v.sigla,
    e.estado
  FROM Evento e
  INNER JOIN Vehiculo v ON e.id_vehiculo = v.id_vehiculo
  ORDER BY e.fecha_salida DESC, e.hora_salida DESC;
END


create procedure sp_AutenticacionLogin
@v_nombre_usuario varchar (50),
@v_contraseña varchar (50)
AS
BEGIN

SELECT * FROM funcionario WHERE nombre_usuario = @v_nombre_usuario AND contraseña = @v_contraseña;



END

create PROCEDURE sp_ListarUsuario
as
begin

select id_funcionario,nombre_usuario, contraseña, correo, nombre_completo,rut, unidad, r.nombre_rol, id_cargo 
from funcionario f
join rol r
on f.id_rol = r.id_rol

end;


alter PROCEDURE sp_ObtenerEventoCompleto

@v_id_evento int

as

begin

select id_evento,fecha_salida, hora_salida, fecha_regreso, hora_regreso,destino, kilometraje_salida, kilometraje_regreso,
tripulantes, observaciones_salida, observaciones_regreso, id_funcionario, bencina_litros,bencina_cupon, 
e.estado, v.sigla 
from evento e 
join vehiculo v
on e.id_vehiculo = v.id_vehiculo
WHERE id_evento = @v_id_evento;

end;


CREATE PROCEDURE sp_ListarEventosCerrados
AS
BEGIN
  SET NOCOUNT ON;

  SELECT 
    e.id_evento,
    CAST(e.fecha_salida AS date)                                  AS fecha_salida,              -- solo fecha
    CAST(e.hora_salida  AS time(0))                               AS hora_salida,               -- hh:mm:ss
    COALESCE(CAST(e.hora_regreso AS time(0)), CAST('00:00' AS time(0))) AS hora_regreso,   -- default si viene null
    e.destino,
    e.kilometraje_salida,
    COALESCE(e.kilometraje_regreso, 0)                            AS kilometraje_regreso,       -- default 0
    e.observaciones_salida,
    e.bencina_litros,
    e.bencina_cupon,
    e.observaciones_regreso,
    COALESCE(e.tripulantes, '')                                   AS tripulantes,               -- vacío si es null
    COALESCE(CAST(e.fecha_regreso AS date), CAST(GETDATE() AS date)) AS fecha_regreso,        -- hoy si es null
    v.sigla,
    e.estado
  FROM Evento e
  INNER JOIN Vehiculo v ON e.id_vehiculo = v.id_vehiculo
  WHERE e.estado = 'Cerrado'
  ORDER BY e.fecha_salida DESC, e.hora_salida DESC

END

CREATE PROCEDURE sp_ModificarEventoCompleto
@v_id_evento int,
@v_fecha_salida date,
@v_hora_salida time,
@v_fecha_regreso date,
@v_hora_regreso time,
@v_kilometraje_salida int,
@v_kilometraje_regreso int,
@v_tripulantes varchar (200),
@v_observaciones_salida varchar(200),
@v_observaciones_regreso varchar(200),
@v_bencina_litros int,
@v_bencina_cupon varchar(50)

as
begin

UPDATE evento
SET 
fecha_salida = @v_fecha_salida,
hora_salida = @v_hora_salida,
fecha_regreso = @v_fecha_regreso,
hora_regreso = @v_hora_regreso,
kilometraje_salida = @v_kilometraje_salida,
kilometraje_regreso = @v_kilometraje_regreso,
tripulantes = @v_tripulantes,
observaciones_salida = @v_observaciones_salida,
observaciones_regreso = @v_observaciones_regreso,
bencina_litros = @v_bencina_litros,
bencina_cupon = @v_bencina_cupon


WHERE id_evento = @v_id_evento;


end;


CREATE PROCEDURE sp_ListarEventosFiltroFecha
@v_fecha_desde date,
@v_fecha_hasta date
AS
BEGIN
  SELECT 
    e.id_evento,
    CAST(e.fecha_salida AS date)                                  AS fecha_salida,              -- solo fecha
    CAST(e.hora_salida  AS time(0))                               AS hora_salida,               -- hh:mm:ss
    COALESCE(CAST(e.hora_regreso AS time(0)), CAST('00:00' AS time(0))) AS hora_regreso,   -- default si viene null
    e.destino,
    e.kilometraje_salida,
    COALESCE(e.kilometraje_regreso, 0)                            AS kilometraje_regreso,       -- default 0
    COALESCE(e.tripulantes, '')                                   AS tripulantes,               -- vacío si es null
    COALESCE(CAST(e.fecha_regreso AS date), CAST(GETDATE() AS date)) AS fecha_regreso,        -- hoy si es null
    v.sigla,
    e.estado
  FROM Evento e
  INNER JOIN Vehiculo v ON e.id_vehiculo = v.id_vehiculo
  WHERE e.fecha_regreso BETWEEN @v_fecha_desde and @v_fecha_hasta
  ORDER BY e.fecha_salida DESC, e.hora_salida DESC;
END;
------------------------------------------------------------------------------------------------------

ALTER PROCEDURE dbo.sp_ListarEventosFiltroFecha
  @v_fecha_desde date = NULL,
  @v_fecha_hasta date = NULL,
  @v_id_vehiculo int  = NULL,
  @v_estado      varchar(20) = NULL
AS
BEGIN
  SET NOCOUNT ON;

  SELECT 
      e.id_evento,
      e.fecha_salida,
      CAST(e.hora_salida  AS time(0)) AS hora_salida,
      COALESCE(CAST(e.hora_regreso AS time(0)), CAST('00:00' AS time(0))) AS hora_regreso,
      e.destino,
      e.kilometraje_salida,
      COALESCE(e.kilometraje_regreso, 0) AS kilometraje_regreso,
      COALESCE(e.tripulantes, '') AS tripulantes,
      COALESCE(e.fecha_regreso, CAST(GETDATE() AS date)) AS fecha_regreso,
      v.sigla,
      e.estado
  FROM Evento e
  INNER JOIN Vehiculo v ON e.id_vehiculo = v.id_vehiculo
  WHERE
      (@v_fecha_desde IS NULL OR e.fecha_salida >= @v_fecha_desde)
  AND (@v_fecha_hasta IS NULL OR e.fecha_regreso <= @v_fecha_hasta)
  AND (@v_id_vehiculo IS NULL OR e.id_vehiculo = @v_id_vehiculo)
  AND (@v_estado IS NULL OR e.estado = @v_estado)
  ORDER BY e.fecha_salida DESC, e.hora_salida DESC;
END;
------------------------------------------------------------TRAE INFORMACION DE ENTRADA Y SALIDA INDEPENDIENTE SI TERMINARON FUERA DEL RANGO-----------------------

ALTER PROCEDURE dbo.sp_ListarEventosFiltroFecha
  @v_fecha_desde  date = NULL,
  @v_fecha_hasta  date = NULL,
  @v_id_vehiculo  int  = NULL,
  @v_estado       varchar(20) = NULL
AS
BEGIN
  SET NOCOUNT ON;

  -- Rango abierto si faltan parámetros
  DECLARE @desde date = ISNULL(@v_fecha_desde, CONVERT(date, '0001-01-01'));
  DECLARE @hasta date = ISNULL(@v_fecha_hasta, CONVERT(date, '9999-12-31'));

  SELECT 
      e.id_evento,
      e.fecha_salida,
      CAST(e.hora_salida  AS time(0)) AS hora_salida,
      COALESCE(CAST(e.hora_regreso AS time(0)), CAST('00:00' AS time(0))) AS hora_regreso,
      e.destino,
      e.kilometraje_salida,
      COALESCE(e.kilometraje_regreso, 0) AS kilometraje_regreso,
      COALESCE(e.tripulantes, '') AS tripulantes,
      COALESCE(e.fecha_regreso, CAST(GETDATE() AS date)) AS fecha_regreso,
      v.sigla,
      e.estado
  FROM Evento e
  INNER JOIN Vehiculo v ON e.id_vehiculo = v.id_vehiculo
  WHERE
      -- superposición de [fecha_salida, fecha_regreso] con [@desde, @hasta]
      e.fecha_salida <= @hasta
      AND (e.fecha_regreso IS NULL OR e.fecha_regreso >= @desde)
      -- filtros opcionales
      AND (@v_id_vehiculo IS NULL OR e.id_vehiculo = @v_id_vehiculo)
      AND (@v_estado     IS NULL OR e.estado = @v_estado)
  ORDER BY e.fecha_salida DESC, e.hora_salida DESC;
END;

---------------------------------------------------------------------

ALTER PROCEDURE dbo.sp_ListarEventosFiltroFecha
  @v_fecha_desde  date = NULL,
  @v_fecha_hasta  date = NULL,
  @v_id_vehiculo  int  = NULL,
  @v_estado       varchar(20) = NULL
AS
BEGIN
  SET NOCOUNT ON;

  -- Normaliza: si faltan, define extremos amplios
  DECLARE @desde date = ISNULL(@v_fecha_desde, CONVERT(date, '0001-01-01'));
  DECLARE @hasta date = ISNULL(@v_fecha_hasta, CONVERT(date, '9999-12-31'));

  -- (Opcional) seguridad: si el usuario invierte el rango, lo corregimos
  IF (@desde > @hasta)
  BEGIN
    DECLARE @tmp date = @desde;
    SET @desde = @hasta;
    SET @hasta = @tmp;
  END

  SELECT 
      e.id_evento,
      e.fecha_salida,
      CAST(e.hora_salida  AS time(0)) AS hora_salida,
      COALESCE(CAST(e.hora_regreso AS time(0)), CAST('00:00' AS time(0))) AS hora_regreso,
      e.destino,
      e.kilometraje_salida,
      COALESCE(e.kilometraje_regreso, 0) AS kilometraje_regreso,
      COALESCE(e.tripulantes, '') AS tripulantes,
      e.fecha_regreso,
      v.sigla,
      e.estado
  FROM Evento e
  INNER JOIN Vehiculo v ON e.id_vehiculo = v.id_vehiculo
  WHERE
      -- Ambos dentro del rango: salida y regreso
      e.fecha_salida  >= @desde AND e.fecha_salida  <= @hasta
  AND e.fecha_regreso >= @desde AND e.fecha_regreso <= @hasta
      -- Filtros opcionales
  AND (@v_id_vehiculo IS NULL OR e.id_vehiculo = @v_id_vehiculo)
  AND (@v_estado     IS NULL OR e.estado = @v_estado)
  ORDER BY e.fecha_salida DESC, e.hora_salida DESC;
END;

--------------------------------------------------------------casi final
ALTER PROCEDURE dbo.sp_ListarEventosFiltroFecha
  @v_fecha_desde  date = NULL,
  @v_fecha_hasta  date = NULL,
  @v_id_vehiculo  int  = NULL,
  @v_estado       varchar(20) = NULL,
  @v_todos        bit = 0
AS
BEGIN
  SET NOCOUNT ON;

  -- Normaliza rango si viene (solo para modo filtrado)
  DECLARE @desde date = @v_fecha_desde;
  DECLARE @hasta date = @v_fecha_hasta;

  IF (@v_todos = 0)
  BEGIN
      -- Si faltan fechas, define extremos amplios (por seguridad)
      SET @desde = ISNULL(@desde, CONVERT(date, '0001-01-01'));
      SET @hasta = ISNULL(@hasta, CONVERT(date, '9999-12-31'));

      -- Si el usuario invierte el rango, corrige
      IF (@desde > @hasta)
      BEGIN
        DECLARE @tmp date = @desde;
        SET @desde = @hasta;
        SET @hasta = @tmp;
      END
  END

  SELECT 
      e.id_evento,
      e.fecha_salida,
      CAST(e.hora_salida  AS time(0)) AS hora_salida,
      COALESCE(CAST(e.hora_regreso AS time(0)), CAST('00:00' AS time(0))) AS hora_regreso,
      e.destino,
      e.kilometraje_salida,
      COALESCE(e.kilometraje_regreso, 0) AS kilometraje_regreso,
      COALESCE(e.tripulantes, '') AS tripulantes,
      e.fecha_regreso,
      v.sigla,
      e.estado
  FROM Evento e
  INNER JOIN Vehiculo v ON e.id_vehiculo = v.id_vehiculo
  WHERE
      (
        -- MODO TODOS: no filtra por fechas
        @v_todos = 1

        -- MODO FILTRO: ambos dentro del rango
        OR (
            e.fecha_salida  >= @desde AND e.fecha_salida  <= @hasta
        AND e.fecha_regreso >= @desde AND e.fecha_regreso <= @hasta
        )
      )
      AND (@v_id_vehiculo IS NULL OR e.id_vehiculo = @v_id_vehiculo)
      AND (@v_estado     IS NULL OR e.estado = @v_estado)
  ORDER BY e.fecha_salida DESC, e.hora_salida DESC;
END;


CREATE PROCEDURE sp_ListarEventosTodos
AS
BEGIN
  SET NOCOUNT ON;

  SELECT 
    e.id_evento,
    f.nombre_completo,
    CAST(e.fecha_salida AS date)                                  AS fecha_salida,              -- solo fecha
    CAST(e.hora_salida  AS time(0))                               AS hora_salida,               -- hh:mm:ss
    COALESCE(CAST(e.hora_regreso AS time(0)), CAST('00:00' AS time(0))) AS hora_regreso,   -- default si viene null
    e.destino,
    e.kilometraje_salida,
    COALESCE(e.kilometraje_regreso, 0)                            AS kilometraje_regreso,       -- default 0
    COALESCE(e.tripulantes, '')                                   AS tripulantes,               -- vacío si es null
    COALESCE(CAST(e.fecha_regreso AS date), CAST(GETDATE() AS date)) AS fecha_regreso,        -- hoy si es null
    v.sigla,
    e.estado
  FROM Evento e
  INNER JOIN Vehiculo v ON e.id_vehiculo = v.id_vehiculo
  JOIN funcionario f
  ON f.id_funcionario = e.id_funcionario
  ORDER BY e.fecha_salida DESC, e.hora_salida DESC;
END;


CREATE PROCEDURE sp_ListarEventosFiltrosTodos
  @v_fecha_desde  date = NULL,
  @v_fecha_hasta  date = NULL,
  @v_id_vehiculo  int  = NULL,
  @v_estado       varchar(20) = NULL,
  @v_todos        bit = 0
AS
BEGIN
  SET NOCOUNT ON;

  -- Normaliza rango si viene (solo para modo filtrado)
  DECLARE @desde date = @v_fecha_desde;
  DECLARE @hasta date = @v_fecha_hasta;

  IF (@v_todos = 0)
  BEGIN
      -- Si faltan fechas, define extremos amplios (por seguridad)
      SET @desde = ISNULL(@desde, CONVERT(date, '0001-01-01'));
      SET @hasta = ISNULL(@hasta, CONVERT(date, '9999-12-31'));

      -- Si el usuario invierte el rango, corrige
      IF (@desde > @hasta)
      BEGIN
        DECLARE @tmp date = @desde;
        SET @desde = @hasta;
        SET @hasta = @tmp;
      END
  END

 SELECT 
      e.id_evento,
      e.fecha_salida,
      CAST(e.hora_salida  AS time(0)) AS hora_salida,
      COALESCE(CAST(e.hora_regreso AS time(0)), CAST('00:00' AS time(0))) AS hora_regreso,
      e.destino,
      e.kilometraje_salida,
      COALESCE(e.kilometraje_regreso, 0) AS kilometraje_regreso,
      COALESCE(e.tripulantes, '') AS tripulantes,
      e.fecha_regreso,
      v.sigla,
      e.estado,
      f.nombre_completo
  FROM Evento e
  INNER JOIN Vehiculo v    ON e.id_vehiculo     = v.id_vehiculo
  INNER JOIN funcionario f ON f.id_funcionario  = e.id_funcionario
  WHERE
      (
        -- MODO TODOS: no filtra por fechas
        @v_todos = 1
        -- MODO FILTRO: ambos dentro del rango
        OR (
            e.fecha_salida  >= @desde AND e.fecha_salida  <= @hasta
        AND e.fecha_regreso >= @desde AND e.fecha_regreso <= @hasta
        )
      )
      AND (@v_id_vehiculo IS NULL OR e.id_vehiculo = @v_id_vehiculo)
      AND (@v_estado     IS NULL OR e.estado = @v_estado)
  ORDER BY e.fecha_salida DESC, e.hora_salida DESC;

END;

CREATE OR ALTER PROCEDURE sp_TieneEventosAbiertosPorFuncionario
    @v_id_funcionario INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Considera "abierto" si el estado = 'Abierto' o si NO tiene fecha/hora/kilometraje de regreso
    SELECT COUNT(1) AS abiertos
    FROM Evento
    WHERE id_funcionario = @v_id_funcionario
      AND (
            estado = 'Abierto'
            OR fecha_regreso IS NULL
            OR hora_regreso IS NULL
            OR kilometraje_regreso IS NULL
          );
END

CREATE OR ALTER PROCEDURE sp_RecuperarContraseña
    @correo VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1 id_funcionario, nombre_usuario, rut, correo, contraseña
    FROM funcionario
    WHERE correo = @correo;
END

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'funcionario_reset_token')
BEGIN
    CREATE TABLE funcionario_reset_token (
        id              INT IDENTITY PRIMARY KEY,
        id_funcionario  INT NOT NULL,
        token           VARCHAR(64) NOT NULL UNIQUE,
        expires_at      DATETIME2    NOT NULL,
        used            BIT          NOT NULL DEFAULT 0,
        created_at      DATETIME2    NOT NULL DEFAULT SYSUTCDATETIME()
    );
END

CREATE OR ALTER PROCEDURE sp_FuncionarioToken_Guardar
    @id_funcionario INT,
    @token          VARCHAR(64),
    @expires_at     DATETIME2
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO funcionario_reset_token (id_funcionario, token, expires_at, used)
    VALUES (@id_funcionario, @token, @expires_at, 0);
END

CREATE OR ALTER PROCEDURE sp_FuncionarioToken_Obtener
    @token VARCHAR(64)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1
        frt.id_funcionario,
        frt.token,
        frt.expires_at,
        frt.used,
        f.nombre_usuario,
        f.correo
    FROM funcionario_reset_token frt
    INNER JOIN funcionario f ON f.id_funcionario = frt.id_funcionario
    WHERE frt.token = @token;
END

CREATE OR ALTER PROCEDURE sp_FuncionarioToken_MarcarUsado
    @token VARCHAR(64)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE funcionario_reset_token
    SET used = 1
    WHERE token = @token;
END



CREATE OR ALTER PROCEDURE sp_FuncionarioToken_Guardar
    @id_funcionario INT,
    @token          VARCHAR(64),
    @expires_at     DATETIME2
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO funcionario_reset_token (id_funcionario, token, expires_at, used)
    VALUES (@id_funcionario, @token, @expires_at, 0);
END

---------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_RecuperarContrasena
    @correo VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1 
        id_funcionario,
        nombre_usuario,
        rut,
        correo,
        contraseña AS contrasena
    FROM funcionario
    WHERE correo = @correo;
END
GO

/* 2) Tabla de tokens (si no existe) */
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'funcionario_reset_token')
BEGIN
    CREATE TABLE funcionario_reset_token (
        id              INT IDENTITY PRIMARY KEY,
        id_funcionario  INT NOT NULL,
        token           VARCHAR(64) NOT NULL UNIQUE,
        expires_at      DATETIME2    NOT NULL,
        used            BIT          NOT NULL DEFAULT 0,
        created_at      DATETIME2    NOT NULL DEFAULT SYSUTCDATETIME()
        -- Opcional (recomendado):
        -- FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
    );
END
GO

/* 3) Guardar token */
CREATE OR ALTER PROCEDURE sp_FuncionarioToken_Guardar
    @id_funcionario INT,
    @token          VARCHAR(64),
    @expires_at     DATETIME2
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO funcionario_reset_token (id_funcionario, token, expires_at, used)
    VALUES (@id_funcionario, @token, @expires_at, 0);
END
GO

/* 4) Obtener token */
CREATE OR ALTER PROCEDURE sp_FuncionarioToken_Obtener
    @token VARCHAR(64)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1
        frt.id_funcionario,
        frt.token,
        frt.expires_at,
        frt.used,
        f.nombre_usuario,
        f.correo
    FROM funcionario_reset_token frt
    INNER JOIN funcionario f ON f.id_funcionario = frt.id_funcionario
    WHERE frt.token = @token;
END
GO

/* 5) Marcar token como usado */
CREATE OR ALTER PROCEDURE sp_FuncionarioToken_MarcarUsado
    @token VARCHAR(64)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE funcionario_reset_token
    SET used = 1
    WHERE token = @token;
END




CREATE OR ALTER PROCEDURE dbo.sp_FuncionarioToken_Guardar
    @id_funcionario INT,
    @token          VARCHAR(64),
    @expires_at     DATETIME2
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO funcionario_reset_token (id_funcionario, token, expires_at, used)
    VALUES (@id_funcionario, @token, @expires_at, 0);
END
GO

EXEC sp_RecuperarContrasena @correo = 'a.gallardog@escuelapdi.cl';

SELECT TOP 1 * 
FROM funcionario_reset_token 
ORDER BY id DESC;