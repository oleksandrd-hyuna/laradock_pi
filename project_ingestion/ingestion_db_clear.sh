mysql -uroot -proot -h mysql -e "
DROP DATABASE IF EXISTS playster_content; 
DROP DATABASE IF EXISTS playster_ingestion;
DROP DATABASE IF EXISTS playster_reporting;
CREATE DATABASE playster_content CHARACTER SET latin1 COLLATE latin1_swedish_ci;
CREATE DATABASE playster_ingestion CHARACTER SET latin1 COLLATE latin1_swedish_ci;
CREATE DATABASE playster_reporting CHARACTER SET latin1 COLLATE latin1_swedish_ci;
"
php migration.php -db content migrations:migrate
php migration.php -db ingestion migrations:migrate
php migration.php -db reporting migrations:migrate

mysql -uroot -proot -h mysql -e "

ALTER TABLE playster_ingestion.ingestion_failed_items
 MODIFY COLUMN reason
 VARCHAR(2500) NOT NULL;

TRUNCATE TABLE playster_content.movie;
"
