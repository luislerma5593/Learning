
SELECT id, nombre, edad =
CASE edad
	WHEN 17 THEN 'Menor'
    ELSE 'Mayor'
END
FROM usuarios;
 