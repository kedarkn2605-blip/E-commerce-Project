CREATE TABLE product (
  product_id NUMBER PRIMARY KEY,
  product_name VARCHAR2(50),
  MRP NUMBER(10,2),
  stock NUMBER,
  brand VARCHAR2(255),
  category_id NUMBER,
  seller_id NUMBER,
  FOREIGN KEY (category_id)
    REFERENCES category(category_id)
    ON DELETE SET NULL,
  FOREIGN KEY (seller_id)
    REFERENCES seller(seller_id)
    ON DELETE SET NULL
);
