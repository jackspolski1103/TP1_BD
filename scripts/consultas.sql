SELECT * FROM Vuelo;
-- 1. Obtener todos los vuelos de una aerolínea específica en un día particular
-- Agregar Configuraciones de vuelo y Vuelos
SELECT V.Codigo_de_vuelo, V.Fecha, V.Hora, V.Duracion, V.ModeloAvion
FROM Vuelo V
JOIN Configuracion_de_vuelo_es_de_Aerolinea CEA ON V.Codigo_de_vuelo = CEA.Codigo_de_vuelo
WHERE CEA.Nombre_aerolinea = 'Air Kuwait'
AND V.Fecha = '2024-09-17';

-- 2. Cantidad de empleados por aerolínea
-- Agregar Empleados y Empleados que pertenecen a aerolíneas
SELECT A.Nombre AS Aerolinea, COUNT(E.Codigo_empleado) AS Total_Empleados
FROM Aerolinea A
JOIN Aerolinea_tiene_Empleado AE ON A.Nombre = AE.Nombre_aerolinea
JOIN Empleado E ON AE.Codigo_empleado = E.Codigo_empleado
GROUP BY A.Nombre;

-- 3. Peso total del equipaje por pasaje
SELECT P.Codigo_de_pasaje, SUM(E.Peso) AS Peso_Total
FROM Equipaje E
JOIN Pasaje P ON E.Codigo_de_pasaje = P.Codigo_de_pasaje
GROUP BY P.Codigo_de_pasaje;

-- 4. Pasajeros que tienen vuelos demorados 
-- Agregar Vuelos Demorados (hay que agregar configuraciones de vuelos, vuelos y pasajeros)
SELECT PA.Nombre, PA.Apellido, V.Codigo_de_vuelo, V.Fecha, V.Hora
FROM Pasajero PA
JOIN Pasaje P ON PA.Numero_Pasaporte = P.Numero_Pasaporte
JOIN Pasaje_reserva_Vuelo PRV ON P.Codigo_de_pasaje = PRV.Codigo_de_pasaje
JOIN Vuelo V ON PRV.Fecha = V.Fecha AND PRV.Codigo_de_vuelo = V.Codigo_de_vuelo
WHERE V.Demorado = TRUE;

-- 5. Mostradores asignados a una aerolínea en un aeropuerto específico
-- Agregar Mostradores, Mostradores asignados a aerolíneas
SELECT 
    M.Numero_mostrador,
    M.Numero_terminal,
    M.Codigo_aeropuerto,
    A.Nombre AS Nombre_aerolinea
FROM 
    Mostrador M
JOIN 
    Mostrador_pertenece_a_Aerolinea MPA 
    ON M.Numero_mostrador = MPA.Numero_mostrador 
    AND M.Numero_terminal = MPA.Numero_terminal 
    AND M.Codigo_aeropuerto = MPA.Codigo_aeropuerto
JOIN 
    Aerolinea A 
    ON MPA.Nombre_aerolinea = A.Nombre
WHERE 
    A.Nombre = 'Air Kuwait' 
    AND M.Codigo_aeropuerto = 'GIG';


-- 6. Puertas de embarque asignadas a una aerolínea en un aeropuerto específico
-- Agregar Puertas de Embarque, Puertas de Embarque asignadas a vuelos
SELECT P.Numero_puerta, P.Numero_terminal, P.Codigo_aeropuerto, PE.Fecha, PE.Codigo_de_vuelo
FROM PuertaEmbarque P
JOIN Puerta_de_Embarque_asignada_Vuelo PE 
    ON P.Numero_puerta = PE.Numero_puerta 
    AND P.Numero_terminal = PE.Numero_terminal 
    AND P.Codigo_aeropuerto = PE.Codigo_aeropuerto
JOIN Vuelo V ON PE.Codigo_de_vuelo = V.Codigo_de_vuelo AND PE.Fecha = V.Fecha
JOIN Configuracion_de_vuelo_es_de_Aerolinea CVA ON V.Codigo_de_vuelo = CVA.Codigo_de_vuelo
JOIN Aerolinea A ON CVA.Nombre_aerolinea = A.Nombre
WHERE A.Nombre = 'Air Canada'
AND P.Codigo_aeropuerto = 'EZE';


-- 7. Total de vuelos por aerolínea en un rango de fechas
-- Agregar Configuraciones de vuelo y Vuelos

SELECT CEA.Nombre_aerolinea, COUNT(V.Codigo_de_vuelo) AS Total_Vuelos
FROM Vuelo V
JOIN Configuracion_de_vuelo_es_de_Aerolinea CEA ON V.Codigo_de_vuelo = CEA.Codigo_de_vuelo
WHERE V.Fecha BETWEEN '2024-09-01' AND '2024-09-30'
GROUP BY CEA.Nombre_aerolinea;

-- 8. Aerolíneas con el promedio de antigüedad más alto de sus empleados
-- Agregar Empleados y Empleados que pertenecen a aerolíneas
SELECT A.Nombre AS Aerolinea, AVG(E.Antiguedad) AS Promedio_Antiguedad
FROM Aerolinea A
JOIN Aerolinea_tiene_Empleado AE ON A.Nombre = AE.Nombre_aerolinea
JOIN Empleado E ON AE.Codigo_empleado = E.Codigo_empleado
GROUP BY A.Nombre
HAVING AVG(E.Antiguedad) = (SELECT (AVG(E.Antiguedad))
                             FROM Aerolinea A
                             JOIN Aerolinea_tiene_Empleado AE ON A.Nombre = AE.Nombre_aerolinea
                             JOIN Empleado E ON AE.Codigo_empleado = E.Codigo_empleado
                             GROUP BY A.Nombre
                             LIMIT 1);

-- 9. Aeropuertos con la mayor cantidad de vuelos en los últimos 30 días
-- Agregar Configuraciones de vuelo y Vuelos
SELECT A.Nombre, COUNT(V.Codigo_de_vuelo) AS Total_Vuelos
FROM Aeropuerto A
JOIN Configuracion_de_vuelo CV ON A.Codigo_aeropuerto = CV.Codigo_aeropuerto_sale
JOIN Vuelo V ON CV.Codigo_de_vuelo = V.Codigo_de_vuelo
WHERE V.Fecha BETWEEN CURRENT_DATE - INTERVAL '30 days' AND CURRENT_DATE
GROUP BY A.Nombre
ORDER BY Total_Vuelos DESC
LIMIT 10;

-- 10. Pasajeros frecuentes que han reservado más de un pasaje en los últimos 30 días
-- Agregar Pasajeros y Pasajes
SELECT PA.Nombre, PA.Apellido, COUNT(P.Codigo_de_pasaje) AS Total_Pasajes
FROM Pasajero PA
JOIN Pasaje P ON PA.Numero_Pasaporte = P.Numero_Pasaporte
JOIN Pasaje_reserva_Vuelo PRV ON P.Codigo_de_pasaje = PRV.Codigo_de_pasaje
WHERE PRV.Fecha BETWEEN CURRENT_DATE - INTERVAL '30 days' AND CURRENT_DATE
GROUP BY PA.Nombre, PA.Apellido
HAVING COUNT(P.Codigo_de_pasaje) > 1;

