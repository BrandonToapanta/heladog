/* Crear la base de datos */
drop database tienda_helodog;
create database tienda_helodog;

use tienda_helodog;

 /* Crear tabla categoria */
CREATE TABLE categoria (
    categoria_id int PRIMARY KEY AUTO_INCREMENT,
    categoria_codigo varchar(10) NOT NULL,
    categoria_nombre varchar(80) NOT NULL
);

 /* Crear tabla producto */
CREATE TABLE producto (
    producto_id int PRIMARY KEY AUTO_INCREMENT,
    categoria_id int,
    producto_codigo varchar(10) NOT NULL,
    producto_nombre varchar(80) NOT NULL,
    producto_stock int,
    producto_precio DECIMAL(10, 2),
    producto_peso DECIMAL(10, 2),
    FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id)
);

 /* Crear tabla tienda */
CREATE TABLE tienda (
    tienda_id int PRIMARY KEY AUTO_INCREMENT,
    tienda_codigo varchar(10) NOT NULL,
    tienda_nombre varchar(30) NOT NULL,
    tienda_telefono varchar(10),
    tienda_direccion varchar(150)
);

 /* Crear tabla metodoPago */
CREATE TABLE metodoPago (
    mpago_id int PRIMARY KEY AUTO_INCREMENT,
    mpago_tipo varchar(30) NOT NULL,
    mpago_numero varchar(15),
    mpago_propietario varchar(80),
    mpago_fechaVencimiento DATE
);

 /* Crear tabla usuario */
CREATE TABLE usuario (
    user_id int PRIMARY KEY AUTO_INCREMENT,
    mpago_id int,
    user_nombres varchar(80) NOT NULL,
    user_telefono varchar(10),
    user_cedula varchar(10),
    user_genero varchar(15),
    user_correo varchar(150),
    user_direccion varchar(150),
    FOREIGN KEY (mpago_id) REFERENCES metodoPago(mpago_id)
);

 /* Crear tabla carrito */
CREATE TABLE carrito (
    carrito_id int PRIMARY KEY AUTO_INCREMENT,
    user_id int,
    carrito_codigo varchar(10) NOT NULL,
    carrito_cantidad int,
    carrito_precioUnitario DECIMAL(10, 2),
    carrito_precioTotal DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES usuario(user_id)
);

 /* Crear tabla cabezaFactura */
CREATE TABLE cabezaFactura (
    Cfactura_id int PRIMARY KEY AUTO_INCREMENT,
    user_id int,
    tienda_id int,
    FOREIGN KEY (user_id) REFERENCES usuario(user_id),
    FOREIGN KEY (tienda_id) REFERENCES tienda(tienda_id)
);

 /* Crear tabla factura */
CREATE TABLE factura (
    factura_id int PRIMARY KEY AUTO_INCREMENT,
    carrito_id int UNIQUE,
    Cfactura_id int,
    factura_descuento DECIMAL(10, 2),
    factura_iva DECIMAL(10, 2),
    factura_precioFinal DECIMAL(10, 2),
    FOREIGN KEY (carrito_id) REFERENCES carrito(carrito_id),
    FOREIGN KEY (Cfactura_id) REFERENCES cabezaFactura(Cfactura_id)
);

 /* Crear tabla productotienda */
CREATE TABLE productotienda (
    ptienda_id int PRIMARY KEY AUTO_INCREMENT,
    tienda_id int,
    producto_id int,
    FOREIGN KEY (tienda_id) REFERENCES tienda(tienda_id),
    FOREIGN KEY (producto_id) REFERENCES producto(producto_id)
);

 /* Crear tabla productocarrito */
CREATE TABLE productocarrito (
    pcarrito_id int PRIMARY KEY AUTO_INCREMENT,
    carrito_id int,
    producto_id int,
    FOREIGN KEY (carrito_id) REFERENCES carrito(carrito_id),
    FOREIGN KEY (producto_id) REFERENCES producto(producto_id)
);

/* Indices */

 /* Crear índice en la tabla producto */
CREATE INDEX idx_producto_categoria_id ON producto (categoria_id);
CREATE INDEX idx_producto_producto_id ON producto (producto_id);
CREATE INDEX idx_producto_producto_nombre ON producto (producto_nombre);

 /* Crear índice en la tabla factura */
