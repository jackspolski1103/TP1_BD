-- Eliminación de las tablas si ya existen con CASCADE
DROP TABLE IF EXISTS Pasajero CASCADE;;
DROP TABLE IF EXISTS Equipaje CASCADE;;
DROP TABLE IF EXISTS Pasaje CASCADE;;
DROP TABLE IF EXISTS Vuelo CASCADE;;
DROP TABLE IF EXISTS Configuracion_de_vuelo CASCADE;;
DROP TABLE IF EXISTS Aerolinea CASCADE;;
DROP TABLE IF EXISTS Aeropuerto CASCADE;
DROP TABLE IF EXISTS Terminal CASCADE;
DROP TABLE IF EXISTS Mostrador CASCADE;
DROP TABLE IF EXISTS PuertaEmbarque CASCADE;
DROP TABLE IF EXISTS Negocio CASCADE;
DROP TABLE IF EXISTS Empleado CASCADE;
DROP TABLE IF EXISTS Pasaje_reserva_Vuelo CASCADE;
DROP TABLE IF EXISTS Puerta_de_Embarque_asignada_Vuelo CASCADE;
DROP TABLE IF EXISTS Negocio_tiene_Empleado CASCADE;
DROP TABLE IF EXISTS Aerolinea_tiene_Empleado CASCADE;
DROP TABLE IF EXISTS Mostrador_pertenece_a_Aerolinea CASCADE;
DROP TABLE IF EXISTS Configuracion_de_vuelo_es_de_Aerolinea CASCADE;


-- Creación de la tabla Pasajero
CREATE TABLE Pasajero (
    Numero_Pasaporte VARCHAR(50) PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(150),
    Fecha_de_Nacimiento DATE,
    Nacionalidad VARCHAR(50)
);

-- Creación de la tabla Pasaje
CREATE TABLE Pasaje (
    Codigo_de_pasaje SERIAL PRIMARY KEY,
    Numero_Pasaporte VARCHAR(50) REFERENCES Pasajero(Numero_Pasaporte),
    Clase VARCHAR(50),
    Estado VARCHAR(50)
);

-- Creación de la tabla Equipaje
CREATE TABLE Equipaje (
    ID_equipaje SERIAL PRIMARY KEY,
    Codigo_de_pasaje INTEGER REFERENCES Pasaje(Codigo_de_pasaje),
    Peso DECIMAL(5,2),
    Tipo VARCHAR(50),
    Fragilidad BOOLEAN
);

-- Creación de la tabla Aeropuerto
CREATE TABLE Aeropuerto (
    Codigo_aeropuerto VARCHAR(50) PRIMARY KEY,
    Nombre VARCHAR(150),
    Ciudad VARCHAR(150),
    Pais VARCHAR(150),
    Direccion VARCHAR(150),
    Tipo VARCHAR(50)
);

-- Creación de la tabla Configuracion_de_vuelo
CREATE TABLE Configuracion_de_vuelo (
    Codigo_de_vuelo VARCHAR(50) PRIMARY KEY,
    Codigo_aeropuerto_sale VARCHAR(50) REFERENCES Aeropuerto(Codigo_aeropuerto),
    Codigo_aeropuerto_llega VARCHAR(50) REFERENCES Aeropuerto(Codigo_aeropuerto)
);

-- Creación de la tabla Vuelo
CREATE TABLE Vuelo (
    Fecha DATE,
    Codigo_de_vuelo VARCHAR(50) REFERENCES Configuracion_de_vuelo(Codigo_de_vuelo),
    Duracion INTEGER, --horas
    ModeloAvion VARCHAR(50),
    Hora TIME,
    Demorado BOOLEAN, -- Si o No
    PRIMARY KEY(Fecha, Codigo_de_vuelo)
);

-- Creación de la tabla Aerolinea
CREATE TABLE Aerolinea (
    Nombre VARCHAR(50) PRIMARY KEY,
    Grupo_de_Alianza VARCHAR(50)
);

-- Creación de la tabla Terminal
CREATE TABLE Terminal (
    Numero_terminal INTEGER,
    Codigo_aeropuerto VARCHAR(50) REFERENCES Aeropuerto(Codigo_aeropuerto),
    Tipo VARCHAR(50),
    Salida BOOLEAN, -- Si o No
    PRIMARY KEY(Numero_terminal, Codigo_aeropuerto)
);


-- Creación de la tabla Mostrador
CREATE TABLE Mostrador (
    Numero_mostrador INTEGER,
    Numero_terminal INTEGER,
    Codigo_aeropuerto VARCHAR(50),
    PRIMARY KEY(Numero_mostrador, Numero_terminal, Codigo_aeropuerto),
    FOREIGN KEY (Numero_terminal, Codigo_aeropuerto) REFERENCES Terminal(Numero_terminal, Codigo_aeropuerto)
);


