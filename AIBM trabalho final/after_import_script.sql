-- Primeiro usar o Table Data Import Wizard, importar dados para urg_inform_geralurg_inform_geral deixar os tipos das colunas como 
-- sugerido no wizard, mas mudar o tipo de DATAHORA_ADM e DATAHORA_ALTA para 
-- datetime este script actualiza o tipo de DTA_NASCIMENTO para data porque nao
-- podemos usar 2 formatos de DateTime no wizard

SET SQL_SAFE_UPDATES = 0;
UPDATE urg_inform_geral
SET DTA_NASCIMENTO = str_to_date(DTA_NASCIMENTO, "%Y-%m-%d");

ALTER TABLE urg_inform_geral MODIFY DTA_NASCIMENTO DATE;

-- confirmar se mudou direito
SHOW FIELDS FROM urg_inform_geral;
