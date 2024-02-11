CREATE TABLE users(
    id serial PRIMARY KEY,
    first_name VARCHAR(256) NOT NULL CHECK(first_name != ''),
    last_name VARCHAR(256) NOT NULL CHECK(last_name != ''),
    birthdate DATE CHECK (birthdate < current_date),
    email VARCHAR(300) NOT NULL CHECK(email != ''),
    address text,
    phone VARCHAR(16)
);

CREATE TABLE medicines (
    id serial PRIMARY KEY,
    active_substance VARCHAR(300) NOT NULL CHECK(active_substance != ''),
    dosage decimal(16,2) NOT NULL CHECK (dosage > 0),
    price decimal(16,2) NOT NULL CHECK (price > 0),
    quantity int NOT NULL CHECK (quantity >= 0) 
);

CREATE TABLE pharmacies (
    id serial PRIMARY KEY,
    name VARCHAR(256) NOT NULL CHECK(name != ''),
    city VARCHAR(256) NOT NULL CHECK(city != ''),
    place VARCHAR(256) NOT NULL CHECK(place != ''),
    street VARCHAR(256) NOT NULL CHECK(street != ''),
    house int NOT NULL,
    phone VARCHAR(16) CHECK(phone != '')
);
  CREATE TABLE pharmacies_to_medicines (
    pharmacy_id int REFERENCES pharmacies(id),
    medicine_id int REFERENCES medicines(id),
    quantity int NOT NULL CHECK (quantity >= 0),
    PRIMARY KEY (pharmacy_id, medicine_id)
);
CREATE TABLE orders(
    id serial PRIMARY KEY,
    created_at timestamp CHECK (created_at <= current_timestamp) DEFAULT current_timestamp,
    customer_id int REFERENCES users(id),
    pharmacy_id int REFERENCES pharmacies(id),
    UNIQUE (pharmacy_id, id)
);
CREATE TABLE orders_to_medicines (
    order_id int NOT NULL,
    pharmacy_id int NOT NULL,
    medicine_id int NOT NULL,
    quantity int NOT NULL CHECK(quantity > 0),
    PRIMARY KEY (order_id, medicine_id),
    FOREIGN KEY (pharmacy_id, order_id) REFERENCES orders(pharmacy_id, id),
    FOREIGN KEY (pharmacy_id, medicine_id) REFERENCES pharmacies_to_medicines(pharmacy_id, medicine_id)
);
