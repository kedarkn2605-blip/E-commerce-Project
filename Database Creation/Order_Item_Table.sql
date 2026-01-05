CREATE TABLE orderitem (
  order_id NUMBER,
  product_id NUMBER,
  MRP NUMBER(10,2),
  quantity NUMBER,
  PRIMARY KEY (order_id, product_id),
  FOREIGN KEY (order_id)
    REFERENCES order_table(order_id)
    ON DELETE CASCADE,
  FOREIGN KEY (product_id)
    REFERENCES product(product_id)
    ON DELETE CASCADE
);
