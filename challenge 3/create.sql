DROP TABLE IF EXISTS christmas_menus CASCADE;

CREATE TABLE christmas_menus (
  id SERIAL PRIMARY KEY,
  menu_data XML
);