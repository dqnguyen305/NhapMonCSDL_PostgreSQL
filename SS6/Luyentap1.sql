create table product (
	id serial primary key,
	name varchar(100),
	category varchar(50),
	price numeric(10,2),
	stock int
);

--Thêm 5 sản phẩm vào bảng bằng lệnh INSERT
INSERT INTO product (name, category, price, stock) VALUES
('máy tính', 'điện tử', 19000.00, 3),
('TV', 'điện tử', 18000.00, 9),
('điện thoại', 'điện tử', 17000.00, 4),
('Doremon', 'sách', 1000.00, 7),
('Conan', 'sách', 2000.00, 5);
--Hiển thị danh sách toàn bộ sản phẩm
Select * from product;
--Hiển thị 3 sản phẩm có giá cao nhất
select * from product
order by price desc limit 3;
--Hiển thị các sản phẩm thuộc danh mục “Điện tử” có giá nhỏ hơn 10,000,000
select * from product
where category = 'điện tử' and price < 10000000;
--Sắp xếp sản phẩm theo số lượng tồn kho tăng dần
select * from product
order by stock;