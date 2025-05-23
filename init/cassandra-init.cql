CREATE KEYSPACE iotdata WITH replication = {
  'class': 'SimpleStrategy',
  'replication_factor': 1
};

USE iotdata;

CREATE TABLE sensor_readings (
  sensor_id text,
  waktu timestamp,
  temperatur float,
  kelembapan float,
  PRIMARY KEY (sensor_id, waktu)
) WITH CLUSTERING ORDER BY (waktu ASC);

-- Masukkan data dummy
INSERT INTO sensor_readings (sensor_id, waktu, temperatur, kelembapan)
VALUES ('S101', '2025-05-17T10:00:00Z', 26.5, 60.0);
INSERT INTO sensor_readings (sensor_id, waktu, temperatur, kelembapan)
VALUES ('S101', '2025-05-17T11:00:00Z', 27.0, 59.0);
INSERT INTO sensor_readings (sensor_id, waktu, temperatur, kelembapan)
VALUES ('S101', '2025-05-17T12:00:00Z', 27.3, 58.5);
INSERT INTO sensor_readings (sensor_id, waktu, temperatur, kelembapan)
VALUES ('S102', '2025-05-17T10:00:00Z', 24.5, 63.0);
INSERT INTO sensor_readings (sensor_id, waktu, temperatur, kelembapan )
VALUES ('S102', '2025-05-17T11:00:00Z', 25.1, 62.0);