CREATE INDEX idx_factura_carrito_id ON factura (carrito_id);
CREATE INDEX idx_cabezafactura_cfactura_id ON cabezaFactura (Cfactura_id);
CREATE INDEX idx_factura_Cfactura_id ON factura (Cfactura_id);

 /* Crear índice en la tabla categoria */
CREATE INDEX idx_categoria_categoria_nombre ON categoria (categoria_nombre);

 /* Crear índice en la tabla usuario */
CREATE INDEX idx_usuario_user_nombres ON usuario (user_nombres);
CREATE INDEX idx_usuario_user_correo ON usuario (user_correo);

/* Crear índice en la tabla carrito para la búsqueda por usuario */
CREATE INDEX idx_carrito_user_id ON carrito (user_id);
CREATE INDEX idx_carrito_carrito_id ON carrito (carrito_id);
CREATE INDEX idx_productocarrito_carrito_id ON productocarrito (carrito_id);
CREATE INDEX idx_productocarrito_producto_id ON productocarrito (producto_id);

/* Crear índice en la tabla metodoPago para la búsqueda por tipo de pago */
CREATE INDEX idx_metodo_pago_mpago_tipo ON metodoPago (mpago_tipo);


/* Ingreso de datos a la tabla.... prueba!!!! */

 /* Insertar datos en la tabla categoria */
INSERT intO categoria (categoria_codigo, categoria_nombre) VALUES
('001', 'Alimentos'),
('002', 'Accesorios'),
('003', 'Juguetes'),
('004', 'Higiene'),
('005', 'Transporte'),
('006', 'Ropa'),
('007', 'Camas'),
('008', 'Collares'),
('009', 'Correas'),
('010', 'Otros');

 /* Insertar datos en la tabla producto */
INSERT intO producto (categoria_id, producto_codigo, producto_nombre, producto_stock, producto_precio, producto_peso) VALUES
(1, 'P001', 'Croquetas', 50, 19.99, 1.5),
(1, 'P002', 'Latas de comida', 30, 2.99, 0.8),
(2, 'P003', 'Collar de nylon', 20, 9.99, 0.2),
(2, 'P004', 'Correa extensible', 15, 14.99, 0.5),
(3, 'P005', 'Pelota de tenis', 25, 4.99, 0.3),
(3, 'P006', 'Juguete masticable', 35, 7.99, 0.4),
(4, 'P007', 'Champú para perros', 40, 8.99, 0.6),
(4, 'P008', 'Toallitas húmedas', 55, 3.99, 0.2),
(5, 'P009', 'Transportín plegable', 10, 29.99, 2.5),
(5, 'P010', 'Bolso de transporte', 12, 39.99, 1.8),
(1, 'P011', 'Snack para perros pequeños', 20, 5.99, 0.1),
(1, 'P012', 'Comida húmeda de pollo', 15, 3.49, 0.2),
(1, 'P013', 'Biscuits de carne', 30, 2.99, 0.3),
(1, 'P014', 'Hueso de cuero', 25, 4.99, 0.4),
(1, 'P015', 'Barritas energéticas', 18, 1.99, 0.1),
(1, 'P016', 'Comida dietética para perros', 12, 8.99, 0.2),
(1, 'P017', 'Croquetas premium', 40, 14.99, 0.5),
(1, 'P018', 'Galletas de avena', 35, 3.99, 0.3),
(1, 'P019', 'Comida seca para cachorros', 30, 9.99, 0.4),
(1, 'P020', 'Snack dental', 50, 6.99, 0.2),
(1, 'P021', 'Comida sin granos', 22, 12.99, 0.6),
(1, 'P022', 'Puré de pollo', 10, 1.49, 0.1),
(1, 'P023', 'Bolitas de carne', 28, 2.49, 0.2),
(1, 'P024', 'Comida vegana para perros', 20, 7.99, 0.3),
(1, 'P025', 'Snack de salmón', 15, 4.49, 0.4);

 /* Insertar datos en la tabla tienda */
INSERT intO tienda (tienda_codigo, tienda_nombre, tienda_telefono, tienda_direccion) VALUES
('T001', 'Heladogs', '123456789', 'Av. Principal 123, Quito');

 /* Insertar datos en la tabla metodoPago */
