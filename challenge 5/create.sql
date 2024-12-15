DROP TABLE IF EXISTS toy_production CASCADE;
CREATE TABLE toy_production (
    production_date DATE PRIMARY KEY,
    toys_produced INTEGER
);