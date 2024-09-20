-- Carga de datos
COPY Pasajero(Numero_Pasaporte, Nombre, Apellido, Fecha_de_Nacimiento, Nacionalidad)  FROM '/tmp/archivos_csv/Pasajero.csv' DELIMITER ',' CSV HEADER;
COPY Pasaje(Codigo_de_pasaje, Numero_Pasaporte, Clase, Estado)  FROM '/tmp/archivos_csv/Pasaje.csv' DELIMITER ',' CSV HEADER;
COPY Equipaje(ID_equipaje, Codigo_de_pasaje, Peso, Tipo, Fragilidad)  FROM '/tmp/archivos_csv/Equipaje.csv' DELIMITER ',' CSV HEADER;
COPY Aeropuerto(Codigo_aeropuerto, Nombre, Ciudad, Pais, Direccion, Tipo)  FROM '/tmp/archivos_csv/Aeropuerto.csv' DELIMITER ',' CSV HEADER;
COPY Configuracion_de_vuelo(Codigo_de_vuelo, Codigo_aeropuerto_sale, Codigo_aeropuerto_llega)  FROM '/tmp/archivos_csv/Configuracion de vuelo.csv' DELIMITER ',' CSV HEADER;
COPY Vuelo(Fecha, Codigo_de_vuelo, Duracion, ModeloAvion, Hora, Demorado)  FROM '/tmp/archivos_csv/Vuelo.csv' DELIMITER ',' CSV HEADER;
COPY Aerolinea(Nombre, Grupo_de_Alianza)  FROM '/tmp/archivos_csv/Aerolinea.csv' DELIMITER ',' CSV HEADER;
COPY Terminal(Numero_terminal, Codigo_aeropuerto, Tipo, Salida)  FROM '/tmp/archivos_csv/Terminal.csv' DELIMITER ',' CSV HEADER;
COPY Mostrador(Numero_mostrador, Numero_terminal, Codigo_aeropuerto)  FROM '/tmp/archivos_csv/Mostrador.csv' DELIMITER ',' CSV HEADER;
COPY PuertaEmbarque(Numero_puerta, Numero_terminal, Codigo_aeropuerto, Manga)  FROM '/tmp/archivos_csv/PuertaEmbarque.csv' DELIMITER ',' CSV HEADER;
COPY Negocio(Nombre, Numero_terminal, Codigo_aeropuerto, Rubro, Promedio_Ingresos_Diarios, Tipo)  FROM '/tmp/archivos_csv/Negocio.csv' DELIMITER ',' CSV HEADER;
COPY Empleado(Codigo_empleado, Nombre, Apellido, DNI, Edad, Antiguedad, Cargo, Tipo)  FROM '/tmp/archivos_csv/Empleado.csv' DELIMITER ',' CSV HEADER;
COPY Pasaje_reserva_Vuelo(Asiento, Codigo_de_pasaje, Fecha, Codigo_de_vuelo)  FROM '/tmp/archivos_csv/Pasaje_reserva_Vuelo.csv' DELIMITER ',' CSV HEADER;
COPY Puerta_de_Embarque_asignada_Vuelo(Fecha, Codigo_de_vuelo, Numero_terminal, Numero_puerta, Codigo_aeropuerto)  FROM '/tmp/archivos_csv/Puerta_de_Embarque_asignada_Vuelo.csv' DELIMITER ',' CSV HEADER;
COPY Negocio_tiene_Empleado(Codigo_empleado, Nombre_negocio, Numero_terminal, Codigo_aeropuerto)  FROM '/tmp/archivos_csv/Negocio_tiene_Empleado.csv' DELIMITER ',' CSV HEADER;
COPY Aerolinea_tiene_Empleado(Codigo_empleado, Nombre_aerolinea)  FROM '/tmp/archivos_csv/Aerolinea_tiene_Empleado.csv' DELIMITER ',' CSV HEADER;
COPY Mostrador_pertenece_a_Aerolinea(Nombre_aerolinea, Numero_mostrador, Numero_terminal, Codigo_aeropuerto)  FROM '/tmp/archivos_csv/Mostrador_pertenece_a_Aerolinea.csv' DELIMITER ',' CSV HEADER;
COPY Configuracion_de_vuelo_es_de_Aerolinea(Codigo_de_vuelo, Nombre_aerolinea)  FROM '/tmp/archivos_csv/Configuracion_de_vuelo_es_de_Aerolinea.csv' DELIMITER ',' CSV HEADER;