INSERT intO metodoPago (mpago_tipo, mpago_numero, mpago_propietario, mpago_fechaVencimiento) VALUES
('Tarjeta de crédito', '1234567890123456', 'Juan Pérez', '2025-12-31'),
('Tarjeta de débito', '9876543210987654', 'María Gómez', '2024-06-30'),
('PayPal', 'paypal@example.com', 'Pedro Rodríguez', '2023-10-31'),
('Transferencia bancaria', 'Banco XYZ, Cuenta 1234567890', 'Ana López', NULL),
('Efectivo', NULL, 'Carlos Torres', NULL);

 /* Insertar datos en la tabla usuario */
INSERT intO usuario (mpago_id, user_nombres, user_telefono, user_cedula, user_genero, user_correo, user_direccion) VALUES
(1, 'Juan Pérez', '0987654321', '1712345678', 'M', 'juanperez@example.com', 'Calle Falsa 123, Quito'),
(2, 'María Gómez', '0987654322', '1712345679', 'F', 'mariagomez@example.com', 'Avenida Ficticia 456, Quito'),
(3, 'Pedro Rodríguez', '0987654323', '1712345680', 'M', 'pedrorodriguez@example.com', 'Carrera Inexistente 789, Quito'),
(4, 'Ana López', '0987654324', '1712345681', 'F', 'analopez@example.com', 'Pasaje Irreal 321, Quito'),
(5, 'Carlos Torres', '0987654325', '1712345682', 'M', 'carlostorres@example.com', 'Gral. Desconocido 987, Quito');


 /* Insertar datos en la tabla carrito */
INSERT intO carrito (user_id, carrito_codigo, carrito_cantidad, carrito_precioUnitario, carrito_precioTotal) VALUES
(1, 'C001', 2, 9.99, 19.98),
(1, 'C002', 1, 14.99, 14.99),
(2, 'C003', 3, 4.99, 14.97),
(2, 'C004', 2, 7.99, 15.98),
(3, 'C005', 1, 8.99, 8.99),
(3, 'C006', 4, 3.99, 15.96),
(4, 'C007', 2, 29.99, 59.98),
(4, 'C008', 1, 39.99, 39.99),
(5, 'C009', 2, 19.99, 39.98),
(5, 'C010', 3, 2.99, 8.97);

 /* Insertar datos en la tabla cabezaFactura */
INSERT intO cabezaFactura (user_id, tienda_id) VALUES
(1, 1);

 /* Insertar datos en la tabla factura */
INSERT intO factura (carrito_id, Cfactura_id, factura_descuento, factura_iva, factura_precioFinal) VALUES
(1, 1, 0, 2.5, 34.47);

 /* Insertar datos en la tabla productotienda */
INSERT intO productotienda (tienda_id, producto_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10);

 /* Insertar datos en la tabla productocarrito */
INSERT intO productocarrito (carrito_id, producto_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10);

/* ingreso de una compra con mas comida */

 /* Insertar datos en la tabla carrito para la compra de comida húmeda de pollo */
INSERT intO carrito (user_id, carrito_codigo, carrito_cantidad, carrito_precioUnitario, carrito_precioTotal) VALUES
(1, 'C011', 10, 3.49, 34.90);

 /* Insertar datos en la tabla cabezaFactura para la nueva factura */
INSERT intO cabezaFactura (user_id, tienda_id) VALUES
(1, 1);

 /* Insertar datos en la tabla factura para la nueva factura */
INSERT intO factura (carrito_id, Cfactura_id, factura_descuento, factura_iva, factura_precioFinal) VALUES
(2, 2, 0, 2.5, 34.47);

/* consulta */

SELECT factura.factura_id as Numero_factura, tienda.tienda_nombre as tienda, usuario.user_nombres as nombre_cliente, producto.producto_nombre as producto, producto.producto_precio as precio, producto.producto_peso as peso, 
    carrito.carrito_precioTotal as precio_final,  factura.factura_descuento as descuento, factura.factura_iva as iva, factura.factura_precioFinal as precio_final
FROM cabezafactura
JOIN usuario ON cabezafactura.user_id = usuario.user_id
JOIN tienda ON cabezafactura.tienda_id = tienda.tienda_id
JOIN factura ON cabezafactura.Cfactura_id = factura.Cfactura_id
JOIN carrito ON factura.carrito_id = carrito.carrito_id
JOIN productoCarrito ON carrito.carrito_id = productoCarrito.carrito_id
JOIN producto ON productoCarrito.producto_id = producto.producto_id;
