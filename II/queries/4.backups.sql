-- Backup de la base de datos Jardineria
BACKUP DATABASE Jardineria
TO DISK = '/var/backups/Jardineria_Backup.bak'
WITH FORMAT, INIT, NAME = 'Jardineria Full Backup';

-- Backup de la base de datos Staging
BACKUP DATABASE Staging
TO DISK = '/var/backups/Staging_Backup.bak'
WITH FORMAT, INIT, NAME = 'Staging Full Backup'; 