-- Creación de la tabla PuertaEmbarque
CREATE TABLE PuertaEmbarque (
    Numero_puerta INTEGER,
    Numero_terminal INTEGER,
    Codigo_aeropuerto VARCHAR(50),
    Manga BOOLEAN, -- Si o No
    PRIMARY KEY(Numero_puerta, Numero_terminal, Codigo_aeropuerto),
    FOREIGN KEY (Numero_terminal, Codigo_aeropuerto) REFERENCES Terminal(Numero_terminal, Codigo_aeropuerto)
);

-- Creación de la tabla Negocio
CREATE TABLE Negocio (
    Nombre VARCHAR(50),
    Numero_terminal INTEGER,
    Codigo_aeropuerto VARCHAR(50),
    Rubro VARCHAR(50),
    Promedio_Ingresos_Diarios VARCHAR(50),
    
    Tipo VARCHAR(50),
    PRIMARY KEY(Nombre, Numero_terminal, Codigo_aeropuerto),
    FOREIGN KEY (Numero_terminal, Codigo_aeropuerto) REFERENCES Terminal(Numero_terminal, Codigo_aeropuerto)
);

-- Creación de la tabla Empleado
CREATE TABLE Empleado (
    Codigo_empleado INTEGER PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    DNI INTEGER,
    Edad INTEGER,
    Antiguedad INTEGER,
    Cargo VARCHAR(50),
    Tipo VARCHAR(50)
);

-- Creación de la tabla Pasaje_reserva_Vuelo
CREATE TABLE Pasaje_reserva_Vuelo (
    Asiento VARCHAR(50),
    Codigo_de_pasaje INTEGER REFERENCES Pasaje(Codigo_de_pasaje),
    Fecha DATE,
    Codigo_de_vuelo VARCHAR(50),
    PRIMARY KEY(Codigo_de_pasaje, Fecha, Codigo_de_vuelo),
    FOREIGN KEY (Fecha, Codigo_de_vuelo) REFERENCES Vuelo(Fecha, Codigo_de_vuelo)
);

-- Creación de la tabla Puerta_de_Embarque_asignada_Vuelo
CREATE TABLE Puerta_de_Embarque_asignada_Vuelo (
    Fecha DATE,
    Codigo_de_vuelo VARCHAR(50),
    Numero_terminal INTEGER,
    Numero_puerta INTEGER,
    Codigo_aeropuerto VARCHAR(50),
    PRIMARY KEY(Fecha, Codigo_de_vuelo, Numero_terminal, Numero_puerta, Codigo_aeropuerto),
    FOREIGN KEY (Numero_puerta, Numero_terminal, Codigo_aeropuerto) REFERENCES PuertaEmbarque(Numero_puerta, Numero_terminal, Codigo_aeropuerto),
    FOREIGN KEY (Fecha, Codigo_de_vuelo) REFERENCES Vuelo(Fecha, Codigo_de_vuelo)

);

-- Creación de la tabla Negocio_tiene_Empleado
CREATE TABLE Negocio_tiene_Empleado (
    Codigo_empleado INTEGER PRIMARY KEY REFERENCES Empleado(Codigo_empleado),
    Nombre_negocio VARCHAR(50),
    Numero_terminal INTEGER,
    Codigo_aeropuerto VARCHAR(50),
    FOREIGN KEY (Nombre_negocio, Numero_terminal, Codigo_aeropuerto) REFERENCES Negocio(Nombre, Numero_terminal, Codigo_aeropuerto)
);

-- Creación de la tabla Aerolinea_tiene_Empleado
CREATE TABLE Aerolinea_tiene_Empleado (
    Codigo_empleado INTEGER PRIMARY KEY REFERENCES Empleado(Codigo_empleado),
    Nombre_aerolinea VARCHAR(50) REFERENCES Aerolinea(Nombre)
);

-- Creación de la tabla Mostrador_pertenece_a_Aerolinea
CREATE TABLE Mostrador_pertenece_a_Aerolinea (
    Nombre_aerolinea VARCHAR(50) REFERENCES Aerolinea(Nombre),
    Numero_mostrador INTEGER,
    Numero_terminal INTEGER,
    Codigo_aeropuerto VARCHAR(50),
    PRIMARY KEY(Numero_mostrador, Numero_terminal, Codigo_aeropuerto, Nombre_aerolinea),
    FOREIGN KEY (Numero_mostrador, Numero_terminal, Codigo_aeropuerto) REFERENCES Mostrador(Numero_mostrador, Numero_terminal, Codigo_aeropuerto)
);

-- Creación de la tabla Configuracion_de_vuelo_es_de_Aerolinea
CREATE TABLE Configuracion_de_vuelo_es_de_Aerolinea (
    Codigo_de_vuelo VARCHAR(50) PRIMARY KEY REFERENCES Configuracion_de_vuelo(Codigo_de_vuelo),
    Nombre_aerolinea VARCHAR(50) REFERENCES Aerolinea(Nombre)
);