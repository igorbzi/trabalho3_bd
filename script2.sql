call call_all(1000, 500, 1200);

CREATE INDEX indice_sale on sale (sdate, address);

GRANT ALL ON SCHEMA esquema1 TO usuario2;

GRANT SELECT ON product TO usuario2;
GRANT SELECT ON sale TO usuario2;
GRANT ALL ON sale_item TO usuario2;
GRANT INSERT ON log_sale_item TO usuario2;