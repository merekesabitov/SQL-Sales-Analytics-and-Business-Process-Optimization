-- Создаем базу данных NorthWind
CREATE DATABASE NorthWind;

-- Выбираем наш БД для дальнейшей работы
use NorthWind;


-- Создаем таблицы

-- 1. Категории продуктов
CREATE TABLE Categories (
    category_id SMALLINT NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(15) NOT NULL,
    description TEXT,
    picture BLOB,
    PRIMARY KEY (category_id)
);

-- 2. Демографические данные типов клиентов
CREATE TABLE Customer_Demographics (
    customer_type_id VARCHAR(50) NOT NULL,
    customer_desc TEXT,
    PRIMARY KEY (customer_type_id)
);

-- 3. Клиенты компании
CREATE TABLE Customers (
    customer_id VARCHAR(50) NOT NULL,
    company_name VARCHAR(40),
    contact_name VARCHAR(30),
    contact_title VARCHAR(30),
    address VARCHAR(60),
    city VARCHAR(15),
    region VARCHAR(15),
    postal_code VARCHAR(10),
    country VARCHAR(15),
    phone VARCHAR(24),
    fax VARCHAR(24),
    PRIMARY KEY (customer_id)
);

-- 4. Таблица связей между клиентами и демографическими группами
CREATE TABLE Customer_Customer_Demo (
    customer_id VARCHAR(50),
    customer_type_id VARCHAR(50),
    PRIMARY KEY (customer_id, customer_type_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (customer_type_id) REFERENCES Customer_Demographics(customer_type_id)
);

-- 5. Сотрудники компании
CREATE TABLE Employees (
    employee_id SMALLINT NOT NULL AUTO_INCREMENT,
    last_name VARCHAR(20),
    first_name VARCHAR(10),
    title VARCHAR(30),
    title_of_courtesy VARCHAR(25),
    birth_date DATE,
    hire_date DATE,
    address VARCHAR(60),
    city VARCHAR(15),
    region VARCHAR(15),
    postal_code VARCHAR(10),
    country VARCHAR(15),
    home_phone VARCHAR(24),
    extension VARCHAR(4),
    photo BLOB,
    notes TEXT,
    reports_to SMALLINT,
    photo_path VARCHAR(255),
    PRIMARY KEY (employee_id),
    FOREIGN KEY (reports_to) REFERENCES Employees(employee_id)
);

-- 6. Поставщики
CREATE TABLE Suppliers (
    supplier_id SMALLINT NOT NULL AUTO_INCREMENT,
    company_name VARCHAR(40),
    contact_name VARCHAR(30),
    contact_title VARCHAR(30),
    address VARCHAR(60),
    city VARCHAR(15),
    region VARCHAR(15),
    postal_code VARCHAR(10),
    country VARCHAR(15),
    phone VARCHAR(24),
    fax VARCHAR(24),
    homepage TEXT,
    PRIMARY KEY (supplier_id)
);

-- 7. Продукты
CREATE TABLE Products (
    product_id SMALLINT NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(40),
    supplier_id SMALLINT,
    category_id SMALLINT,
    quantity_per_unit VARCHAR(20),
    unit_price FLOAT,
    units_in_stock SMALLINT,
    units_on_order SMALLINT,
    reorder_level SMALLINT,
    discontinued INTEGER,
    PRIMARY KEY (product_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- 8. Регионы
CREATE TABLE Region (
    region_id SMALLINT NOT NULL AUTO_INCREMENT,
    region_description VARCHAR(500),
    PRIMARY KEY (region_id)
);

-- 9. Перевозчики
CREATE TABLE Shippers (
    shipper_id SMALLINT NOT NULL AUTO_INCREMENT,
    company_name VARCHAR(40),
    phone VARCHAR(24),
    PRIMARY KEY (shipper_id)
);

-- 10. Заказы
CREATE TABLE Orders (
    order_id SMALLINT NOT NULL AUTO_INCREMENT,
    customer_id VARCHAR(50),
    employee_id SMALLINT,
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    ship_via SMALLINT,
    freight FLOAT,
    ship_name VARCHAR(40),
    ship_address VARCHAR(60),
    ship_city VARCHAR(15),
    ship_region VARCHAR(15),
    ship_postal_code VARCHAR(10),
    ship_country VARCHAR(15),
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (ship_via) REFERENCES Shippers(shipper_id)
);

-- 11. Территории
CREATE TABLE Territories (
    territory_id VARCHAR(20) NOT NULL,
    territory_description VARCHAR(500),
    region_id SMALLINT,
    PRIMARY KEY (territory_id),
    FOREIGN KEY (region_id) REFERENCES Region(region_id)
);

-- 12. Таблица связей между сотрудниками и территориями
CREATE TABLE Employee_Territories (
    employee_id SMALLINT,
    territory_id VARCHAR(20),
    PRIMARY KEY (employee_id, territory_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (territory_id) REFERENCES Territories(territory_id)
);

-- 13. Детали заказов
CREATE TABLE Order_Details (
    order_id SMALLINT,
    product_id SMALLINT,
    unit_price FLOAT,
    quantity SMALLINT,
    discount FLOAT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- 14. Штаты США
CREATE TABLE US_States (
    state_id SMALLINT NOT NULL AUTO_INCREMENT,
    state_name VARCHAR(100),
    state_abbr VARCHAR(2),
    state_region VARCHAR(50),
    PRIMARY KEY (state_id)
);



-- Загружаем данные

INSERT INTO Categories VALUES
	(1, 'Beverages', 'Soft drinks, coffees, teas, beers, and ales', '\x'),
	(2, 'Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings', '\x'),
	(3, 'Confections', 'Desserts, candies, and sweet breads', '\x'),
	(4, 'Dairy Products', 'Cheeses', '\x'),
	(5, 'Grains/Cereals', 'Breads, crackers, pasta, and cereal', '\x'),
	(6, 'Meat/Poultry', 'Prepared meats', '\x'),
	(7, 'Produce', 'Dried fruit and bean curd', '\x'),
	(8, 'Seafood', 'Seaweed and fish', '\x');


--
-- Data for Name: customer_demographics; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO Customers VALUES
	('ALFKI', 'Alfreds Futterkiste', 'Maria Anders', 'Sales Representative', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany', '030-0074321', '030-0076545'),
	('ANATR', 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Owner', 'Avda. de la Constitución 2222', 'México D.F.', NULL, '05021', 'Mexico', '(5) 555-4729', '(5) 555-3745'),
	('ANTON', 'Antonio Moreno Taquería', 'Antonio Moreno', 'Owner', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico', '(5) 555-3932', NULL),
	('AROUT', 'Around the Horn', 'Thomas Hardy', 'Sales Representative', '120 Hanover Sq.', 'London', NULL, 'WA1 1DP', 'UK', '(171) 555-7788', '(171) 555-6750'),
	('BERGS', 'Berglunds snabbköp', 'Christina Berglund', 'Order Administrator', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden', '0921-12 34 65', '0921-12 34 67'),
	('BLAUS', 'Blauer See Delikatessen', 'Hanna Moos', 'Sales Representative', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany', '0621-08460', '0621-08924'),
	('BLONP', 'Blondesddsl père et fils', 'Frédérique Citeaux', 'Marketing Manager', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France', '88.60.15.31', '88.60.15.32'),
	('BOLID', 'Bólido Comidas preparadas', 'Martín Sommer', 'Owner', 'C/ Araquil, 67', 'Madrid', NULL, '28023', 'Spain', '(91) 555 22 82', '(91) 555 91 99'),
	('BONAP', 'Bon app''', 'Laurence Lebihan', 'Owner', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France', '91.24.45.40', '91.24.45.41'),
	('BOTTM', 'Bottom-Dollar Markets', 'Elizabeth Lincoln', 'Accounting Manager', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada', '(604) 555-4729', '(604) 555-3745'),
	('BSBEV', 'B''s Beverages', 'Victoria Ashworth', 'Sales Representative', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK', '(171) 555-1212', NULL),
	('CACTU', 'Cactus Comidas para llevar', 'Patricio Simpson', 'Sales Agent', 'Cerrito 333', 'Buenos Aires', NULL, '1010', 'Argentina', '(1) 135-5555', '(1) 135-4892'),
	('CENTC', 'Centro comercial Moctezuma', 'Francisco Chang', 'Marketing Manager', 'Sierras de Granada 9993', 'México D.F.', NULL, '05022', 'Mexico', '(5) 555-3392', '(5) 555-7293'),
	('CHOPS', 'Chop-suey Chinese', 'Yang Wang', 'Owner', 'Hauptstr. 29', 'Bern', NULL, '3012', 'Switzerland', '0452-076545', NULL),
	('COMMI', 'Comércio Mineiro', 'Pedro Afonso', 'Sales Associate', 'Av. dos Lusíadas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil', '(11) 555-7647', NULL),
	('CONSH', 'Consolidated Holdings', 'Elizabeth Brown', 'Sales Representative', 'Berkeley Gardens 12  Brewery', 'London', NULL, 'WX1 6LT', 'UK', '(171) 555-2282', '(171) 555-9199'),
	('DRACD', 'Drachenblut Delikatessen', 'Sven Ottlieb', 'Order Administrator', 'Walserweg 21', 'Aachen', NULL, '52066', 'Germany', '0241-039123', '0241-059428'),
	('DUMON', 'Du monde entier', 'Janine Labrune', 'Owner', '67, rue des Cinquante Otages', 'Nantes', NULL, '44000', 'France', '40.67.88.88', '40.67.89.89'),
	('EASTC', 'Eastern Connection', 'Ann Devon', 'Sales Agent', '35 King George', 'London', NULL, 'WX3 6FW', 'UK', '(171) 555-0297', '(171) 555-3373'),
	('ERNSH', 'Ernst Handel', 'Roland Mendel', 'Sales Manager', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria', '7675-3425', '7675-3426'),
	('FAMIA', 'Familia Arquibaldo', 'Aria Cruz', 'Marketing Assistant', 'Rua Orós, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil', '(11) 555-9857', NULL),
	('FISSA', 'FISSA Fabrica Inter. Salchichas S.A.', 'Diego Roel', 'Accounting Manager', 'C/ Moralzarzal, 86', 'Madrid', NULL, '28034', 'Spain', '(91) 555 94 44', '(91) 555 55 93'),
	('FOLIG', 'Folies gourmandes', 'Martine Rancé', 'Assistant Sales Agent', '184, chaussée de Tournai', 'Lille', NULL, '59000', 'France', '20.16.10.16', '20.16.10.17'),
	('FOLKO', 'Folk och fä HB', 'Maria Larsson', 'Owner', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden', '0695-34 67 21', NULL),
	('FRANK', 'Frankenversand', 'Peter Franken', 'Marketing Manager', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany', '089-0877310', '089-0877451'),
	('FRANR', 'France restauration', 'Carine Schmitt', 'Marketing Manager', '54, rue Royale', 'Nantes', NULL, '44000', 'France', '40.32.21.21', '40.32.21.20'),
	('FRANS', 'Franchi S.p.A.', 'Paolo Accorti', 'Sales Representative', 'Via Monte Bianco 34', 'Torino', NULL, '10100', 'Italy', '011-4988260', '011-4988261'),
	('FURIB', 'Furia Bacalhau e Frutos do Mar', 'Lino Rodriguez', 'Sales Manager', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal', '(1) 354-2534', '(1) 354-2535'),
	('GALED', 'Galería del gastrónomo', 'Eduardo Saavedra', 'Marketing Manager', 'Rambla de Cataluña, 23', 'Barcelona', NULL, '08022', 'Spain', '(93) 203 4560', '(93) 203 4561'),
	('GODOS', 'Godos Cocina Típica', 'José Pedro Freyre', 'Sales Manager', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain', '(95) 555 82 82', NULL),
	('GOURL', 'Gourmet Lanchonetes', 'André Fonseca', 'Sales Associate', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil', '(11) 555-9482', NULL),
	('GREAL', 'Great Lakes Food Market', 'Howard Snyder', 'Marketing Manager', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA', '(503) 555-7555', NULL),
	('GROSR', 'GROSELLA-Restaurante', 'Manuel Pereira', 'Owner', '5ª Ave. Los Palos Grandes', 'Caracas', 'DF', '1081', 'Venezuela', '(2) 283-2951', '(2) 283-3397'),
	('HANAR', 'Hanari Carnes', 'Mario Pontes', 'Accounting Manager', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil', '(21) 555-0091', '(21) 555-8765'),
	('HILAA', 'HILARION-Abastos', 'Carlos Hernández', 'Sales Representative', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela', '(5) 555-1340', '(5) 555-1948'),
	('HUNGC', 'Hungry Coyote Import Store', 'Yoshi Latimer', 'Sales Representative', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA', '(503) 555-6874', '(503) 555-2376'),
	('HUNGO', 'Hungry Owl All-Night Grocers', 'Patricia McKenna', 'Sales Associate', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland', '2967 542', '2967 3333'),
	('ISLAT', 'Island Trading', 'Helen Bennett', 'Marketing Manager', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK', '(198) 555-8888', NULL),
	('KOENE', 'Königlich Essen', 'Philip Cramer', 'Sales Associate', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany', '0555-09876', NULL),
	('LACOR', 'La corne d''abondance', 'Daniel Tonini', 'Sales Representative', '67, avenue de l''Europe', 'Versailles', NULL, '78000', 'France', '30.59.84.10', '30.59.85.11'),
	('LAMAI', 'La maison d''Asie', 'Annette Roulet', 'Sales Manager', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France', '61.77.61.10', '61.77.61.11'),
	('LAUGB', 'Laughing Bacchus Wine Cellars', 'Yoshi Tannamuri', 'Marketing Assistant', '1900 Oak St.', 'Vancouver', 'BC', 'V3F 2K1', 'Canada', '(604) 555-3392', '(604) 555-7293'),
	('LAZYK', 'Lazy K Kountry Store', 'John Steel', 'Marketing Manager', '12 Orchestra Terrace', 'Walla Walla', 'WA', '99362', 'USA', '(509) 555-7969', '(509) 555-6221'),
	('LEHMS', 'Lehmanns Marktstand', 'Renate Messner', 'Sales Representative', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany', '069-0245984', '069-0245874'),
	('LETSS', 'Let''s Stop N Shop', 'Jaime Yorres', 'Owner', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', 'USA', '(415) 555-5938', NULL),
	('LILAS', 'LILA-Supermercado', 'Carlos González', 'Accounting Manager', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela', '(9) 331-6954', '(9) 331-7256'),
	('LINOD', 'LINO-Delicateses', 'Felipe Izquierdo', 'Owner', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela', '(8) 34-56-12', '(8) 34-93-93'),
	('LONEP', 'Lonesome Pine Restaurant', 'Fran Wilson', 'Sales Manager', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA', '(503) 555-9573', '(503) 555-9646'),
	('MAGAA', 'Magazzini Alimentari Riuniti', 'Giovanni Rovelli', 'Marketing Manager', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy', '035-640230', '035-640231'),
	('MAISD', 'Maison Dewey', 'Catherine Dewey', 'Sales Agent', 'Rue Joseph-Bens 532', 'Bruxelles', NULL, 'B-1180', 'Belgium', '(02) 201 24 67', '(02) 201 24 68'),
	('MEREP', 'Mère Paillarde', 'Jean Fresnière', 'Marketing Assistant', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada', '(514) 555-8054', '(514) 555-8055'),
	('MORGK', 'Morgenstern Gesundkost', 'Alexander Feuer', 'Marketing Assistant', 'Heerstr. 22', 'Leipzig', NULL, '04179', 'Germany', '0342-023176', NULL),
	('NORTS', 'North/South', 'Simon Crowther', 'Sales Associate', 'South House 300 Queensbridge', 'London', NULL, 'SW7 1RZ', 'UK', '(171) 555-7733', '(171) 555-2530'),
	('OCEAN', 'Océano Atlántico Ltda.', 'Yvonne Moncada', 'Sales Agent', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', NULL, '1010', 'Argentina', '(1) 135-5333', '(1) 135-5535'),
	('OLDWO', 'Old World Delicatessen', 'Rene Phillips', 'Sales Representative', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA', '(907) 555-7584', '(907) 555-2880'),
	('OTTIK', 'Ottilies Käseladen', 'Henriette Pfalzheim', 'Owner', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany', '0221-0644327', '0221-0765721'),
	('PARIS', 'Paris spécialités', 'Marie Bertrand', 'Owner', '265, boulevard Charonne', 'Paris', NULL, '75012', 'France', '(1) 42.34.22.66', '(1) 42.34.22.77'),
	('PERIC', 'Pericles Comidas clásicas', 'Guillermo Fernández', 'Sales Representative', 'Calle Dr. Jorge Cash 321', 'México D.F.', NULL, '05033', 'Mexico', '(5) 552-3745', '(5) 545-3745'),
	('PICCO', 'Piccolo und mehr', 'Georg Pipps', 'Sales Manager', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria', '6562-9722', '6562-9723'),
	('PRINI', 'Princesa Isabel Vinhos', 'Isabel de Castro', 'Sales Representative', 'Estrada da saúde n. 58', 'Lisboa', NULL, '1756', 'Portugal', '(1) 356-5634', NULL),
	('QUEDE', 'Que Delícia', 'Bernardo Batista', 'Accounting Manager', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil', '(21) 555-4252', '(21) 555-4545'),
	('QUEEN', 'Queen Cozinha', 'Lúcia Carvalho', 'Marketing Assistant', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil', '(11) 555-1189', NULL),
	('QUICK', 'QUICK-Stop', 'Horst Kloss', 'Accounting Manager', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany', '0372-035188', NULL),
	('RANCH', 'Rancho grande', 'Sergio Gutiérrez', 'Sales Representative', 'Av. del Libertador 900', 'Buenos Aires', NULL, '1010', 'Argentina', '(1) 123-5555', '(1) 123-5556'),
	('RATTC', 'Rattlesnake Canyon Grocery', 'Paula Wilson', 'Assistant Sales Representative', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA', '(505) 555-5939', '(505) 555-3620'),
	('REGGC', 'Reggiani Caseifici', 'Maurizio Moroni', 'Sales Associate', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy', '0522-556721', '0522-556722'),
	('RICAR', 'Ricardo Adocicados', 'Janete Limeira', 'Assistant Sales Agent', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil', '(21) 555-3412', NULL),
	('RICSU', 'Richter Supermarkt', 'Michael Holz', 'Sales Manager', 'Grenzacherweg 237', 'Genève', NULL, '1203', 'Switzerland', '0897-034214', NULL),
	('ROMEY', 'Romero y tomillo', 'Alejandra Camino', 'Accounting Manager', 'Gran Vía, 1', 'Madrid', NULL, '28001', 'Spain', '(91) 745 6200', '(91) 745 6210'),
	('SANTG', 'Santé Gourmet', 'Jonas Bergulfsen', 'Owner', 'Erling Skakkes gate 78', 'Stavern', NULL, '4110', 'Norway', '07-98 92 35', '07-98 92 47'),
	('SAVEA', 'Save-a-lot Markets', 'Jose Pavarotti', 'Sales Representative', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA', '(208) 555-8097', NULL),
	('SEVES', 'Seven Seas Imports', 'Hari Kumar', 'Sales Manager', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK', '(171) 555-1717', '(171) 555-5646'),
	('SIMOB', 'Simons bistro', 'Jytte Petersen', 'Owner', 'Vinbæltet 34', 'Kobenhavn', NULL, '1734', 'Denmark', '31 12 34 56', '31 13 35 57'),
	('SPECD', 'Spécialités du monde', 'Dominique Perrier', 'Marketing Manager', '25, rue Lauriston', 'Paris', NULL, '75016', 'France', '(1) 47.55.60.10', '(1) 47.55.60.20'),
	('SPLIR', 'Split Rail Beer & Ale', 'Art Braunschweiger', 'Sales Manager', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA', '(307) 555-4680', '(307) 555-6525'),
	('SUPRD', 'Suprêmes délices', 'Pascale Cartrain', 'Accounting Manager', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium', '(071) 23 67 22 20', '(071) 23 67 22 21'),
	('THEBI', 'The Big Cheese', 'Liz Nixon', 'Marketing Manager', '89 Jefferson Way Suite 2', 'Portland', 'OR', '97201', 'USA', '(503) 555-3612', NULL),
	('THECR', 'The Cracker Box', 'Liu Wong', 'Marketing Assistant', '55 Grizzly Peak Rd.', 'Butte', 'MT', '59801', 'USA', '(406) 555-5834', '(406) 555-8083'),
	('TOMSP', 'Toms Spezialitäten', 'Karin Josephs', 'Marketing Manager', 'Luisenstr. 48', 'Münster', NULL, '44087', 'Germany', '0251-031259', '0251-035695'),
	('TORTU', 'Tortuga Restaurante', 'Miguel Angel Paolino', 'Owner', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico', '(5) 555-2933', NULL),
	('TRADH', 'Tradição Hipermercados', 'Anabela Domingues', 'Sales Representative', 'Av. Inês de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil', '(11) 555-2167', '(11) 555-2168'),
	('TRAIH', 'Trail''s Head Gourmet Provisioners', 'Helvetius Nagy', 'Sales Associate', '722 DaVinci Blvd.', 'Kirkland', 'WA', '98034', 'USA', '(206) 555-8257', '(206) 555-2174'),
	('VAFFE', 'Vaffeljernet', 'Palle Ibsen', 'Sales Manager', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark', '86 21 32 43', '86 22 33 44'),
	('VICTE', 'Victuailles en stock', 'Mary Saveley', 'Sales Agent', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France', '78.32.54.86', '78.32.54.87'),
	('VINET', 'Vins et alcools Chevalier', 'Paul Henriot', 'Accounting Manager', '59 rue de l''Abbaye', 'Reims', NULL, '51100', 'France', '26.47.15.10', '26.47.15.11'),
	('WANDK', 'Die Wandernde Kuh', 'Rita Müller', 'Sales Representative', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany', '0711-020361', '0711-035428'),
	('WARTH', 'Wartian Herkku', 'Pirkko Koskitalo', 'Accounting Manager', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland', '981-443655', '981-443655'),
	('WELLI', 'Wellington Importadora', 'Paula Parente', 'Sales Manager', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil', '(14) 555-8122', NULL),
	('WHITC', 'White Clover Markets', 'Karl Jablonski', 'Owner', '305 - 14th Ave. S. Suite 3B', 'Seattle', 'WA', '98128', 'USA', '(206) 555-4112', '(206) 555-4115'),
	('WILMK', 'Wilman Kala', 'Matti Karttunen', 'Owner/Marketing Assistant', 'Keskuskatu 45', 'Helsinki', NULL, '21240', 'Finland', '90-224 8858', '90-224 8858'),
	('WOLZA', 'Wolski  Zajazd', 'Zbyszek Piestrzeniewicz', 'Owner', 'ul. Filtrowa 68', 'Warszawa', NULL, '01-012', 'Poland', '(26) 642-7012', '(26) 642-7012');


--
-- Data for Name: customer_customer_demo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO Employees VALUES
	(2, 'Fuller', 'Andrew', 'Vice President, Sales', 'Dr.', '1952-02-19', '1992-08-14', '908 W. Capital Way', 'Tacoma', 'WA', '98401', 'USA', '(206) 555-9482', '3457', '\x', 'Andrew received his BTS commercial in 1974 and a Ph.D. in international marketing from the University of Dallas in 1981.  He is fluent in French and Italian and reads German.  He joined the company as a sales representative, was promoted to sales manager in January 1992 and to vice president of sales in March 1993.  Andrew is a member of the Sales Management Roundtable, the Seattle Chamber of Commerce, and the Pacific Rim Importers Association.', NULL, 'http://accweb/emmployees/fuller.bmp'),
	(3, 'Leverling', 'Janet', 'Sales Representative', 'Ms.', '1963-08-30', '1992-04-01', '722 Moss Bay Blvd.', 'Kirkland', 'WA', '98033', 'USA', '(206) 555-3412', '3355', '\x', 'Janet has a BS degree in chemistry from Boston College (1984).  She has also completed a certificate program in food retailing management.  Janet was hired as a sales associate in 1991 and promoted to sales representative in February 1992.', 2, 'http://accweb/emmployees/leverling.bmp'),
	(4, 'Peacock', 'Margaret', 'Sales Representative', 'Mrs.', '1937-09-19', '1993-05-03', '4110 Old Redmond Rd.', 'Redmond', 'WA', '98052', 'USA', '(206) 555-8122', '5176', '\x', 'Margaret holds a BA in English literature from Concordia College (1958) and an MA from the American Institute of Culinary Arts (1966).  She was assigned to the London office temporarily from July through November 1992.', 2, 'http://accweb/emmployees/peacock.bmp'),
	(5, 'Buchanan', 'Steven', 'Sales Manager', 'Mr.', '1955-03-04', '1993-10-17', '14 Garrett Hill', 'London', NULL, 'SW1 8JR', 'UK', '(71) 555-4848', '3453', '\x', 'Steven Buchanan graduated from St. Andrews University, Scotland, with a BSC degree in 1976.  Upon joining the company as a sales representative in 1992, he spent 6 months in an orientation program at the Seattle office and then returned to his permanent post in London.  He was promoted to sales manager in March 1993.  Mr. Buchanan has completed the courses Successful Telemarketing and International Sales Management.  He is fluent in French.', 2, 'http://accweb/emmployees/buchanan.bmp'),
	(6, 'Suyama', 'Michael', 'Sales Representative', 'Mr.', '1963-07-02', '1993-10-17', 'Coventry House\nMiner Rd.', 'London', NULL, 'EC2 7JR', 'UK', '(71) 555-7773', '428', '\x', 'Michael is a graduate of Sussex University (MA, economics, 1983) and the University of California at Los Angeles (MBA, marketing, 1986).  He has also taken the courses Multi-Cultural Selling and Time Management for the Sales Professional.  He is fluent in Japanese and can read and write French, Portuguese, and Spanish.', 5, 'http://accweb/emmployees/davolio.bmp'),
	(7, 'King', 'Robert', 'Sales Representative', 'Mr.', '1960-05-29', '1994-01-02', 'Edgeham Hollow\nWinchester Way', 'London', NULL, 'RG1 9SP', 'UK', '(71) 555-5598', '465', '\x', 'Robert King served in the Peace Corps and traveled extensively before completing his degree in English at the University of Michigan in 1992, the year he joined the company.  After completing a course entitled Selling in Europe, he was transferred to the London office in March 1993.', 5, 'http://accweb/emmployees/davolio.bmp'),
	(8, 'Callahan', 'Laura', 'Inside Sales Coordinator', 'Ms.', '1958-01-09', '1994-03-05', '4726 - 11th Ave. N.E.', 'Seattle', 'WA', '98105', 'USA', '(206) 555-1189', '2344', '\x', 'Laura received a BA in psychology from the University of Washington.  She has also completed a course in business French.  She reads and writes French.', 2, 'http://accweb/emmployees/davolio.bmp'),
	(9, 'Dodsworth', 'Anne', 'Sales Representative', 'Ms.', '1966-01-27', '1994-11-15', '7 Houndstooth Rd.', 'London', NULL, 'WG2 7LT', 'UK', '(71) 555-4444', '452', '\x', 'Anne has a BA degree in English from St. Lawrence College.  She is fluent in French and German.', 5, 'http://accweb/emmployees/davolio.bmp'),
	(1, 'Davolio', 'Nancy', 'Sales Representative', 'Ms.', '1948-12-08', '1992-05-01', '507 - 20th Ave. E.\nApt. 2A', 'Seattle', 'WA', '98122', 'USA', '(206) 555-9857', '5467', '\x', 'Education includes a BA in psychology from Colorado State University in 1970.  She also completed The Art of the Cold Call.  Nancy is a member of Toastmasters International.', 2, 'http://accweb/emmployees/davolio.bmp');


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO Region VALUES
	(1, 'Eastern'),
	(2, 'Western'),
	(3, 'Northern'),
	(4, 'Southern');


--
-- Data for Name: territories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO Territories VALUES
	('01581', 'Westboro', 1),
	('01730', 'Bedford', 1),
	('01833', 'Georgetow', 1),
	('02116', 'Boston', 1),
	('02139', 'Cambridge', 1),
	('02184', 'Braintree', 1),
	('02903', 'Providence', 1),
	('03049', 'Hollis', 3),
	('03801', 'Portsmouth', 3),
	('06897', 'Wilton', 1),
	('07960', 'Morristown', 1),
	('08837', 'Edison', 1),
	('10019', 'New York', 1),
	('10038', 'New York', 1),
	('11747', 'Mellvile', 1),
	('14450', 'Fairport', 1),
	('19428', 'Philadelphia', 3),
	('19713', 'Neward', 1),
	('20852', 'Rockville', 1),
	('27403', 'Greensboro', 1),
	('27511', 'Cary', 1),
	('29202', 'Columbia', 4),
	('30346', 'Atlanta', 4),
	('31406', 'Savannah', 4),
	('32859', 'Orlando', 4),
	('33607', 'Tampa', 4),
	('40222', 'Louisville', 1),
	('44122', 'Beachwood', 3),
	('45839', 'Findlay', 3),
	('48075', 'Southfield', 3),
	('48084', 'Troy', 3),
	('48304', 'Bloomfield Hills', 3),
	('53404', 'Racine', 3),
	('55113', 'Roseville', 3),
	('55439', 'Minneapolis', 3),
	('60179', 'Hoffman Estates', 2),
	('60601', 'Chicago', 2),
	('72716', 'Bentonville', 4),
	('75234', 'Dallas', 4),
	('78759', 'Austin', 4),
	('80202', 'Denver', 2),
	('80909', 'Colorado Springs', 2),
	('85014', 'Phoenix', 2),
	('85251', 'Scottsdale', 2),
	('90405', 'Santa Monica', 2),
	('94025', 'Menlo Park', 2),
	('94105', 'San Francisco', 2),
	('95008', 'Campbell', 2),
	('95054', 'Santa Clara', 2),
	('95060', 'Santa Cruz', 2),
	('98004', 'Bellevue', 2),
	('98052', 'Redmond', 2),
	('98104', 'Seattle', 2);


--
-- Data for Name: employee_territories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO Employee_Territories VALUES
	(1, '06897'),
	(1, '19713'),
	(2, '01581'),
	(2, '01730'),
	(2, '01833'),
	(2, '02116'),
	(2, '02139'),
	(2, '02184'),
	(2, '40222'),
	(3, '30346'),
	(3, '31406'),
	(3, '32859'),
	(3, '33607'),
	(4, '20852'),
	(4, '27403'),
	(4, '27511'),
	(5, '02903'),
	(5, '07960'),
	(5, '08837'),
	(5, '10019'),
	(5, '10038'),
	(5, '11747'),
	(5, '14450'),
	(6, '85014'),
	(6, '85251'),
	(6, '98004'),
	(6, '98052'),
	(6, '98104'),
	(7, '60179'),
	(7, '60601'),
	(7, '80202'),
	(7, '80909'),
	(7, '90405'),
	(7, '94025'),
	(7, '94105'),
	(7, '95008'),
	(7, '95054'),
	(7, '95060'),
	(8, '19428'),
	(8, '44122'),
	(8, '45839'),
	(8, '53404'),
	(9, '03049'),
	(9, '03801'),
	(9, '48075'),
	(9, '48084'),
	(9, '48304'),
	(9, '55113'),
	(9, '55439');


--
-- Data for Name: shippers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO Shippers VALUES
	(1, 'Speedy Express', '(503) 555-9831'),
	(2, 'United Package', '(503) 555-3199'),
	(3, 'Federal Shipping', '(503) 555-9931'),
	(4, 'Alliance Shippers', '1-800-222-0451'),
	(5, 'UPS', '1-800-782-7892'),
	(6, 'DHL', '1-800-225-5345');


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO Orders VALUES
	(10248, 'VINET', 5, '1996-07-04', '1996-08-01', '1996-07-16', 3, 32.38, 'Vins et alcools Chevalier', '59 rue de l''Abbaye', 'Reims', NULL, '51100', 'France'),
	(10249, 'TOMSP', 6, '1996-07-05', '1996-08-16', '1996-07-10', 1, 11.61, 'Toms Spezialitäten', 'Luisenstr. 48', 'Münster', NULL, '44087', 'Germany'),
	(10250, 'HANAR', 4, '1996-07-08', '1996-08-05', '1996-07-12', 2, 65.83, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
	(10251, 'VICTE', 3, '1996-07-08', '1996-08-05', '1996-07-15', 1, 41.34, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France'),
	(10252, 'SUPRD', 4, '1996-07-09', '1996-08-06', '1996-07-11', 2, 51.3, 'Suprêmes délices', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium'),
	(10253, 'HANAR', 3, '1996-07-10', '1996-07-24', '1996-07-16', 2, 58.17, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
	(10254, 'CHOPS', 5, '1996-07-11', '1996-08-08', '1996-07-23', 2, 22.98, 'Chop-suey Chinese', 'Hauptstr. 31', 'Bern', NULL, '3012', 'Switzerland'),
	(10255, 'RICSU', 9, '1996-07-12', '1996-08-09', '1996-07-15', 3, 148.33, 'Richter Supermarkt', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland'),
	(10256, 'WELLI', 3, '1996-07-15', '1996-08-12', '1996-07-17', 2, 13.97, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
	(10257, 'HILAA', 4, '1996-07-16', '1996-08-13', '1996-07-22', 3, 81.91, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10258, 'ERNSH', 1, '1996-07-17', '1996-08-14', '1996-07-23', 1, 140.51, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10259, 'CENTC', 4, '1996-07-18', '1996-08-15', '1996-07-25', 3, 3.25, 'Centro comercial Moctezuma', 'Sierras de Granada 9993', 'México D.F.', NULL, '05022', 'Mexico'),
	(10260, 'OTTIK', 4, '1996-07-19', '1996-08-16', '1996-07-29', 1, 55.09, 'Ottilies Käseladen', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany'),
	(10261, 'QUEDE', 4, '1996-07-19', '1996-08-16', '1996-07-30', 2, 3.05, 'Que Delícia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
	(10262, 'RATTC', 8, '1996-07-22', '1996-08-19', '1996-07-25', 3, 48.29, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(10263, 'ERNSH', 9, '1996-07-23', '1996-08-20', '1996-07-31', 3, 146.06, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10264, 'FOLKO', 6, '1996-07-24', '1996-08-21', '1996-08-23', 3, 3.67, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10265, 'BLONP', 2, '1996-07-25', '1996-08-22', '1996-08-12', 1, 55.28, 'Blondel père et fils', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France'),
	(10266, 'WARTH', 3, '1996-07-26', '1996-09-06', '1996-07-31', 3, 25.73, 'Wartian Herkku', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland'),
	(10267, 'FRANK', 4, '1996-07-29', '1996-08-26', '1996-08-06', 1, 208.58, 'Frankenversand', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany'),
	(10268, 'GROSR', 8, '1996-07-30', '1996-08-27', '1996-08-02', 3, 66.29, 'GROSELLA-Restaurante', '5ª Ave. Los Palos Grandes', 'Caracas', 'DF', '1081', 'Venezuela'),
	(10269, 'WHITC', 5, '1996-07-31', '1996-08-14', '1996-08-09', 1, 4.56, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
	(10270, 'WARTH', 1, '1996-08-01', '1996-08-29', '1996-08-02', 1, 136.54, 'Wartian Herkku', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland'),
	(10271, 'SPLIR', 6, '1996-08-01', '1996-08-29', '1996-08-30', 2, 4.54, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
	(10272, 'RATTC', 6, '1996-08-02', '1996-08-30', '1996-08-06', 2, 98.03, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(10273, 'QUICK', 3, '1996-08-05', '1996-09-02', '1996-08-12', 3, 76.07, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10274, 'VINET', 6, '1996-08-06', '1996-09-03', '1996-08-16', 1, 6.01, 'Vins et alcools Chevalier', '59 rue de l''Abbaye', 'Reims', NULL, '51100', 'France'),
	(10275, 'MAGAA', 1, '1996-08-07', '1996-09-04', '1996-08-09', 1, 26.93, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy'),
	(10276, 'TORTU', 8, '1996-08-08', '1996-08-22', '1996-08-14', 3, 13.84, 'Tortuga Restaurante', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico'),
	(10277, 'MORGK', 2, '1996-08-09', '1996-09-06', '1996-08-13', 3, 125.77, 'Morgenstern Gesundkost', 'Heerstr. 22', 'Leipzig', NULL, '04179', 'Germany'),
	(10278, 'BERGS', 8, '1996-08-12', '1996-09-09', '1996-08-16', 2, 92.69, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10279, 'LEHMS', 8, '1996-08-13', '1996-09-10', '1996-08-16', 2, 25.83, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany'),
	(10280, 'BERGS', 2, '1996-08-14', '1996-09-11', '1996-09-12', 1, 8.98, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10281, 'ROMEY', 4, '1996-08-14', '1996-08-28', '1996-08-21', 1, 2.94, 'Romero y tomillo', 'Gran Vía, 1', 'Madrid', NULL, '28001', 'Spain'),
	(10282, 'ROMEY', 4, '1996-08-15', '1996-09-12', '1996-08-21', 1, 12.69, 'Romero y tomillo', 'Gran Vía, 1', 'Madrid', NULL, '28001', 'Spain'),
	(10283, 'LILAS', 3, '1996-08-16', '1996-09-13', '1996-08-23', 3, 84.81, 'LILA-Supermercado', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
	(10284, 'LEHMS', 4, '1996-08-19', '1996-09-16', '1996-08-27', 1, 76.56, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany'),
	(10285, 'QUICK', 1, '1996-08-20', '1996-09-17', '1996-08-26', 2, 76.83, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10286, 'QUICK', 8, '1996-08-21', '1996-09-18', '1996-08-30', 3, 229.24, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10287, 'RICAR', 8, '1996-08-22', '1996-09-19', '1996-08-28', 3, 12.76, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
	(10288, 'REGGC', 4, '1996-08-23', '1996-09-20', '1996-09-03', 1, 7.45, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy'),
	(10289, 'BSBEV', 7, '1996-08-26', '1996-09-23', '1996-08-28', 3, 22.77, 'B''s Beverages', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK'),
	(10290, 'COMMI', 8, '1996-08-27', '1996-09-24', '1996-09-03', 1, 79.7, 'Comércio Mineiro', 'Av. dos Lusíadas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil'),
	(10291, 'QUEDE', 6, '1996-08-27', '1996-09-24', '1996-09-04', 2, 6.4, 'Que Delícia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
	(10292, 'TRADH', 1, '1996-08-28', '1996-09-25', '1996-09-02', 2, 1.35, 'Tradiçao Hipermercados', 'Av. Inês de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil'),
	(10293, 'TORTU', 1, '1996-08-29', '1996-09-26', '1996-09-11', 3, 21.18, 'Tortuga Restaurante', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico'),
	(10294, 'RATTC', 4, '1996-08-30', '1996-09-27', '1996-09-05', 2, 147.26, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(10295, 'VINET', 2, '1996-09-02', '1996-09-30', '1996-09-10', 2, 1.15, 'Vins et alcools Chevalier', '59 rue de l''Abbaye', 'Reims', NULL, '51100', 'France'),
	(10296, 'LILAS', 6, '1996-09-03', '1996-10-01', '1996-09-11', 1, 0.12, 'LILA-Supermercado', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
	(10297, 'BLONP', 5, '1996-09-04', '1996-10-16', '1996-09-10', 2, 5.74, 'Blondel père et fils', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France'),
	(10298, 'HUNGO', 6, '1996-09-05', '1996-10-03', '1996-09-11', 2, 168.22, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10299, 'RICAR', 4, '1996-09-06', '1996-10-04', '1996-09-13', 2, 29.76, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
	(10300, 'MAGAA', 2, '1996-09-09', '1996-10-07', '1996-09-18', 2, 17.68, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy'),
	(10301, 'WANDK', 8, '1996-09-09', '1996-10-07', '1996-09-17', 2, 45.08, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany'),
	(10302, 'SUPRD', 4, '1996-09-10', '1996-10-08', '1996-10-09', 2, 6.27, 'Suprêmes délices', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium'),
	(10303, 'GODOS', 7, '1996-09-11', '1996-10-09', '1996-09-18', 2, 107.83, 'Godos Cocina Típica', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain'),
	(10304, 'TORTU', 1, '1996-09-12', '1996-10-10', '1996-09-17', 2, 63.79, 'Tortuga Restaurante', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico'),
	(10305, 'OLDWO', 8, '1996-09-13', '1996-10-11', '1996-10-09', 3, 257.62, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
	(10306, 'ROMEY', 1, '1996-09-16', '1996-10-14', '1996-09-23', 3, 7.56, 'Romero y tomillo', 'Gran Vía, 1', 'Madrid', NULL, '28001', 'Spain'),
	(10307, 'LONEP', 2, '1996-09-17', '1996-10-15', '1996-09-25', 2, 0.56, 'Lonesome Pine Restaurant', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA'),
	(10308, 'ANATR', 7, '1996-09-18', '1996-10-16', '1996-09-24', 3, 1.61, 'Ana Trujillo Emparedados y helados', 'Avda. de la Constitución 2222', 'México D.F.', NULL, '05021', 'Mexico'),
	(10309, 'HUNGO', 3, '1996-09-19', '1996-10-17', '1996-10-23', 1, 47.3, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10310, 'THEBI', 8, '1996-09-20', '1996-10-18', '1996-09-27', 2, 17.52, 'The Big Cheese', '89 Jefferson Way Suite 2', 'Portland', 'OR', '97201', 'USA'),
	(10311, 'DUMON', 1, '1996-09-20', '1996-10-04', '1996-09-26', 3, 24.69, 'Du monde entier', '67, rue des Cinquante Otages', 'Nantes', NULL, '44000', 'France'),
	(10312, 'WANDK', 2, '1996-09-23', '1996-10-21', '1996-10-03', 2, 40.26, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany'),
	(10313, 'QUICK', 2, '1996-09-24', '1996-10-22', '1996-10-04', 2, 1.96, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10314, 'RATTC', 1, '1996-09-25', '1996-10-23', '1996-10-04', 2, 74.16, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(10315, 'ISLAT', 4, '1996-09-26', '1996-10-24', '1996-10-03', 2, 41.76, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
	(10316, 'RATTC', 1, '1996-09-27', '1996-10-25', '1996-10-08', 3, 150.15, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(10317, 'LONEP', 6, '1996-09-30', '1996-10-28', '1996-10-10', 1, 12.69, 'Lonesome Pine Restaurant', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA'),
	(10318, 'ISLAT', 8, '1996-10-01', '1996-10-29', '1996-10-04', 2, 4.73, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
	(10319, 'TORTU', 7, '1996-10-02', '1996-10-30', '1996-10-11', 3, 64.5, 'Tortuga Restaurante', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico'),
	(10320, 'WARTH', 5, '1996-10-03', '1996-10-17', '1996-10-18', 3, 34.57, 'Wartian Herkku', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland'),
	(10321, 'ISLAT', 3, '1996-10-03', '1996-10-31', '1996-10-11', 2, 3.43, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
	(10322, 'PERIC', 7, '1996-10-04', '1996-11-01', '1996-10-23', 3, 0.4, 'Pericles Comidas clásicas', 'Calle Dr. Jorge Cash 321', 'México D.F.', NULL, '05033', 'Mexico'),
	(10323, 'KOENE', 4, '1996-10-07', '1996-11-04', '1996-10-14', 1, 4.88, 'Königlich Essen', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany'),
	(10324, 'SAVEA', 9, '1996-10-08', '1996-11-05', '1996-10-10', 1, 214.27, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10325, 'KOENE', 1, '1996-10-09', '1996-10-23', '1996-10-14', 3, 64.86, 'Königlich Essen', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany'),
	(10326, 'BOLID', 4, '1996-10-10', '1996-11-07', '1996-10-14', 2, 77.92, 'Bólido Comidas preparadas', 'C/ Araquil, 67', 'Madrid', NULL, '28023', 'Spain'),
	(10327, 'FOLKO', 2, '1996-10-11', '1996-11-08', '1996-10-14', 1, 63.36, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10328, 'FURIB', 4, '1996-10-14', '1996-11-11', '1996-10-17', 3, 87.03, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal'),
	(10329, 'SPLIR', 4, '1996-10-15', '1996-11-26', '1996-10-23', 2, 191.67, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
	(10330, 'LILAS', 3, '1996-10-16', '1996-11-13', '1996-10-28', 1, 12.75, 'LILA-Supermercado', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
	(10331, 'BONAP', 9, '1996-10-16', '1996-11-27', '1996-10-21', 1, 10.19, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(10332, 'MEREP', 3, '1996-10-17', '1996-11-28', '1996-10-21', 2, 52.84, 'Mère Paillarde', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada'),
	(10333, 'WARTH', 5, '1996-10-18', '1996-11-15', '1996-10-25', 3, 0.59, 'Wartian Herkku', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland'),
	(10334, 'VICTE', 8, '1996-10-21', '1996-11-18', '1996-10-28', 2, 8.56, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France'),
	(10335, 'HUNGO', 7, '1996-10-22', '1996-11-19', '1996-10-24', 2, 42.11, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10336, 'PRINI', 7, '1996-10-23', '1996-11-20', '1996-10-25', 2, 15.51, 'Princesa Isabel Vinhos', 'Estrada da saúde n. 58', 'Lisboa', NULL, '1756', 'Portugal'),
	(10337, 'FRANK', 4, '1996-10-24', '1996-11-21', '1996-10-29', 3, 108.26, 'Frankenversand', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany'),
	(10338, 'OLDWO', 4, '1996-10-25', '1996-11-22', '1996-10-29', 3, 84.21, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
	(10339, 'MEREP', 2, '1996-10-28', '1996-11-25', '1996-11-04', 2, 15.66, 'Mère Paillarde', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada'),
	(10340, 'BONAP', 1, '1996-10-29', '1996-11-26', '1996-11-08', 3, 166.31, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(10341, 'SIMOB', 7, '1996-10-29', '1996-11-26', '1996-11-05', 3, 26.78, 'Simons bistro', 'Vinbæltet 34', 'Kobenhavn', NULL, '1734', 'Denmark'),
	(10342, 'FRANK', 4, '1996-10-30', '1996-11-13', '1996-11-04', 2, 54.83, 'Frankenversand', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany'),
	(10343, 'LEHMS', 4, '1996-10-31', '1996-11-28', '1996-11-06', 1, 110.37, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany'),
	(10344, 'WHITC', 4, '1996-11-01', '1996-11-29', '1996-11-05', 2, 23.29, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
	(10345, 'QUICK', 2, '1996-11-04', '1996-12-02', '1996-11-11', 2, 249.06, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10346, 'RATTC', 3, '1996-11-05', '1996-12-17', '1996-11-08', 3, 142.08, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(10347, 'FAMIA', 4, '1996-11-06', '1996-12-04', '1996-11-08', 3, 3.1, 'Familia Arquibaldo', 'Rua Orós, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil'),
	(10348, 'WANDK', 4, '1996-11-07', '1996-12-05', '1996-11-15', 2, 0.78, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany'),
	(10349, 'SPLIR', 7, '1996-11-08', '1996-12-06', '1996-11-15', 1, 8.63, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
	(10350, 'LAMAI', 6, '1996-11-11', '1996-12-09', '1996-12-03', 2, 64.19, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France'),
	(10351, 'ERNSH', 1, '1996-11-11', '1996-12-09', '1996-11-20', 1, 162.33, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10352, 'FURIB', 3, '1996-11-12', '1996-11-26', '1996-11-18', 3, 1.3, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal'),
	(10353, 'PICCO', 7, '1996-11-13', '1996-12-11', '1996-11-25', 3, 360.63, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria'),
	(10354, 'PERIC', 8, '1996-11-14', '1996-12-12', '1996-11-20', 3, 53.8, 'Pericles Comidas clásicas', 'Calle Dr. Jorge Cash 321', 'México D.F.', NULL, '05033', 'Mexico'),
	(10355, 'AROUT', 6, '1996-11-15', '1996-12-13', '1996-11-20', 1, 41.95, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
	(10356, 'WANDK', 6, '1996-11-18', '1996-12-16', '1996-11-27', 2, 36.71, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany'),
	(10357, 'LILAS', 1, '1996-11-19', '1996-12-17', '1996-12-02', 3, 34.88, 'LILA-Supermercado', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
	(10358, 'LAMAI', 5, '1996-11-20', '1996-12-18', '1996-11-27', 1, 19.64, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France'),
	(10359, 'SEVES', 5, '1996-11-21', '1996-12-19', '1996-11-26', 3, 288.43, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK'),
	(10360, 'BLONP', 4, '1996-11-22', '1996-12-20', '1996-12-02', 3, 131.7, 'Blondel père et fils', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France'),
	(10361, 'QUICK', 1, '1996-11-22', '1996-12-20', '1996-12-03', 2, 183.17, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10362, 'BONAP', 3, '1996-11-25', '1996-12-23', '1996-11-28', 1, 96.04, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(10363, 'DRACD', 4, '1996-11-26', '1996-12-24', '1996-12-04', 3, 30.54, 'Drachenblut Delikatessen', 'Walserweg 21', 'Aachen', NULL, '52066', 'Germany'),
	(10364, 'EASTC', 1, '1996-11-26', '1997-01-07', '1996-12-04', 1, 71.97, 'Eastern Connection', '35 King George', 'London', NULL, 'WX3 6FW', 'UK'),
	(10365, 'ANTON', 3, '1996-11-27', '1996-12-25', '1996-12-02', 2, 22, 'Antonio Moreno Taquería', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico'),
	(10366, 'GALED', 8, '1996-11-28', '1997-01-09', '1996-12-30', 2, 10.14, 'Galería del gastronómo', 'Rambla de Cataluña, 23', 'Barcelona', NULL, '8022', 'Spain'),
	(10367, 'VAFFE', 7, '1996-11-28', '1996-12-26', '1996-12-02', 3, 13.55, 'Vaffeljernet', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark'),
	(10368, 'ERNSH', 2, '1996-11-29', '1996-12-27', '1996-12-02', 2, 101.95, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10369, 'SPLIR', 8, '1996-12-02', '1996-12-30', '1996-12-09', 2, 195.68, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
	(10370, 'CHOPS', 6, '1996-12-03', '1996-12-31', '1996-12-27', 2, 1.17, 'Chop-suey Chinese', 'Hauptstr. 31', 'Bern', NULL, '3012', 'Switzerland'),
	(10371, 'LAMAI', 1, '1996-12-03', '1996-12-31', '1996-12-24', 1, 0.45, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France'),
	(10372, 'QUEEN', 5, '1996-12-04', '1997-01-01', '1996-12-09', 2, 890.78, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
	(10373, 'HUNGO', 4, '1996-12-05', '1997-01-02', '1996-12-11', 3, 124.12, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10374, 'WOLZA', 1, '1996-12-05', '1997-01-02', '1996-12-09', 3, 3.94, 'Wolski Zajazd', 'ul. Filtrowa 68', 'Warszawa', NULL, '01-012', 'Poland'),
	(10375, 'HUNGC', 3, '1996-12-06', '1997-01-03', '1996-12-09', 2, 20.12, 'Hungry Coyote Import Store', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA'),
	(10376, 'MEREP', 1, '1996-12-09', '1997-01-06', '1996-12-13', 2, 20.39, 'Mère Paillarde', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada'),
	(10377, 'SEVES', 1, '1996-12-09', '1997-01-06', '1996-12-13', 3, 22.21, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK'),
	(10378, 'FOLKO', 5, '1996-12-10', '1997-01-07', '1996-12-19', 3, 5.44, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10379, 'QUEDE', 2, '1996-12-11', '1997-01-08', '1996-12-13', 1, 45.03, 'Que Delícia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
	(10380, 'HUNGO', 8, '1996-12-12', '1997-01-09', '1997-01-16', 3, 35.03, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10381, 'LILAS', 3, '1996-12-12', '1997-01-09', '1996-12-13', 3, 7.99, 'LILA-Supermercado', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
	(10382, 'ERNSH', 4, '1996-12-13', '1997-01-10', '1996-12-16', 1, 94.77, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10383, 'AROUT', 8, '1996-12-16', '1997-01-13', '1996-12-18', 3, 34.24, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
	(10384, 'BERGS', 3, '1996-12-16', '1997-01-13', '1996-12-20', 3, 168.64, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10385, 'SPLIR', 1, '1996-12-17', '1997-01-14', '1996-12-23', 2, 30.96, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
	(10386, 'FAMIA', 9, '1996-12-18', '1997-01-01', '1996-12-25', 3, 13.99, 'Familia Arquibaldo', 'Rua Orós, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil'),
	(10387, 'SANTG', 1, '1996-12-18', '1997-01-15', '1996-12-20', 2, 93.63, 'Santé Gourmet', 'Erling Skakkes gate 78', 'Stavern', NULL, '4110', 'Norway'),
	(10388, 'SEVES', 2, '1996-12-19', '1997-01-16', '1996-12-20', 1, 34.86, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK'),
	(10389, 'BOTTM', 4, '1996-12-20', '1997-01-17', '1996-12-24', 2, 47.42, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
	(10390, 'ERNSH', 6, '1996-12-23', '1997-01-20', '1996-12-26', 1, 126.38, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10391, 'DRACD', 3, '1996-12-23', '1997-01-20', '1996-12-31', 3, 5.45, 'Drachenblut Delikatessen', 'Walserweg 21', 'Aachen', NULL, '52066', 'Germany'),
	(10392, 'PICCO', 2, '1996-12-24', '1997-01-21', '1997-01-01', 3, 122.46, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria'),
	(10393, 'SAVEA', 1, '1996-12-25', '1997-01-22', '1997-01-03', 3, 126.56, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10394, 'HUNGC', 1, '1996-12-25', '1997-01-22', '1997-01-03', 3, 30.34, 'Hungry Coyote Import Store', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA'),
	(10395, 'HILAA', 6, '1996-12-26', '1997-01-23', '1997-01-03', 1, 184.41, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10396, 'FRANK', 1, '1996-12-27', '1997-01-10', '1997-01-06', 3, 135.35, 'Frankenversand', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany'),
	(10397, 'PRINI', 5, '1996-12-27', '1997-01-24', '1997-01-02', 1, 60.26, 'Princesa Isabel Vinhos', 'Estrada da saúde n. 58', 'Lisboa', NULL, '1756', 'Portugal'),
	(10398, 'SAVEA', 2, '1996-12-30', '1997-01-27', '1997-01-09', 3, 89.16, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10399, 'VAFFE', 8, '1996-12-31', '1997-01-14', '1997-01-08', 3, 27.36, 'Vaffeljernet', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark'),
	(10400, 'EASTC', 1, '1997-01-01', '1997-01-29', '1997-01-16', 3, 83.93, 'Eastern Connection', '35 King George', 'London', NULL, 'WX3 6FW', 'UK'),
	(10401, 'RATTC', 1, '1997-01-01', '1997-01-29', '1997-01-10', 1, 12.51, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(10402, 'ERNSH', 8, '1997-01-02', '1997-02-13', '1997-01-10', 2, 67.88, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10403, 'ERNSH', 4, '1997-01-03', '1997-01-31', '1997-01-09', 3, 73.79, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10404, 'MAGAA', 2, '1997-01-03', '1997-01-31', '1997-01-08', 1, 155.97, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy'),
	(10405, 'LINOD', 1, '1997-01-06', '1997-02-03', '1997-01-22', 1, 34.82, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
	(10406, 'QUEEN', 7, '1997-01-07', '1997-02-18', '1997-01-13', 1, 108.04, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
	(10407, 'OTTIK', 2, '1997-01-07', '1997-02-04', '1997-01-30', 2, 91.48, 'Ottilies Käseladen', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany'),
	(10408, 'FOLIG', 8, '1997-01-08', '1997-02-05', '1997-01-14', 1, 11.26, 'Folies gourmandes', '184, chaussée de Tournai', 'Lille', NULL, '59000', 'France'),
	(10409, 'OCEAN', 3, '1997-01-09', '1997-02-06', '1997-01-14', 1, 29.83, 'Océano Atlántico Ltda.', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', NULL, '1010', 'Argentina'),
	(10410, 'BOTTM', 3, '1997-01-10', '1997-02-07', '1997-01-15', 3, 2.4, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
	(10411, 'BOTTM', 9, '1997-01-10', '1997-02-07', '1997-01-21', 3, 23.65, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
	(10412, 'WARTH', 8, '1997-01-13', '1997-02-10', '1997-01-15', 2, 3.77, 'Wartian Herkku', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland'),
	(10413, 'LAMAI', 3, '1997-01-14', '1997-02-11', '1997-01-16', 2, 95.66, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France'),
	(10414, 'FAMIA', 2, '1997-01-14', '1997-02-11', '1997-01-17', 3, 21.48, 'Familia Arquibaldo', 'Rua Orós, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil'),
	(10415, 'HUNGC', 3, '1997-01-15', '1997-02-12', '1997-01-24', 1, 0.2, 'Hungry Coyote Import Store', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA'),
	(10416, 'WARTH', 8, '1997-01-16', '1997-02-13', '1997-01-27', 3, 22.72, 'Wartian Herkku', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland'),
	(10417, 'SIMOB', 4, '1997-01-16', '1997-02-13', '1997-01-28', 3, 70.29, 'Simons bistro', 'Vinbæltet 34', 'Kobenhavn', NULL, '1734', 'Denmark'),
	(10418, 'QUICK', 4, '1997-01-17', '1997-02-14', '1997-01-24', 1, 17.55, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10419, 'RICSU', 4, '1997-01-20', '1997-02-17', '1997-01-30', 2, 137.35, 'Richter Supermarkt', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland'),
	(10420, 'WELLI', 3, '1997-01-21', '1997-02-18', '1997-01-27', 1, 44.12, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
	(10421, 'QUEDE', 8, '1997-01-21', '1997-03-04', '1997-01-27', 1, 99.23, 'Que Delícia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
	(10422, 'FRANS', 2, '1997-01-22', '1997-02-19', '1997-01-31', 1, 3.02, 'Franchi S.p.A.', 'Via Monte Bianco 34', 'Torino', NULL, '10100', 'Italy'),
	(10423, 'GOURL', 6, '1997-01-23', '1997-02-06', '1997-02-24', 3, 24.5, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
	(10424, 'MEREP', 7, '1997-01-23', '1997-02-20', '1997-01-27', 2, 370.61, 'Mère Paillarde', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada'),
	(10425, 'LAMAI', 6, '1997-01-24', '1997-02-21', '1997-02-14', 2, 7.93, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France'),
	(10426, 'GALED', 4, '1997-01-27', '1997-02-24', '1997-02-06', 1, 18.69, 'Galería del gastronómo', 'Rambla de Cataluña, 23', 'Barcelona', NULL, '8022', 'Spain'),
	(10427, 'PICCO', 4, '1997-01-27', '1997-02-24', '1997-03-03', 2, 31.29, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria'),
	(10428, 'REGGC', 7, '1997-01-28', '1997-02-25', '1997-02-04', 1, 11.09, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy'),
	(10429, 'HUNGO', 3, '1997-01-29', '1997-03-12', '1997-02-07', 2, 56.63, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10430, 'ERNSH', 4, '1997-01-30', '1997-02-13', '1997-02-03', 1, 458.78, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10431, 'BOTTM', 4, '1997-01-30', '1997-02-13', '1997-02-07', 2, 44.17, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
	(10432, 'SPLIR', 3, '1997-01-31', '1997-02-14', '1997-02-07', 2, 4.34, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
	(10433, 'PRINI', 3, '1997-02-03', '1997-03-03', '1997-03-04', 3, 73.83, 'Princesa Isabel Vinhos', 'Estrada da saúde n. 58', 'Lisboa', NULL, '1756', 'Portugal'),
	(10434, 'FOLKO', 3, '1997-02-03', '1997-03-03', '1997-02-13', 2, 17.92, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10435, 'CONSH', 8, '1997-02-04', '1997-03-18', '1997-02-07', 2, 9.21, 'Consolidated Holdings', 'Berkeley Gardens 12  Brewery', 'London', NULL, 'WX1 6LT', 'UK'),
	(10436, 'BLONP', 3, '1997-02-05', '1997-03-05', '1997-02-11', 2, 156.66, 'Blondel père et fils', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France'),
	(10437, 'WARTH', 8, '1997-02-05', '1997-03-05', '1997-02-12', 1, 19.97, 'Wartian Herkku', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland'),
	(10438, 'TOMSP', 3, '1997-02-06', '1997-03-06', '1997-02-14', 2, 8.24, 'Toms Spezialitäten', 'Luisenstr. 48', 'Münster', NULL, '44087', 'Germany'),
	(10439, 'MEREP', 6, '1997-02-07', '1997-03-07', '1997-02-10', 3, 4.07, 'Mère Paillarde', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada'),
	(10440, 'SAVEA', 4, '1997-02-10', '1997-03-10', '1997-02-28', 2, 86.53, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10441, 'OLDWO', 3, '1997-02-10', '1997-03-24', '1997-03-14', 2, 73.02, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
	(10442, 'ERNSH', 3, '1997-02-11', '1997-03-11', '1997-02-18', 2, 47.94, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10443, 'REGGC', 8, '1997-02-12', '1997-03-12', '1997-02-14', 1, 13.95, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy'),
	(10444, 'BERGS', 3, '1997-02-12', '1997-03-12', '1997-02-21', 3, 3.5, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10445, 'BERGS', 3, '1997-02-13', '1997-03-13', '1997-02-20', 1, 9.3, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10446, 'TOMSP', 6, '1997-02-14', '1997-03-14', '1997-02-19', 1, 14.68, 'Toms Spezialitäten', 'Luisenstr. 48', 'Münster', NULL, '44087', 'Germany'),
	(10447, 'RICAR', 4, '1997-02-14', '1997-03-14', '1997-03-07', 2, 68.66, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
	(10448, 'RANCH', 4, '1997-02-17', '1997-03-17', '1997-02-24', 2, 38.82, 'Rancho grande', 'Av. del Libertador 900', 'Buenos Aires', NULL, '1010', 'Argentina'),
	(10449, 'BLONP', 3, '1997-02-18', '1997-03-18', '1997-02-27', 2, 53.3, 'Blondel père et fils', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France'),
	(10450, 'VICTE', 8, '1997-02-19', '1997-03-19', '1997-03-11', 2, 7.23, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France'),
	(10451, 'QUICK', 4, '1997-02-19', '1997-03-05', '1997-03-12', 3, 189.09, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10452, 'SAVEA', 8, '1997-02-20', '1997-03-20', '1997-02-26', 1, 140.26, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10453, 'AROUT', 1, '1997-02-21', '1997-03-21', '1997-02-26', 2, 25.36, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
	(10454, 'LAMAI', 4, '1997-02-21', '1997-03-21', '1997-02-25', 3, 2.74, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France'),
	(10455, 'WARTH', 8, '1997-02-24', '1997-04-07', '1997-03-03', 2, 180.45, 'Wartian Herkku', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland'),
	(10456, 'KOENE', 8, '1997-02-25', '1997-04-08', '1997-02-28', 2, 8.12, 'Königlich Essen', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany'),
	(10457, 'KOENE', 2, '1997-02-25', '1997-03-25', '1997-03-03', 1, 11.57, 'Königlich Essen', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany'),
	(10458, 'SUPRD', 7, '1997-02-26', '1997-03-26', '1997-03-04', 3, 147.06, 'Suprêmes délices', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium'),
	(10459, 'VICTE', 4, '1997-02-27', '1997-03-27', '1997-02-28', 2, 25.09, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France'),
	(10460, 'FOLKO', 8, '1997-02-28', '1997-03-28', '1997-03-03', 1, 16.27, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10461, 'LILAS', 1, '1997-02-28', '1997-03-28', '1997-03-05', 3, 148.61, 'LILA-Supermercado', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
	(10462, 'CONSH', 2, '1997-03-03', '1997-03-31', '1997-03-18', 1, 6.17, 'Consolidated Holdings', 'Berkeley Gardens 12  Brewery', 'London', NULL, 'WX1 6LT', 'UK'),
	(10463, 'SUPRD', 5, '1997-03-04', '1997-04-01', '1997-03-06', 3, 14.78, 'Suprêmes délices', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium'),
	(10464, 'FURIB', 4, '1997-03-04', '1997-04-01', '1997-03-14', 2, 89, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal'),
	(10465, 'VAFFE', 1, '1997-03-05', '1997-04-02', '1997-03-14', 3, 145.04, 'Vaffeljernet', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark'),
	(10466, 'COMMI', 4, '1997-03-06', '1997-04-03', '1997-03-13', 1, 11.93, 'Comércio Mineiro', 'Av. dos Lusíadas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil'),
	(10467, 'MAGAA', 8, '1997-03-06', '1997-04-03', '1997-03-11', 2, 4.93, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy'),
	(10468, 'KOENE', 3, '1997-03-07', '1997-04-04', '1997-03-12', 3, 44.12, 'Königlich Essen', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany'),
	(10469, 'WHITC', 1, '1997-03-10', '1997-04-07', '1997-03-14', 1, 60.18, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
	(10470, 'BONAP', 4, '1997-03-11', '1997-04-08', '1997-03-14', 2, 64.56, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(10471, 'BSBEV', 2, '1997-03-11', '1997-04-08', '1997-03-18', 3, 45.59, 'B''s Beverages', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK'),
	(10472, 'SEVES', 8, '1997-03-12', '1997-04-09', '1997-03-19', 1, 4.2, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK'),
	(10473, 'ISLAT', 1, '1997-03-13', '1997-03-27', '1997-03-21', 3, 16.37, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
	(10474, 'PERIC', 5, '1997-03-13', '1997-04-10', '1997-03-21', 2, 83.49, 'Pericles Comidas clásicas', 'Calle Dr. Jorge Cash 321', 'México D.F.', NULL, '05033', 'Mexico'),
	(10475, 'SUPRD', 9, '1997-03-14', '1997-04-11', '1997-04-04', 1, 68.52, 'Suprêmes délices', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium'),
	(10476, 'HILAA', 8, '1997-03-17', '1997-04-14', '1997-03-24', 3, 4.41, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10477, 'PRINI', 5, '1997-03-17', '1997-04-14', '1997-03-25', 2, 13.02, 'Princesa Isabel Vinhos', 'Estrada da saúde n. 58', 'Lisboa', NULL, '1756', 'Portugal'),
	(10478, 'VICTE', 2, '1997-03-18', '1997-04-01', '1997-03-26', 3, 4.81, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France'),
	(10479, 'RATTC', 3, '1997-03-19', '1997-04-16', '1997-03-21', 3, 708.95, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(10480, 'FOLIG', 6, '1997-03-20', '1997-04-17', '1997-03-24', 2, 1.35, 'Folies gourmandes', '184, chaussée de Tournai', 'Lille', NULL, '59000', 'France'),
	(10481, 'RICAR', 8, '1997-03-20', '1997-04-17', '1997-03-25', 2, 64.33, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
	(10482, 'LAZYK', 1, '1997-03-21', '1997-04-18', '1997-04-10', 3, 7.48, 'Lazy K Kountry Store', '12 Orchestra Terrace', 'Walla Walla', 'WA', '99362', 'USA'),
	(10483, 'WHITC', 7, '1997-03-24', '1997-04-21', '1997-04-25', 2, 15.28, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
	(10484, 'BSBEV', 3, '1997-03-24', '1997-04-21', '1997-04-01', 3, 6.88, 'B''s Beverages', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK'),
	(10485, 'LINOD', 4, '1997-03-25', '1997-04-08', '1997-03-31', 2, 64.45, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
	(10486, 'HILAA', 1, '1997-03-26', '1997-04-23', '1997-04-02', 2, 30.53, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10487, 'QUEEN', 2, '1997-03-26', '1997-04-23', '1997-03-28', 2, 71.07, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
	(10488, 'FRANK', 8, '1997-03-27', '1997-04-24', '1997-04-02', 2, 4.93, 'Frankenversand', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany'),
	(10489, 'PICCO', 6, '1997-03-28', '1997-04-25', '1997-04-09', 2, 5.29, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria'),
	(10490, 'HILAA', 7, '1997-03-31', '1997-04-28', '1997-04-03', 2, 210.19, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10491, 'FURIB', 8, '1997-03-31', '1997-04-28', '1997-04-08', 3, 16.96, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal'),
	(10492, 'BOTTM', 3, '1997-04-01', '1997-04-29', '1997-04-11', 1, 62.89, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
	(10493, 'LAMAI', 4, '1997-04-02', '1997-04-30', '1997-04-10', 3, 10.64, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France'),
	(10494, 'COMMI', 4, '1997-04-02', '1997-04-30', '1997-04-09', 2, 65.99, 'Comércio Mineiro', 'Av. dos Lusíadas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil'),
	(10495, 'LAUGB', 3, '1997-04-03', '1997-05-01', '1997-04-11', 3, 4.65, 'Laughing Bacchus Wine Cellars', '2319 Elm St.', 'Vancouver', 'BC', 'V3F 2K1', 'Canada'),
	(10496, 'TRADH', 7, '1997-04-04', '1997-05-02', '1997-04-07', 2, 46.77, 'Tradiçao Hipermercados', 'Av. Inês de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil'),
	(10497, 'LEHMS', 7, '1997-04-04', '1997-05-02', '1997-04-07', 1, 36.21, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany'),
	(10498, 'HILAA', 8, '1997-04-07', '1997-05-05', '1997-04-11', 2, 29.75, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10499, 'LILAS', 4, '1997-04-08', '1997-05-06', '1997-04-16', 2, 102.02, 'LILA-Supermercado', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
	(10500, 'LAMAI', 6, '1997-04-09', '1997-05-07', '1997-04-17', 1, 42.68, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France'),
	(10501, 'BLAUS', 9, '1997-04-09', '1997-05-07', '1997-04-16', 3, 8.85, 'Blauer See Delikatessen', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany'),
	(10502, 'PERIC', 2, '1997-04-10', '1997-05-08', '1997-04-29', 1, 69.32, 'Pericles Comidas clásicas', 'Calle Dr. Jorge Cash 321', 'México D.F.', NULL, '05033', 'Mexico'),
	(10503, 'HUNGO', 6, '1997-04-11', '1997-05-09', '1997-04-16', 2, 16.74, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10504, 'WHITC', 4, '1997-04-11', '1997-05-09', '1997-04-18', 3, 59.13, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
	(10505, 'MEREP', 3, '1997-04-14', '1997-05-12', '1997-04-21', 3, 7.13, 'Mère Paillarde', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada'),
	(10506, 'KOENE', 9, '1997-04-15', '1997-05-13', '1997-05-02', 2, 21.19, 'Königlich Essen', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany'),
	(10507, 'ANTON', 7, '1997-04-15', '1997-05-13', '1997-04-22', 1, 47.45, 'Antonio Moreno Taquería', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico'),
	(10508, 'OTTIK', 1, '1997-04-16', '1997-05-14', '1997-05-13', 2, 4.99, 'Ottilies Käseladen', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany'),
	(10509, 'BLAUS', 4, '1997-04-17', '1997-05-15', '1997-04-29', 1, 0.15, 'Blauer See Delikatessen', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany'),
	(10510, 'SAVEA', 6, '1997-04-18', '1997-05-16', '1997-04-28', 3, 367.63, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10511, 'BONAP', 4, '1997-04-18', '1997-05-16', '1997-04-21', 3, 350.64, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(10512, 'FAMIA', 7, '1997-04-21', '1997-05-19', '1997-04-24', 2, 3.53, 'Familia Arquibaldo', 'Rua Orós, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil'),
	(10513, 'WANDK', 7, '1997-04-22', '1997-06-03', '1997-04-28', 1, 105.65, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany'),
	(10514, 'ERNSH', 3, '1997-04-22', '1997-05-20', '1997-05-16', 2, 789.95, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10515, 'QUICK', 2, '1997-04-23', '1997-05-07', '1997-05-23', 1, 204.47, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10516, 'HUNGO', 2, '1997-04-24', '1997-05-22', '1997-05-01', 3, 62.78, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10517, 'NORTS', 3, '1997-04-24', '1997-05-22', '1997-04-29', 3, 32.07, 'North/South', 'South House 300 Queensbridge', 'London', NULL, 'SW7 1RZ', 'UK'),
	(10518, 'TORTU', 4, '1997-04-25', '1997-05-09', '1997-05-05', 2, 218.15, 'Tortuga Restaurante', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico'),
	(10519, 'CHOPS', 6, '1997-04-28', '1997-05-26', '1997-05-01', 3, 91.76, 'Chop-suey Chinese', 'Hauptstr. 31', 'Bern', NULL, '3012', 'Switzerland'),
	(10520, 'SANTG', 7, '1997-04-29', '1997-05-27', '1997-05-01', 1, 13.37, 'Santé Gourmet', 'Erling Skakkes gate 78', 'Stavern', NULL, '4110', 'Norway'),
	(10521, 'CACTU', 8, '1997-04-29', '1997-05-27', '1997-05-02', 2, 17.22, 'Cactus Comidas para llevar', 'Cerrito 333', 'Buenos Aires', NULL, '1010', 'Argentina'),
	(10522, 'LEHMS', 4, '1997-04-30', '1997-05-28', '1997-05-06', 1, 45.33, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany'),
	(10523, 'SEVES', 7, '1997-05-01', '1997-05-29', '1997-05-30', 2, 77.63, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK'),
	(10524, 'BERGS', 1, '1997-05-01', '1997-05-29', '1997-05-07', 2, 244.79, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10525, 'BONAP', 1, '1997-05-02', '1997-05-30', '1997-05-23', 2, 11.06, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(10526, 'WARTH', 4, '1997-05-05', '1997-06-02', '1997-05-15', 2, 58.59, 'Wartian Herkku', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland'),
	(10527, 'QUICK', 7, '1997-05-05', '1997-06-02', '1997-05-07', 1, 41.9, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10528, 'GREAL', 6, '1997-05-06', '1997-05-20', '1997-05-09', 2, 3.35, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
	(10529, 'MAISD', 5, '1997-05-07', '1997-06-04', '1997-05-09', 2, 66.69, 'Maison Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', NULL, 'B-1180', 'Belgium'),
	(10530, 'PICCO', 3, '1997-05-08', '1997-06-05', '1997-05-12', 2, 339.22, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria'),
	(10531, 'OCEAN', 7, '1997-05-08', '1997-06-05', '1997-05-19', 1, 8.12, 'Océano Atlántico Ltda.', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', NULL, '1010', 'Argentina'),
	(10532, 'EASTC', 7, '1997-05-09', '1997-06-06', '1997-05-12', 3, 74.46, 'Eastern Connection', '35 King George', 'London', NULL, 'WX3 6FW', 'UK'),
	(10533, 'FOLKO', 8, '1997-05-12', '1997-06-09', '1997-05-22', 1, 188.04, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10534, 'LEHMS', 8, '1997-05-12', '1997-06-09', '1997-05-14', 2, 27.94, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany'),
	(10535, 'ANTON', 4, '1997-05-13', '1997-06-10', '1997-05-21', 1, 15.64, 'Antonio Moreno Taquería', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico'),
	(10536, 'LEHMS', 3, '1997-05-14', '1997-06-11', '1997-06-06', 2, 58.88, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany'),
	(10537, 'RICSU', 1, '1997-05-14', '1997-05-28', '1997-05-19', 1, 78.85, 'Richter Supermarkt', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland'),
	(10538, 'BSBEV', 9, '1997-05-15', '1997-06-12', '1997-05-16', 3, 4.87, 'B''s Beverages', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK'),
	(10539, 'BSBEV', 6, '1997-05-16', '1997-06-13', '1997-05-23', 3, 12.36, 'B''s Beverages', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK'),
	(10540, 'QUICK', 3, '1997-05-19', '1997-06-16', '1997-06-13', 3, 1007.64, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10541, 'HANAR', 2, '1997-05-19', '1997-06-16', '1997-05-29', 1, 68.65, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
	(10542, 'KOENE', 1, '1997-05-20', '1997-06-17', '1997-05-26', 3, 10.95, 'Königlich Essen', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany'),
	(10543, 'LILAS', 8, '1997-05-21', '1997-06-18', '1997-05-23', 2, 48.17, 'LILA-Supermercado', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
	(10544, 'LONEP', 4, '1997-05-21', '1997-06-18', '1997-05-30', 1, 24.91, 'Lonesome Pine Restaurant', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA'),
	(10545, 'LAZYK', 8, '1997-05-22', '1997-06-19', '1997-06-26', 2, 11.92, 'Lazy K Kountry Store', '12 Orchestra Terrace', 'Walla Walla', 'WA', '99362', 'USA'),
	(10546, 'VICTE', 1, '1997-05-23', '1997-06-20', '1997-05-27', 3, 194.72, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France'),
	(10547, 'SEVES', 3, '1997-05-23', '1997-06-20', '1997-06-02', 2, 178.43, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK'),
	(10548, 'TOMSP', 3, '1997-05-26', '1997-06-23', '1997-06-02', 2, 1.43, 'Toms Spezialitäten', 'Luisenstr. 48', 'Münster', NULL, '44087', 'Germany'),
	(10549, 'QUICK', 5, '1997-05-27', '1997-06-10', '1997-05-30', 1, 171.24, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10550, 'GODOS', 7, '1997-05-28', '1997-06-25', '1997-06-06', 3, 4.32, 'Godos Cocina Típica', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain'),
	(10551, 'FURIB', 4, '1997-05-28', '1997-07-09', '1997-06-06', 3, 72.95, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal'),
	(10552, 'HILAA', 2, '1997-05-29', '1997-06-26', '1997-06-05', 1, 83.22, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10553, 'WARTH', 2, '1997-05-30', '1997-06-27', '1997-06-03', 2, 149.49, 'Wartian Herkku', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland'),
	(10554, 'OTTIK', 4, '1997-05-30', '1997-06-27', '1997-06-05', 3, 120.97, 'Ottilies Käseladen', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany'),
	(10555, 'SAVEA', 6, '1997-06-02', '1997-06-30', '1997-06-04', 3, 252.49, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10556, 'SIMOB', 2, '1997-06-03', '1997-07-15', '1997-06-13', 1, 9.8, 'Simons bistro', 'Vinbæltet 34', 'Kobenhavn', NULL, '1734', 'Denmark'),
	(10557, 'LEHMS', 9, '1997-06-03', '1997-06-17', '1997-06-06', 2, 96.72, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany'),
	(10558, 'AROUT', 1, '1997-06-04', '1997-07-02', '1997-06-10', 2, 72.97, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
	(10559, 'BLONP', 6, '1997-06-05', '1997-07-03', '1997-06-13', 1, 8.05, 'Blondel père et fils', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France'),
	(10560, 'FRANK', 8, '1997-06-06', '1997-07-04', '1997-06-09', 1, 36.65, 'Frankenversand', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany'),
	(10561, 'FOLKO', 2, '1997-06-06', '1997-07-04', '1997-06-09', 2, 242.21, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10562, 'REGGC', 1, '1997-06-09', '1997-07-07', '1997-06-12', 1, 22.95, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy'),
	(10563, 'RICAR', 2, '1997-06-10', '1997-07-22', '1997-06-24', 2, 60.43, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
	(10564, 'RATTC', 4, '1997-06-10', '1997-07-08', '1997-06-16', 3, 13.75, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(10565, 'MEREP', 8, '1997-06-11', '1997-07-09', '1997-06-18', 2, 7.15, 'Mère Paillarde', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada'),
	(10566, 'BLONP', 9, '1997-06-12', '1997-07-10', '1997-06-18', 1, 88.4, 'Blondel père et fils', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France'),
	(10567, 'HUNGO', 1, '1997-06-12', '1997-07-10', '1997-06-17', 1, 33.97, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10568, 'GALED', 3, '1997-06-13', '1997-07-11', '1997-07-09', 3, 6.54, 'Galería del gastronómo', 'Rambla de Cataluña, 23', 'Barcelona', NULL, '8022', 'Spain'),
	(10569, 'RATTC', 5, '1997-06-16', '1997-07-14', '1997-07-11', 1, 58.98, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(10570, 'MEREP', 3, '1997-06-17', '1997-07-15', '1997-06-19', 3, 188.99, 'Mère Paillarde', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada'),
	(10571, 'ERNSH', 8, '1997-06-17', '1997-07-29', '1997-07-04', 3, 26.06, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10572, 'BERGS', 3, '1997-06-18', '1997-07-16', '1997-06-25', 2, 116.43, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10573, 'ANTON', 7, '1997-06-19', '1997-07-17', '1997-06-20', 3, 84.84, 'Antonio Moreno Taquería', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico'),
	(10574, 'TRAIH', 4, '1997-06-19', '1997-07-17', '1997-06-30', 2, 37.6, 'Trail''s Head Gourmet Provisioners', '722 DaVinci Blvd.', 'Kirkland', 'WA', '98034', 'USA'),
	(10575, 'MORGK', 5, '1997-06-20', '1997-07-04', '1997-06-30', 1, 127.34, 'Morgenstern Gesundkost', 'Heerstr. 22', 'Leipzig', NULL, '04179', 'Germany'),
	(10576, 'TORTU', 3, '1997-06-23', '1997-07-07', '1997-06-30', 3, 18.56, 'Tortuga Restaurante', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico'),
	(10577, 'TRAIH', 9, '1997-06-23', '1997-08-04', '1997-06-30', 2, 25.41, 'Trail''s Head Gourmet Provisioners', '722 DaVinci Blvd.', 'Kirkland', 'WA', '98034', 'USA'),
	(10578, 'BSBEV', 4, '1997-06-24', '1997-07-22', '1997-07-25', 3, 29.6, 'B''s Beverages', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK'),
	(10579, 'LETSS', 1, '1997-06-25', '1997-07-23', '1997-07-04', 2, 13.73, 'Let''s Stop N Shop', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', 'USA'),
	(10580, 'OTTIK', 4, '1997-06-26', '1997-07-24', '1997-07-01', 3, 75.89, 'Ottilies Käseladen', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany'),
	(10581, 'FAMIA', 3, '1997-06-26', '1997-07-24', '1997-07-02', 1, 3.01, 'Familia Arquibaldo', 'Rua Orós, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil'),
	(10582, 'BLAUS', 3, '1997-06-27', '1997-07-25', '1997-07-14', 2, 27.71, 'Blauer See Delikatessen', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany'),
	(10583, 'WARTH', 2, '1997-06-30', '1997-07-28', '1997-07-04', 2, 7.28, 'Wartian Herkku', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland'),
	(10584, 'BLONP', 4, '1997-06-30', '1997-07-28', '1997-07-04', 1, 59.14, 'Blondel père et fils', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France'),
	(10585, 'WELLI', 7, '1997-07-01', '1997-07-29', '1997-07-10', 1, 13.41, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
	(10586, 'REGGC', 9, '1997-07-02', '1997-07-30', '1997-07-09', 1, 0.48, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy'),
	(10587, 'QUEDE', 1, '1997-07-02', '1997-07-30', '1997-07-09', 1, 62.52, 'Que Delícia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
	(10588, 'QUICK', 2, '1997-07-03', '1997-07-31', '1997-07-10', 3, 194.67, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10589, 'GREAL', 8, '1997-07-04', '1997-08-01', '1997-07-14', 2, 4.42, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
	(10590, 'MEREP', 4, '1997-07-07', '1997-08-04', '1997-07-14', 3, 44.77, 'Mère Paillarde', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada'),
	(10591, 'VAFFE', 1, '1997-07-07', '1997-07-21', '1997-07-16', 1, 55.92, 'Vaffeljernet', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark'),
	(10592, 'LEHMS', 3, '1997-07-08', '1997-08-05', '1997-07-16', 1, 32.1, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany'),
	(10593, 'LEHMS', 7, '1997-07-09', '1997-08-06', '1997-08-13', 2, 174.2, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany'),
	(10594, 'OLDWO', 3, '1997-07-09', '1997-08-06', '1997-07-16', 2, 5.24, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
	(10595, 'ERNSH', 2, '1997-07-10', '1997-08-07', '1997-07-14', 1, 96.78, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10596, 'WHITC', 8, '1997-07-11', '1997-08-08', '1997-08-12', 1, 16.34, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
	(10597, 'PICCO', 7, '1997-07-11', '1997-08-08', '1997-07-18', 3, 35.12, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria'),
	(10598, 'RATTC', 1, '1997-07-14', '1997-08-11', '1997-07-18', 3, 44.42, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(10599, 'BSBEV', 6, '1997-07-15', '1997-08-26', '1997-07-21', 3, 29.98, 'B''s Beverages', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK'),
	(10600, 'HUNGC', 4, '1997-07-16', '1997-08-13', '1997-07-21', 1, 45.13, 'Hungry Coyote Import Store', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA'),
	(10601, 'HILAA', 7, '1997-07-16', '1997-08-27', '1997-07-22', 1, 58.3, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10602, 'VAFFE', 8, '1997-07-17', '1997-08-14', '1997-07-22', 2, 2.92, 'Vaffeljernet', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark'),
	(10603, 'SAVEA', 8, '1997-07-18', '1997-08-15', '1997-08-08', 2, 48.77, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10604, 'FURIB', 1, '1997-07-18', '1997-08-15', '1997-07-29', 1, 7.46, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal'),
	(10605, 'MEREP', 1, '1997-07-21', '1997-08-18', '1997-07-29', 2, 379.13, 'Mère Paillarde', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada'),
	(10606, 'TRADH', 4, '1997-07-22', '1997-08-19', '1997-07-31', 3, 79.4, 'Tradiçao Hipermercados', 'Av. Inês de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil'),
	(10607, 'SAVEA', 5, '1997-07-22', '1997-08-19', '1997-07-25', 1, 200.24, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10608, 'TOMSP', 4, '1997-07-23', '1997-08-20', '1997-08-01', 2, 27.79, 'Toms Spezialitäten', 'Luisenstr. 48', 'Münster', NULL, '44087', 'Germany'),
	(10609, 'DUMON', 7, '1997-07-24', '1997-08-21', '1997-07-30', 2, 1.85, 'Du monde entier', '67, rue des Cinquante Otages', 'Nantes', NULL, '44000', 'France'),
	(10610, 'LAMAI', 8, '1997-07-25', '1997-08-22', '1997-08-06', 1, 26.78, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France'),
	(10611, 'WOLZA', 6, '1997-07-25', '1997-08-22', '1997-08-01', 2, 80.65, 'Wolski Zajazd', 'ul. Filtrowa 68', 'Warszawa', NULL, '01-012', 'Poland'),
	(10612, 'SAVEA', 1, '1997-07-28', '1997-08-25', '1997-08-01', 2, 544.08, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10613, 'HILAA', 4, '1997-07-29', '1997-08-26', '1997-08-01', 2, 8.11, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10614, 'BLAUS', 8, '1997-07-29', '1997-08-26', '1997-08-01', 3, 1.93, 'Blauer See Delikatessen', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany'),
	(10615, 'WILMK', 2, '1997-07-30', '1997-08-27', '1997-08-06', 3, 0.75, 'Wilman Kala', 'Keskuskatu 45', 'Helsinki', NULL, '21240', 'Finland'),
	(10616, 'GREAL', 1, '1997-07-31', '1997-08-28', '1997-08-05', 2, 116.53, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
	(10617, 'GREAL', 4, '1997-07-31', '1997-08-28', '1997-08-04', 2, 18.53, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
	(10618, 'MEREP', 1, '1997-08-01', '1997-09-12', '1997-08-08', 1, 154.68, 'Mère Paillarde', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada'),
	(10619, 'MEREP', 3, '1997-08-04', '1997-09-01', '1997-08-07', 3, 91.05, 'Mère Paillarde', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada'),
	(10620, 'LAUGB', 2, '1997-08-05', '1997-09-02', '1997-08-14', 3, 0.94, 'Laughing Bacchus Wine Cellars', '2319 Elm St.', 'Vancouver', 'BC', 'V3F 2K1', 'Canada'),
	(10621, 'ISLAT', 4, '1997-08-05', '1997-09-02', '1997-08-11', 2, 23.73, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
	(10622, 'RICAR', 4, '1997-08-06', '1997-09-03', '1997-08-11', 3, 50.97, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
	(10623, 'FRANK', 8, '1997-08-07', '1997-09-04', '1997-08-12', 2, 97.18, 'Frankenversand', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany'),
	(10624, 'THECR', 4, '1997-08-07', '1997-09-04', '1997-08-19', 2, 94.8, 'The Cracker Box', '55 Grizzly Peak Rd.', 'Butte', 'MT', '59801', 'USA'),
	(10625, 'ANATR', 3, '1997-08-08', '1997-09-05', '1997-08-14', 1, 43.9, 'Ana Trujillo Emparedados y helados', 'Avda. de la Constitución 2222', 'México D.F.', NULL, '05021', 'Mexico'),
	(10626, 'BERGS', 1, '1997-08-11', '1997-09-08', '1997-08-20', 2, 138.69, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10627, 'SAVEA', 8, '1997-08-11', '1997-09-22', '1997-08-21', 3, 107.46, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10628, 'BLONP', 4, '1997-08-12', '1997-09-09', '1997-08-20', 3, 30.36, 'Blondel père et fils', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France'),
	(10629, 'GODOS', 4, '1997-08-12', '1997-09-09', '1997-08-20', 3, 85.46, 'Godos Cocina Típica', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain'),
	(10630, 'KOENE', 1, '1997-08-13', '1997-09-10', '1997-08-19', 2, 32.35, 'Königlich Essen', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany'),
	(10631, 'LAMAI', 8, '1997-08-14', '1997-09-11', '1997-08-15', 1, 0.87, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France'),
	(10632, 'WANDK', 8, '1997-08-14', '1997-09-11', '1997-08-19', 1, 41.38, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany'),
	(10633, 'ERNSH', 7, '1997-08-15', '1997-09-12', '1997-08-18', 3, 477.9, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10634, 'FOLIG', 4, '1997-08-15', '1997-09-12', '1997-08-21', 3, 487.38, 'Folies gourmandes', '184, chaussée de Tournai', 'Lille', NULL, '59000', 'France'),
	(10635, 'MAGAA', 8, '1997-08-18', '1997-09-15', '1997-08-21', 3, 47.46, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy'),
	(10636, 'WARTH', 4, '1997-08-19', '1997-09-16', '1997-08-26', 1, 1.15, 'Wartian Herkku', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland'),
	(10637, 'QUEEN', 6, '1997-08-19', '1997-09-16', '1997-08-26', 1, 201.29, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
	(10638, 'LINOD', 3, '1997-08-20', '1997-09-17', '1997-09-01', 1, 158.44, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
	(10639, 'SANTG', 7, '1997-08-20', '1997-09-17', '1997-08-27', 3, 38.64, 'Santé Gourmet', 'Erling Skakkes gate 78', 'Stavern', NULL, '4110', 'Norway'),
	(10640, 'WANDK', 4, '1997-08-21', '1997-09-18', '1997-08-28', 1, 23.55, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany'),
	(10641, 'HILAA', 4, '1997-08-22', '1997-09-19', '1997-08-26', 2, 179.61, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10642, 'SIMOB', 7, '1997-08-22', '1997-09-19', '1997-09-05', 3, 41.89, 'Simons bistro', 'Vinbæltet 34', 'Kobenhavn', NULL, '1734', 'Denmark'),
	(10643, 'ALFKI', 6, '1997-08-25', '1997-09-22', '1997-09-02', 1, 29.46, 'Alfreds Futterkiste', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany'),
	(10644, 'WELLI', 3, '1997-08-25', '1997-09-22', '1997-09-01', 2, 0.14, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
	(10645, 'HANAR', 4, '1997-08-26', '1997-09-23', '1997-09-02', 1, 12.41, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
	(10646, 'HUNGO', 9, '1997-08-27', '1997-10-08', '1997-09-03', 3, 142.33, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10647, 'QUEDE', 4, '1997-08-27', '1997-09-10', '1997-09-03', 2, 45.54, 'Que Delícia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
	(10648, 'RICAR', 5, '1997-08-28', '1997-10-09', '1997-09-09', 2, 14.25, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
	(10649, 'MAISD', 5, '1997-08-28', '1997-09-25', '1997-08-29', 3, 6.2, 'Maison Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', NULL, 'B-1180', 'Belgium'),
	(10650, 'FAMIA', 5, '1997-08-29', '1997-09-26', '1997-09-03', 3, 176.81, 'Familia Arquibaldo', 'Rua Orós, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil'),
	(10651, 'WANDK', 8, '1997-09-01', '1997-09-29', '1997-09-11', 2, 20.6, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany'),
	(10652, 'GOURL', 4, '1997-09-01', '1997-09-29', '1997-09-08', 2, 7.14, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
	(10653, 'FRANK', 1, '1997-09-02', '1997-09-30', '1997-09-19', 1, 93.25, 'Frankenversand', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany'),
	(10654, 'BERGS', 5, '1997-09-02', '1997-09-30', '1997-09-11', 1, 55.26, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10655, 'REGGC', 1, '1997-09-03', '1997-10-01', '1997-09-11', 2, 4.41, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy'),
	(10656, 'GREAL', 6, '1997-09-04', '1997-10-02', '1997-09-10', 1, 57.15, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
	(10657, 'SAVEA', 2, '1997-09-04', '1997-10-02', '1997-09-15', 2, 352.69, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10658, 'QUICK', 4, '1997-09-05', '1997-10-03', '1997-09-08', 1, 364.15, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10659, 'QUEEN', 7, '1997-09-05', '1997-10-03', '1997-09-10', 2, 105.81, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
	(10660, 'HUNGC', 8, '1997-09-08', '1997-10-06', '1997-10-15', 1, 111.29, 'Hungry Coyote Import Store', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA'),
	(10661, 'HUNGO', 7, '1997-09-09', '1997-10-07', '1997-09-15', 3, 17.55, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10662, 'LONEP', 3, '1997-09-09', '1997-10-07', '1997-09-18', 2, 1.28, 'Lonesome Pine Restaurant', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA'),
	(10663, 'BONAP', 2, '1997-09-10', '1997-09-24', '1997-10-03', 2, 113.15, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(10664, 'FURIB', 1, '1997-09-10', '1997-10-08', '1997-09-19', 3, 1.27, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal'),
	(10665, 'LONEP', 1, '1997-09-11', '1997-10-09', '1997-09-17', 2, 26.31, 'Lonesome Pine Restaurant', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA'),
	(10666, 'RICSU', 7, '1997-09-12', '1997-10-10', '1997-09-22', 2, 232.42, 'Richter Supermarkt', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland'),
	(10667, 'ERNSH', 7, '1997-09-12', '1997-10-10', '1997-09-19', 1, 78.09, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10668, 'WANDK', 1, '1997-09-15', '1997-10-13', '1997-09-23', 2, 47.22, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany'),
	(10669, 'SIMOB', 2, '1997-09-15', '1997-10-13', '1997-09-22', 1, 24.39, 'Simons bistro', 'Vinbæltet 34', 'Kobenhavn', NULL, '1734', 'Denmark'),
	(10670, 'FRANK', 4, '1997-09-16', '1997-10-14', '1997-09-18', 1, 203.48, 'Frankenversand', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany'),
	(10671, 'FRANR', 1, '1997-09-17', '1997-10-15', '1997-09-24', 1, 30.34, 'France restauration', '54, rue Royale', 'Nantes', NULL, '44000', 'France'),
	(10672, 'BERGS', 9, '1997-09-17', '1997-10-01', '1997-09-26', 2, 95.75, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10673, 'WILMK', 2, '1997-09-18', '1997-10-16', '1997-09-19', 1, 22.76, 'Wilman Kala', 'Keskuskatu 45', 'Helsinki', NULL, '21240', 'Finland'),
	(10674, 'ISLAT', 4, '1997-09-18', '1997-10-16', '1997-09-30', 2, 0.9, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
	(10675, 'FRANK', 5, '1997-09-19', '1997-10-17', '1997-09-23', 2, 31.85, 'Frankenversand', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany'),
	(10676, 'TORTU', 2, '1997-09-22', '1997-10-20', '1997-09-29', 2, 2.01, 'Tortuga Restaurante', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico'),
	(10677, 'ANTON', 1, '1997-09-22', '1997-10-20', '1997-09-26', 3, 4.03, 'Antonio Moreno Taquería', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico'),
	(10678, 'SAVEA', 7, '1997-09-23', '1997-10-21', '1997-10-16', 3, 388.98, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10679, 'BLONP', 8, '1997-09-23', '1997-10-21', '1997-09-30', 3, 27.94, 'Blondel père et fils', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France'),
	(10680, 'OLDWO', 1, '1997-09-24', '1997-10-22', '1997-09-26', 1, 26.61, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
	(10681, 'GREAL', 3, '1997-09-25', '1997-10-23', '1997-09-30', 3, 76.13, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
	(10682, 'ANTON', 3, '1997-09-25', '1997-10-23', '1997-10-01', 2, 36.13, 'Antonio Moreno Taquería', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico'),
	(10683, 'DUMON', 2, '1997-09-26', '1997-10-24', '1997-10-01', 1, 4.4, 'Du monde entier', '67, rue des Cinquante Otages', 'Nantes', NULL, '44000', 'France'),
	(10684, 'OTTIK', 3, '1997-09-26', '1997-10-24', '1997-09-30', 1, 145.63, 'Ottilies Käseladen', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany'),
	(10685, 'GOURL', 4, '1997-09-29', '1997-10-13', '1997-10-03', 2, 33.75, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
	(10686, 'PICCO', 2, '1997-09-30', '1997-10-28', '1997-10-08', 1, 96.5, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria'),
	(10687, 'HUNGO', 9, '1997-09-30', '1997-10-28', '1997-10-30', 2, 296.43, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10688, 'VAFFE', 4, '1997-10-01', '1997-10-15', '1997-10-07', 2, 299.09, 'Vaffeljernet', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark'),
	(10689, 'BERGS', 1, '1997-10-01', '1997-10-29', '1997-10-07', 2, 13.42, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10690, 'HANAR', 1, '1997-10-02', '1997-10-30', '1997-10-03', 1, 15.8, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
	(10691, 'QUICK', 2, '1997-10-03', '1997-11-14', '1997-10-22', 2, 810.05, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10692, 'ALFKI', 4, '1997-10-03', '1997-10-31', '1997-10-13', 2, 61.02, 'Alfred''s Futterkiste', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany'),
	(10693, 'WHITC', 3, '1997-10-06', '1997-10-20', '1997-10-10', 3, 139.34, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
	(10694, 'QUICK', 8, '1997-10-06', '1997-11-03', '1997-10-09', 3, 398.36, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10695, 'WILMK', 7, '1997-10-07', '1997-11-18', '1997-10-14', 1, 16.72, 'Wilman Kala', 'Keskuskatu 45', 'Helsinki', NULL, '21240', 'Finland'),
	(10696, 'WHITC', 8, '1997-10-08', '1997-11-19', '1997-10-14', 3, 102.55, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
	(10697, 'LINOD', 3, '1997-10-08', '1997-11-05', '1997-10-14', 1, 45.52, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
	(10698, 'ERNSH', 4, '1997-10-09', '1997-11-06', '1997-10-17', 1, 272.47, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10699, 'MORGK', 3, '1997-10-09', '1997-11-06', '1997-10-13', 3, 0.58, 'Morgenstern Gesundkost', 'Heerstr. 22', 'Leipzig', NULL, '04179', 'Germany'),
	(10700, 'SAVEA', 3, '1997-10-10', '1997-11-07', '1997-10-16', 1, 65.1, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10701, 'HUNGO', 6, '1997-10-13', '1997-10-27', '1997-10-15', 3, 220.31, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10702, 'ALFKI', 4, '1997-10-13', '1997-11-24', '1997-10-21', 1, 23.94, 'Alfred''s Futterkiste', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany'),
	(10703, 'FOLKO', 6, '1997-10-14', '1997-11-11', '1997-10-20', 2, 152.3, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10704, 'QUEEN', 6, '1997-10-14', '1997-11-11', '1997-11-07', 1, 4.78, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
	(10705, 'HILAA', 9, '1997-10-15', '1997-11-12', '1997-11-18', 2, 3.52, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10706, 'OLDWO', 8, '1997-10-16', '1997-11-13', '1997-10-21', 3, 135.63, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
	(10707, 'AROUT', 4, '1997-10-16', '1997-10-30', '1997-10-23', 3, 21.74, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
	(10708, 'THEBI', 6, '1997-10-17', '1997-11-28', '1997-11-05', 2, 2.96, 'The Big Cheese', '89 Jefferson Way Suite 2', 'Portland', 'OR', '97201', 'USA'),
	(10709, 'GOURL', 1, '1997-10-17', '1997-11-14', '1997-11-20', 3, 210.8, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
	(10710, 'FRANS', 1, '1997-10-20', '1997-11-17', '1997-10-23', 1, 4.98, 'Franchi S.p.A.', 'Via Monte Bianco 34', 'Torino', NULL, '10100', 'Italy'),
	(10711, 'SAVEA', 5, '1997-10-21', '1997-12-02', '1997-10-29', 2, 52.41, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10712, 'HUNGO', 3, '1997-10-21', '1997-11-18', '1997-10-31', 1, 89.93, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10713, 'SAVEA', 1, '1997-10-22', '1997-11-19', '1997-10-24', 1, 167.05, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10714, 'SAVEA', 5, '1997-10-22', '1997-11-19', '1997-10-27', 3, 24.49, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10715, 'BONAP', 3, '1997-10-23', '1997-11-06', '1997-10-29', 1, 63.2, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(10716, 'RANCH', 4, '1997-10-24', '1997-11-21', '1997-10-27', 2, 22.57, 'Rancho grande', 'Av. del Libertador 900', 'Buenos Aires', NULL, '1010', 'Argentina'),
	(10717, 'FRANK', 1, '1997-10-24', '1997-11-21', '1997-10-29', 2, 59.25, 'Frankenversand', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany'),
	(10718, 'KOENE', 1, '1997-10-27', '1997-11-24', '1997-10-29', 3, 170.88, 'Königlich Essen', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany'),
	(10719, 'LETSS', 8, '1997-10-27', '1997-11-24', '1997-11-05', 2, 51.44, 'Let''s Stop N Shop', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', 'USA'),
	(10720, 'QUEDE', 8, '1997-10-28', '1997-11-11', '1997-11-05', 2, 9.53, 'Que Delícia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
	(10721, 'QUICK', 5, '1997-10-29', '1997-11-26', '1997-10-31', 3, 48.92, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10722, 'SAVEA', 8, '1997-10-29', '1997-12-10', '1997-11-04', 1, 74.58, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10723, 'WHITC', 3, '1997-10-30', '1997-11-27', '1997-11-25', 1, 21.72, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
	(10724, 'MEREP', 8, '1997-10-30', '1997-12-11', '1997-11-05', 2, 57.75, 'Mère Paillarde', '43 rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada'),
	(10725, 'FAMIA', 4, '1997-10-31', '1997-11-28', '1997-11-05', 3, 10.83, 'Familia Arquibaldo', 'Rua Orós, 92', 'Sao Paulo', 'SP', '05442-030', 'Brazil'),
	(10726, 'EASTC', 4, '1997-11-03', '1997-11-17', '1997-12-05', 1, 16.56, 'Eastern Connection', '35 King George', 'London', NULL, 'WX3 6FW', 'UK'),
	(10727, 'REGGC', 2, '1997-11-03', '1997-12-01', '1997-12-05', 1, 89.9, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy'),
	(10728, 'QUEEN', 4, '1997-11-04', '1997-12-02', '1997-11-11', 2, 58.33, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
	(10729, 'LINOD', 8, '1997-11-04', '1997-12-16', '1997-11-14', 3, 141.06, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
	(10730, 'BONAP', 5, '1997-11-05', '1997-12-03', '1997-11-14', 1, 20.12, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(10731, 'CHOPS', 7, '1997-11-06', '1997-12-04', '1997-11-14', 1, 96.65, 'Chop-suey Chinese', 'Hauptstr. 31', 'Bern', NULL, '3012', 'Switzerland'),
	(10732, 'BONAP', 3, '1997-11-06', '1997-12-04', '1997-11-07', 1, 16.97, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(10733, 'BERGS', 1, '1997-11-07', '1997-12-05', '1997-11-10', 3, 110.11, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10734, 'GOURL', 2, '1997-11-07', '1997-12-05', '1997-11-12', 3, 1.63, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
	(10735, 'LETSS', 6, '1997-11-10', '1997-12-08', '1997-11-21', 2, 45.97, 'Let''s Stop N Shop', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', 'USA'),
	(10736, 'HUNGO', 9, '1997-11-11', '1997-12-09', '1997-11-21', 2, 44.1, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10737, 'VINET', 2, '1997-11-11', '1997-12-09', '1997-11-18', 2, 7.79, 'Vins et alcools Chevalier', '59 rue de l''Abbaye', 'Reims', NULL, '51100', 'France'),
	(10738, 'SPECD', 2, '1997-11-12', '1997-12-10', '1997-11-18', 1, 2.91, 'Spécialités du monde', '25, rue Lauriston', 'Paris', NULL, '75016', 'France'),
	(10739, 'VINET', 3, '1997-11-12', '1997-12-10', '1997-11-17', 3, 11.08, 'Vins et alcools Chevalier', '59 rue de l''Abbaye', 'Reims', NULL, '51100', 'France'),
	(10740, 'WHITC', 4, '1997-11-13', '1997-12-11', '1997-11-25', 2, 81.88, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
	(10741, 'AROUT', 4, '1997-11-14', '1997-11-28', '1997-11-18', 3, 10.96, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
	(10742, 'BOTTM', 3, '1997-11-14', '1997-12-12', '1997-11-18', 3, 243.73, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
	(10743, 'AROUT', 1, '1997-11-17', '1997-12-15', '1997-11-21', 2, 23.72, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
	(10744, 'VAFFE', 6, '1997-11-17', '1997-12-15', '1997-11-24', 1, 69.19, 'Vaffeljernet', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark'),
	(10745, 'QUICK', 9, '1997-11-18', '1997-12-16', '1997-11-27', 1, 3.52, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10746, 'CHOPS', 1, '1997-11-19', '1997-12-17', '1997-11-21', 3, 31.43, 'Chop-suey Chinese', 'Hauptstr. 31', 'Bern', NULL, '3012', 'Switzerland'),
	(10747, 'PICCO', 6, '1997-11-19', '1997-12-17', '1997-11-26', 1, 117.33, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria'),
	(10748, 'SAVEA', 3, '1997-11-20', '1997-12-18', '1997-11-28', 1, 232.55, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10749, 'ISLAT', 4, '1997-11-20', '1997-12-18', '1997-12-19', 2, 61.53, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
	(10750, 'WARTH', 9, '1997-11-21', '1997-12-19', '1997-11-24', 1, 79.3, 'Wartian Herkku', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland'),
	(10751, 'RICSU', 3, '1997-11-24', '1997-12-22', '1997-12-03', 3, 130.79, 'Richter Supermarkt', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland'),
	(10752, 'NORTS', 2, '1997-11-24', '1997-12-22', '1997-11-28', 3, 1.39, 'North/South', 'South House 300 Queensbridge', 'London', NULL, 'SW7 1RZ', 'UK'),
	(10753, 'FRANS', 3, '1997-11-25', '1997-12-23', '1997-11-27', 1, 7.7, 'Franchi S.p.A.', 'Via Monte Bianco 34', 'Torino', NULL, '10100', 'Italy'),
	(10754, 'MAGAA', 6, '1997-11-25', '1997-12-23', '1997-11-27', 3, 2.38, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy'),
	(10755, 'BONAP', 4, '1997-11-26', '1997-12-24', '1997-11-28', 2, 16.71, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(10756, 'SPLIR', 8, '1997-11-27', '1997-12-25', '1997-12-02', 2, 73.21, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
	(10757, 'SAVEA', 6, '1997-11-27', '1997-12-25', '1997-12-15', 1, 8.19, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10758, 'RICSU', 3, '1997-11-28', '1997-12-26', '1997-12-04', 3, 138.17, 'Richter Supermarkt', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland'),
	(10759, 'ANATR', 3, '1997-11-28', '1997-12-26', '1997-12-12', 3, 11.99, 'Ana Trujillo Emparedados y helados', 'Avda. de la Constitución 2222', 'México D.F.', NULL, '05021', 'Mexico'),
	(10760, 'MAISD', 4, '1997-12-01', '1997-12-29', '1997-12-10', 1, 155.64, 'Maison Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', NULL, 'B-1180', 'Belgium'),
	(10761, 'RATTC', 5, '1997-12-02', '1997-12-30', '1997-12-08', 2, 18.66, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(10762, 'FOLKO', 3, '1997-12-02', '1997-12-30', '1997-12-09', 1, 328.74, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10763, 'FOLIG', 3, '1997-12-03', '1997-12-31', '1997-12-08', 3, 37.35, 'Folies gourmandes', '184, chaussée de Tournai', 'Lille', NULL, '59000', 'France'),
	(10764, 'ERNSH', 6, '1997-12-03', '1997-12-31', '1997-12-08', 3, 145.45, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10765, 'QUICK', 3, '1997-12-04', '1998-01-01', '1997-12-09', 3, 42.74, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10766, 'OTTIK', 4, '1997-12-05', '1998-01-02', '1997-12-09', 1, 157.55, 'Ottilies Käseladen', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany'),
	(10767, 'SUPRD', 4, '1997-12-05', '1998-01-02', '1997-12-15', 3, 1.59, 'Suprêmes délices', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium'),
	(10768, 'AROUT', 3, '1997-12-08', '1998-01-05', '1997-12-15', 2, 146.32, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
	(10769, 'VAFFE', 3, '1997-12-08', '1998-01-05', '1997-12-12', 1, 65.06, 'Vaffeljernet', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark'),
	(10770, 'HANAR', 8, '1997-12-09', '1998-01-06', '1997-12-17', 3, 5.32, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
	(10771, 'ERNSH', 9, '1997-12-10', '1998-01-07', '1998-01-02', 2, 11.19, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10772, 'LEHMS', 3, '1997-12-10', '1998-01-07', '1997-12-19', 2, 91.28, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany'),
	(10773, 'ERNSH', 1, '1997-12-11', '1998-01-08', '1997-12-16', 3, 96.43, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10774, 'FOLKO', 4, '1997-12-11', '1997-12-25', '1997-12-12', 1, 48.2, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10775, 'THECR', 7, '1997-12-12', '1998-01-09', '1997-12-26', 1, 20.25, 'The Cracker Box', '55 Grizzly Peak Rd.', 'Butte', 'MT', '59801', 'USA'),
	(10776, 'ERNSH', 1, '1997-12-15', '1998-01-12', '1997-12-18', 3, 351.53, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10777, 'GOURL', 7, '1997-12-15', '1997-12-29', '1998-01-21', 2, 3.01, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
	(10778, 'BERGS', 3, '1997-12-16', '1998-01-13', '1997-12-24', 1, 6.79, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10779, 'MORGK', 3, '1997-12-16', '1998-01-13', '1998-01-14', 2, 58.13, 'Morgenstern Gesundkost', 'Heerstr. 22', 'Leipzig', NULL, '04179', 'Germany'),
	(10780, 'LILAS', 2, '1997-12-16', '1997-12-30', '1997-12-25', 1, 42.13, 'LILA-Supermercado', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
	(10781, 'WARTH', 2, '1997-12-17', '1998-01-14', '1997-12-19', 3, 73.16, 'Wartian Herkku', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland'),
	(10782, 'CACTU', 9, '1997-12-17', '1998-01-14', '1997-12-22', 3, 1.1, 'Cactus Comidas para llevar', 'Cerrito 333', 'Buenos Aires', NULL, '1010', 'Argentina'),
	(10783, 'HANAR', 4, '1997-12-18', '1998-01-15', '1997-12-19', 2, 124.98, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
	(10784, 'MAGAA', 4, '1997-12-18', '1998-01-15', '1997-12-22', 3, 70.09, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy'),
	(10785, 'GROSR', 1, '1997-12-18', '1998-01-15', '1997-12-24', 3, 1.51, 'GROSELLA-Restaurante', '5ª Ave. Los Palos Grandes', 'Caracas', 'DF', '1081', 'Venezuela'),
	(10786, 'QUEEN', 8, '1997-12-19', '1998-01-16', '1997-12-23', 1, 110.87, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
	(10787, 'LAMAI', 2, '1997-12-19', '1998-01-02', '1997-12-26', 1, 249.93, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France'),
	(10788, 'QUICK', 1, '1997-12-22', '1998-01-19', '1998-01-19', 2, 42.7, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10789, 'FOLIG', 1, '1997-12-22', '1998-01-19', '1997-12-31', 2, 100.6, 'Folies gourmandes', '184, chaussée de Tournai', 'Lille', NULL, '59000', 'France'),
	(10790, 'GOURL', 6, '1997-12-22', '1998-01-19', '1997-12-26', 1, 28.23, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
	(10791, 'FRANK', 6, '1997-12-23', '1998-01-20', '1998-01-01', 2, 16.85, 'Frankenversand', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany'),
	(10792, 'WOLZA', 1, '1997-12-23', '1998-01-20', '1997-12-31', 3, 23.79, 'Wolski Zajazd', 'ul. Filtrowa 68', 'Warszawa', NULL, '01-012', 'Poland'),
	(10793, 'AROUT', 3, '1997-12-24', '1998-01-21', '1998-01-08', 3, 4.52, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
	(10794, 'QUEDE', 6, '1997-12-24', '1998-01-21', '1998-01-02', 1, 21.49, 'Que Delícia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
	(10795, 'ERNSH', 8, '1997-12-24', '1998-01-21', '1998-01-20', 2, 126.66, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10796, 'HILAA', 3, '1997-12-25', '1998-01-22', '1998-01-14', 1, 26.52, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10797, 'DRACD', 7, '1997-12-25', '1998-01-22', '1998-01-05', 2, 33.35, 'Drachenblut Delikatessen', 'Walserweg 21', 'Aachen', NULL, '52066', 'Germany'),
	(10798, 'ISLAT', 2, '1997-12-26', '1998-01-23', '1998-01-05', 1, 2.33, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
	(10799, 'KOENE', 9, '1997-12-26', '1998-02-06', '1998-01-05', 3, 30.76, 'Königlich Essen', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany'),
	(10800, 'SEVES', 1, '1997-12-26', '1998-01-23', '1998-01-05', 3, 137.44, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK'),
	(10801, 'BOLID', 4, '1997-12-29', '1998-01-26', '1997-12-31', 2, 97.09, 'Bólido Comidas preparadas', 'C/ Araquil, 67', 'Madrid', NULL, '28023', 'Spain'),
	(10802, 'SIMOB', 4, '1997-12-29', '1998-01-26', '1998-01-02', 2, 257.26, 'Simons bistro', 'Vinbæltet 34', 'Kobenhavn', NULL, '1734', 'Denmark'),
	(10803, 'WELLI', 4, '1997-12-30', '1998-01-27', '1998-01-06', 1, 55.23, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
	(10804, 'SEVES', 6, '1997-12-30', '1998-01-27', '1998-01-07', 2, 27.33, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK'),
	(10805, 'THEBI', 2, '1997-12-30', '1998-01-27', '1998-01-09', 3, 237.34, 'The Big Cheese', '89 Jefferson Way Suite 2', 'Portland', 'OR', '97201', 'USA'),
	(10806, 'VICTE', 3, '1997-12-31', '1998-01-28', '1998-01-05', 2, 22.11, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France'),
	(10807, 'FRANS', 4, '1997-12-31', '1998-01-28', '1998-01-30', 1, 1.36, 'Franchi S.p.A.', 'Via Monte Bianco 34', 'Torino', NULL, '10100', 'Italy'),
	(10808, 'OLDWO', 2, '1998-01-01', '1998-01-29', '1998-01-09', 3, 45.53, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
	(10809, 'WELLI', 7, '1998-01-01', '1998-01-29', '1998-01-07', 1, 4.87, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
	(10810, 'LAUGB', 2, '1998-01-01', '1998-01-29', '1998-01-07', 3, 4.33, 'Laughing Bacchus Wine Cellars', '2319 Elm St.', 'Vancouver', 'BC', 'V3F 2K1', 'Canada'),
	(10811, 'LINOD', 8, '1998-01-02', '1998-01-30', '1998-01-08', 1, 31.22, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
	(10812, 'REGGC', 5, '1998-01-02', '1998-01-30', '1998-01-12', 1, 59.78, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy'),
	(10813, 'RICAR', 1, '1998-01-05', '1998-02-02', '1998-01-09', 1, 47.38, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
	(10814, 'VICTE', 3, '1998-01-05', '1998-02-02', '1998-01-14', 3, 130.94, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France'),
	(10815, 'SAVEA', 2, '1998-01-05', '1998-02-02', '1998-01-14', 3, 14.62, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10816, 'GREAL', 4, '1998-01-06', '1998-02-03', '1998-02-04', 2, 719.78, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
	(10817, 'KOENE', 3, '1998-01-06', '1998-01-20', '1998-01-13', 2, 306.07, 'Königlich Essen', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany'),
	(10818, 'MAGAA', 7, '1998-01-07', '1998-02-04', '1998-01-12', 3, 65.48, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy'),
	(10819, 'CACTU', 2, '1998-01-07', '1998-02-04', '1998-01-16', 3, 19.76, 'Cactus Comidas para llevar', 'Cerrito 333', 'Buenos Aires', NULL, '1010', 'Argentina'),
	(10820, 'RATTC', 3, '1998-01-07', '1998-02-04', '1998-01-13', 2, 37.52, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(10821, 'SPLIR', 1, '1998-01-08', '1998-02-05', '1998-01-15', 1, 36.68, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
	(10822, 'TRAIH', 6, '1998-01-08', '1998-02-05', '1998-01-16', 3, 7, 'Trail''s Head Gourmet Provisioners', '722 DaVinci Blvd.', 'Kirkland', 'WA', '98034', 'USA'),
	(10823, 'LILAS', 5, '1998-01-09', '1998-02-06', '1998-01-13', 2, 163.97, 'LILA-Supermercado', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
	(10824, 'FOLKO', 8, '1998-01-09', '1998-02-06', '1998-01-30', 1, 1.23, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10825, 'DRACD', 1, '1998-01-09', '1998-02-06', '1998-01-14', 1, 79.25, 'Drachenblut Delikatessen', 'Walserweg 21', 'Aachen', NULL, '52066', 'Germany'),
	(10826, 'BLONP', 6, '1998-01-12', '1998-02-09', '1998-02-06', 1, 7.09, 'Blondel père et fils', '24, place Kléber', 'Strasbourg', NULL, '67000', 'France'),
	(10827, 'BONAP', 1, '1998-01-12', '1998-01-26', '1998-02-06', 2, 63.54, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(10828, 'RANCH', 9, '1998-01-13', '1998-01-27', '1998-02-04', 1, 90.85, 'Rancho grande', 'Av. del Libertador 900', 'Buenos Aires', NULL, '1010', 'Argentina'),
	(10829, 'ISLAT', 9, '1998-01-13', '1998-02-10', '1998-01-23', 1, 154.72, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
	(10830, 'TRADH', 4, '1998-01-13', '1998-02-24', '1998-01-21', 2, 81.83, 'Tradiçao Hipermercados', 'Av. Inês de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil'),
	(10831, 'SANTG', 3, '1998-01-14', '1998-02-11', '1998-01-23', 2, 72.19, 'Santé Gourmet', 'Erling Skakkes gate 78', 'Stavern', NULL, '4110', 'Norway'),
	(10832, 'LAMAI', 2, '1998-01-14', '1998-02-11', '1998-01-19', 2, 43.26, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France'),
	(10833, 'OTTIK', 6, '1998-01-15', '1998-02-12', '1998-01-23', 2, 71.49, 'Ottilies Käseladen', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany'),
	(10834, 'TRADH', 1, '1998-01-15', '1998-02-12', '1998-01-19', 3, 29.78, 'Tradiçao Hipermercados', 'Av. Inês de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil'),
	(10835, 'ALFKI', 1, '1998-01-15', '1998-02-12', '1998-01-21', 3, 69.53, 'Alfred''s Futterkiste', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany'),
	(10836, 'ERNSH', 7, '1998-01-16', '1998-02-13', '1998-01-21', 1, 411.88, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10837, 'BERGS', 9, '1998-01-16', '1998-02-13', '1998-01-23', 3, 13.32, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10838, 'LINOD', 3, '1998-01-19', '1998-02-16', '1998-01-23', 3, 59.28, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
	(10839, 'TRADH', 3, '1998-01-19', '1998-02-16', '1998-01-22', 3, 35.43, 'Tradiçao Hipermercados', 'Av. Inês de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil'),
	(10840, 'LINOD', 4, '1998-01-19', '1998-03-02', '1998-02-16', 2, 2.71, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
	(10841, 'SUPRD', 5, '1998-01-20', '1998-02-17', '1998-01-29', 2, 424.3, 'Suprêmes délices', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium'),
	(10842, 'TORTU', 1, '1998-01-20', '1998-02-17', '1998-01-29', 3, 54.42, 'Tortuga Restaurante', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico'),
	(10843, 'VICTE', 4, '1998-01-21', '1998-02-18', '1998-01-26', 2, 9.26, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France'),
	(10844, 'PICCO', 8, '1998-01-21', '1998-02-18', '1998-01-26', 2, 25.22, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria'),
	(10845, 'QUICK', 8, '1998-01-21', '1998-02-04', '1998-01-30', 1, 212.98, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10846, 'SUPRD', 2, '1998-01-22', '1998-03-05', '1998-01-23', 3, 56.46, 'Suprêmes délices', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium'),
	(10847, 'SAVEA', 4, '1998-01-22', '1998-02-05', '1998-02-10', 3, 487.57, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10848, 'CONSH', 7, '1998-01-23', '1998-02-20', '1998-01-29', 2, 38.24, 'Consolidated Holdings', 'Berkeley Gardens 12  Brewery', 'London', NULL, 'WX1 6LT', 'UK'),
	(10849, 'KOENE', 9, '1998-01-23', '1998-02-20', '1998-01-30', 2, 0.56, 'Königlich Essen', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany'),
	(10850, 'VICTE', 1, '1998-01-23', '1998-03-06', '1998-01-30', 1, 49.19, 'Victuailles en stock', '2, rue du Commerce', 'Lyon', NULL, '69004', 'France'),
	(10851, 'RICAR', 5, '1998-01-26', '1998-02-23', '1998-02-02', 1, 160.55, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
	(10852, 'RATTC', 8, '1998-01-26', '1998-02-09', '1998-01-30', 1, 174.05, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(10853, 'BLAUS', 9, '1998-01-27', '1998-02-24', '1998-02-03', 2, 53.83, 'Blauer See Delikatessen', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany'),
	(10854, 'ERNSH', 3, '1998-01-27', '1998-02-24', '1998-02-05', 2, 100.22, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10855, 'OLDWO', 3, '1998-01-27', '1998-02-24', '1998-02-04', 1, 170.97, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
	(10856, 'ANTON', 3, '1998-01-28', '1998-02-25', '1998-02-10', 2, 58.43, 'Antonio Moreno Taquería', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico'),
	(10857, 'BERGS', 8, '1998-01-28', '1998-02-25', '1998-02-06', 2, 188.85, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10858, 'LACOR', 2, '1998-01-29', '1998-02-26', '1998-02-03', 1, 52.51, 'La corne d''abondance', '67, avenue de l''Europe', 'Versailles', NULL, '78000', 'France'),
	(10859, 'FRANK', 1, '1998-01-29', '1998-02-26', '1998-02-02', 2, 76.1, 'Frankenversand', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany'),
	(10860, 'FRANR', 3, '1998-01-29', '1998-02-26', '1998-02-04', 3, 19.26, 'France restauration', '54, rue Royale', 'Nantes', NULL, '44000', 'France'),
	(10861, 'WHITC', 4, '1998-01-30', '1998-02-27', '1998-02-17', 2, 14.93, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
	(10862, 'LEHMS', 8, '1998-01-30', '1998-03-13', '1998-02-02', 2, 53.23, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany'),
	(10863, 'HILAA', 4, '1998-02-02', '1998-03-02', '1998-02-17', 2, 30.26, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10864, 'AROUT', 4, '1998-02-02', '1998-03-02', '1998-02-09', 2, 3.04, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
	(10865, 'QUICK', 2, '1998-02-02', '1998-02-16', '1998-02-12', 1, 348.14, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10866, 'BERGS', 5, '1998-02-03', '1998-03-03', '1998-02-12', 1, 109.11, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10867, 'LONEP', 6, '1998-02-03', '1998-03-17', '1998-02-11', 1, 1.93, 'Lonesome Pine Restaurant', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA'),
	(10868, 'QUEEN', 7, '1998-02-04', '1998-03-04', '1998-02-23', 2, 191.27, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
	(10869, 'SEVES', 5, '1998-02-04', '1998-03-04', '1998-02-09', 1, 143.28, 'Seven Seas Imports', '90 Wadhurst Rd.', 'London', NULL, 'OX15 4NB', 'UK'),
	(10870, 'WOLZA', 5, '1998-02-04', '1998-03-04', '1998-02-13', 3, 12.04, 'Wolski Zajazd', 'ul. Filtrowa 68', 'Warszawa', NULL, '01-012', 'Poland'),
	(10871, 'BONAP', 9, '1998-02-05', '1998-03-05', '1998-02-10', 2, 112.27, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(10872, 'GODOS', 5, '1998-02-05', '1998-03-05', '1998-02-09', 2, 175.32, 'Godos Cocina Típica', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain'),
	(10873, 'WILMK', 4, '1998-02-06', '1998-03-06', '1998-02-09', 1, 0.82, 'Wilman Kala', 'Keskuskatu 45', 'Helsinki', NULL, '21240', 'Finland'),
	(10874, 'GODOS', 5, '1998-02-06', '1998-03-06', '1998-02-11', 2, 19.58, 'Godos Cocina Típica', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain'),
	(10875, 'BERGS', 4, '1998-02-06', '1998-03-06', '1998-03-03', 2, 32.37, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10876, 'BONAP', 7, '1998-02-09', '1998-03-09', '1998-02-12', 3, 60.42, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(10877, 'RICAR', 1, '1998-02-09', '1998-03-09', '1998-02-19', 1, 38.06, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
	(10878, 'QUICK', 4, '1998-02-10', '1998-03-10', '1998-02-12', 1, 46.69, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10879, 'WILMK', 3, '1998-02-10', '1998-03-10', '1998-02-12', 3, 8.5, 'Wilman Kala', 'Keskuskatu 45', 'Helsinki', NULL, '21240', 'Finland'),
	(10880, 'FOLKO', 7, '1998-02-10', '1998-03-24', '1998-02-18', 1, 88.01, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10881, 'CACTU', 4, '1998-02-11', '1998-03-11', '1998-02-18', 1, 2.84, 'Cactus Comidas para llevar', 'Cerrito 333', 'Buenos Aires', NULL, '1010', 'Argentina'),
	(10882, 'SAVEA', 4, '1998-02-11', '1998-03-11', '1998-02-20', 3, 23.1, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10883, 'LONEP', 8, '1998-02-12', '1998-03-12', '1998-02-20', 3, 0.53, 'Lonesome Pine Restaurant', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA'),
	(10884, 'LETSS', 4, '1998-02-12', '1998-03-12', '1998-02-13', 2, 90.97, 'Let''s Stop N Shop', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', 'USA'),
	(10885, 'SUPRD', 6, '1998-02-12', '1998-03-12', '1998-02-18', 3, 5.64, 'Suprêmes délices', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium'),
	(10886, 'HANAR', 1, '1998-02-13', '1998-03-13', '1998-03-02', 1, 4.99, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
	(10887, 'GALED', 8, '1998-02-13', '1998-03-13', '1998-02-16', 3, 1.25, 'Galería del gastronómo', 'Rambla de Cataluña, 23', 'Barcelona', NULL, '8022', 'Spain'),
	(10888, 'GODOS', 1, '1998-02-16', '1998-03-16', '1998-02-23', 2, 51.87, 'Godos Cocina Típica', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain'),
	(10889, 'RATTC', 9, '1998-02-16', '1998-03-16', '1998-02-23', 3, 280.61, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(10890, 'DUMON', 7, '1998-02-16', '1998-03-16', '1998-02-18', 1, 32.76, 'Du monde entier', '67, rue des Cinquante Otages', 'Nantes', NULL, '44000', 'France'),
	(10891, 'LEHMS', 7, '1998-02-17', '1998-03-17', '1998-02-19', 2, 20.37, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany'),
	(10892, 'MAISD', 4, '1998-02-17', '1998-03-17', '1998-02-19', 2, 120.27, 'Maison Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', NULL, 'B-1180', 'Belgium'),
	(10893, 'KOENE', 9, '1998-02-18', '1998-03-18', '1998-02-20', 2, 77.78, 'Königlich Essen', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany'),
	(10894, 'SAVEA', 1, '1998-02-18', '1998-03-18', '1998-02-20', 1, 116.13, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10895, 'ERNSH', 3, '1998-02-18', '1998-03-18', '1998-02-23', 1, 162.75, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10896, 'MAISD', 7, '1998-02-19', '1998-03-19', '1998-02-27', 3, 32.45, 'Maison Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', NULL, 'B-1180', 'Belgium'),
	(10897, 'HUNGO', 3, '1998-02-19', '1998-03-19', '1998-02-25', 2, 603.54, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10898, 'OCEAN', 4, '1998-02-20', '1998-03-20', '1998-03-06', 2, 1.27, 'Océano Atlántico Ltda.', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', NULL, '1010', 'Argentina'),
	(10899, 'LILAS', 5, '1998-02-20', '1998-03-20', '1998-02-26', 3, 1.21, 'LILA-Supermercado', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
	(10900, 'WELLI', 1, '1998-02-20', '1998-03-20', '1998-03-04', 2, 1.66, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
	(10901, 'HILAA', 4, '1998-02-23', '1998-03-23', '1998-02-26', 1, 62.09, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10902, 'FOLKO', 1, '1998-02-23', '1998-03-23', '1998-03-03', 1, 44.15, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10903, 'HANAR', 3, '1998-02-24', '1998-03-24', '1998-03-04', 3, 36.71, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
	(10904, 'WHITC', 3, '1998-02-24', '1998-03-24', '1998-02-27', 3, 162.95, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
	(10905, 'WELLI', 9, '1998-02-24', '1998-03-24', '1998-03-06', 2, 13.72, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
	(10906, 'WOLZA', 4, '1998-02-25', '1998-03-11', '1998-03-03', 3, 26.29, 'Wolski Zajazd', 'ul. Filtrowa 68', 'Warszawa', NULL, '01-012', 'Poland'),
	(10907, 'SPECD', 6, '1998-02-25', '1998-03-25', '1998-02-27', 3, 9.19, 'Spécialités du monde', '25, rue Lauriston', 'Paris', NULL, '75016', 'France'),
	(10908, 'REGGC', 4, '1998-02-26', '1998-03-26', '1998-03-06', 2, 32.96, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy'),
	(10909, 'SANTG', 1, '1998-02-26', '1998-03-26', '1998-03-10', 2, 53.05, 'Santé Gourmet', 'Erling Skakkes gate 78', 'Stavern', NULL, '4110', 'Norway'),
	(10910, 'WILMK', 1, '1998-02-26', '1998-03-26', '1998-03-04', 3, 38.11, 'Wilman Kala', 'Keskuskatu 45', 'Helsinki', NULL, '21240', 'Finland'),
	(10911, 'GODOS', 3, '1998-02-26', '1998-03-26', '1998-03-05', 1, 38.19, 'Godos Cocina Típica', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain'),
	(10912, 'HUNGO', 2, '1998-02-26', '1998-03-26', '1998-03-18', 2, 580.91, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10913, 'QUEEN', 4, '1998-02-26', '1998-03-26', '1998-03-04', 1, 33.05, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
	(10914, 'QUEEN', 6, '1998-02-27', '1998-03-27', '1998-03-02', 1, 21.19, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
	(10915, 'TORTU', 2, '1998-02-27', '1998-03-27', '1998-03-02', 2, 3.51, 'Tortuga Restaurante', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico'),
	(10916, 'RANCH', 1, '1998-02-27', '1998-03-27', '1998-03-09', 2, 63.77, 'Rancho grande', 'Av. del Libertador 900', 'Buenos Aires', NULL, '1010', 'Argentina'),
	(10917, 'ROMEY', 4, '1998-03-02', '1998-03-30', '1998-03-11', 2, 8.29, 'Romero y tomillo', 'Gran Vía, 1', 'Madrid', NULL, '28001', 'Spain'),
	(10918, 'BOTTM', 3, '1998-03-02', '1998-03-30', '1998-03-11', 3, 48.83, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
	(10919, 'LINOD', 2, '1998-03-02', '1998-03-30', '1998-03-04', 2, 19.8, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
	(10920, 'AROUT', 4, '1998-03-03', '1998-03-31', '1998-03-09', 2, 29.61, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
	(10921, 'VAFFE', 1, '1998-03-03', '1998-04-14', '1998-03-09', 1, 176.48, 'Vaffeljernet', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark'),
	(10922, 'HANAR', 5, '1998-03-03', '1998-03-31', '1998-03-05', 3, 62.74, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
	(10923, 'LAMAI', 7, '1998-03-03', '1998-04-14', '1998-03-13', 3, 68.26, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France'),
	(10924, 'BERGS', 3, '1998-03-04', '1998-04-01', '1998-04-08', 2, 151.52, 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', NULL, 'S-958 22', 'Sweden'),
	(10925, 'HANAR', 3, '1998-03-04', '1998-04-01', '1998-03-13', 1, 2.27, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
	(10926, 'ANATR', 4, '1998-03-04', '1998-04-01', '1998-03-11', 3, 39.92, 'Ana Trujillo Emparedados y helados', 'Avda. de la Constitución 2222', 'México D.F.', NULL, '05021', 'Mexico'),
	(10927, 'LACOR', 4, '1998-03-05', '1998-04-02', '1998-04-08', 1, 19.79, 'La corne d''abondance', '67, avenue de l''Europe', 'Versailles', NULL, '78000', 'France'),
	(10928, 'GALED', 1, '1998-03-05', '1998-04-02', '1998-03-18', 1, 1.36, 'Galería del gastronómo', 'Rambla de Cataluña, 23', 'Barcelona', NULL, '8022', 'Spain'),
	(10929, 'FRANK', 6, '1998-03-05', '1998-04-02', '1998-03-12', 1, 33.93, 'Frankenversand', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany'),
	(10930, 'SUPRD', 4, '1998-03-06', '1998-04-17', '1998-03-18', 3, 15.55, 'Suprêmes délices', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium'),
	(10931, 'RICSU', 4, '1998-03-06', '1998-03-20', '1998-03-19', 2, 13.6, 'Richter Supermarkt', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland'),
	(10932, 'BONAP', 8, '1998-03-06', '1998-04-03', '1998-03-24', 1, 134.64, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(10933, 'ISLAT', 6, '1998-03-06', '1998-04-03', '1998-03-16', 3, 54.15, 'Island Trading', 'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK'),
	(10934, 'LEHMS', 3, '1998-03-09', '1998-04-06', '1998-03-12', 3, 32.01, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany'),
	(10935, 'WELLI', 4, '1998-03-09', '1998-04-06', '1998-03-18', 3, 47.59, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil'),
	(10936, 'GREAL', 3, '1998-03-09', '1998-04-06', '1998-03-18', 2, 33.68, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
	(10937, 'CACTU', 7, '1998-03-10', '1998-03-24', '1998-03-13', 3, 31.51, 'Cactus Comidas para llevar', 'Cerrito 333', 'Buenos Aires', NULL, '1010', 'Argentina'),
	(10938, 'QUICK', 3, '1998-03-10', '1998-04-07', '1998-03-16', 2, 31.89, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10939, 'MAGAA', 2, '1998-03-10', '1998-04-07', '1998-03-13', 2, 76.33, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy'),
	(10940, 'BONAP', 8, '1998-03-11', '1998-04-08', '1998-03-23', 3, 19.77, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(10941, 'SAVEA', 7, '1998-03-11', '1998-04-08', '1998-03-20', 2, 400.81, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10942, 'REGGC', 9, '1998-03-11', '1998-04-08', '1998-03-18', 3, 17.95, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy'),
	(10943, 'BSBEV', 4, '1998-03-11', '1998-04-08', '1998-03-19', 2, 2.17, 'B''s Beverages', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK'),
	(10944, 'BOTTM', 6, '1998-03-12', '1998-03-26', '1998-03-13', 3, 52.92, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
	(10945, 'MORGK', 4, '1998-03-12', '1998-04-09', '1998-03-18', 1, 10.22, 'Morgenstern Gesundkost', 'Heerstr. 22', 'Leipzig', NULL, '04179', 'Germany'),
	(10946, 'VAFFE', 1, '1998-03-12', '1998-04-09', '1998-03-19', 2, 27.2, 'Vaffeljernet', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark'),
	(10947, 'BSBEV', 3, '1998-03-13', '1998-04-10', '1998-03-16', 2, 3.26, 'B''s Beverages', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK'),
	(10948, 'GODOS', 3, '1998-03-13', '1998-04-10', '1998-03-19', 3, 23.39, 'Godos Cocina Típica', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain'),
	(10949, 'BOTTM', 2, '1998-03-13', '1998-04-10', '1998-03-17', 3, 74.44, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
	(10950, 'MAGAA', 1, '1998-03-16', '1998-04-13', '1998-03-23', 2, 2.5, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 'Bergamo', NULL, '24100', 'Italy'),
	(10951, 'RICSU', 9, '1998-03-16', '1998-04-27', '1998-04-07', 2, 30.85, 'Richter Supermarkt', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland'),
	(10952, 'ALFKI', 1, '1998-03-16', '1998-04-27', '1998-03-24', 1, 40.42, 'Alfred''s Futterkiste', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany'),
	(10953, 'AROUT', 9, '1998-03-16', '1998-03-30', '1998-03-25', 2, 23.72, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
	(10954, 'LINOD', 5, '1998-03-17', '1998-04-28', '1998-03-20', 1, 27.91, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
	(10955, 'FOLKO', 8, '1998-03-17', '1998-04-14', '1998-03-20', 2, 3.26, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10956, 'BLAUS', 6, '1998-03-17', '1998-04-28', '1998-03-20', 2, 44.65, 'Blauer See Delikatessen', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany'),
	(10957, 'HILAA', 8, '1998-03-18', '1998-04-15', '1998-03-27', 3, 105.36, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10958, 'OCEAN', 7, '1998-03-18', '1998-04-15', '1998-03-27', 2, 49.56, 'Océano Atlántico Ltda.', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', NULL, '1010', 'Argentina'),
	(10959, 'GOURL', 6, '1998-03-18', '1998-04-29', '1998-03-23', 2, 4.98, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
	(10960, 'HILAA', 3, '1998-03-19', '1998-04-02', '1998-04-08', 1, 2.08, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10961, 'QUEEN', 8, '1998-03-19', '1998-04-16', '1998-03-30', 1, 104.47, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
	(10962, 'QUICK', 8, '1998-03-19', '1998-04-16', '1998-03-23', 2, 275.79, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10963, 'FURIB', 9, '1998-03-19', '1998-04-16', '1998-03-26', 3, 2.7, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 'Lisboa', NULL, '1675', 'Portugal'),
	(10964, 'SPECD', 3, '1998-03-20', '1998-04-17', '1998-03-24', 2, 87.38, 'Spécialités du monde', '25, rue Lauriston', 'Paris', NULL, '75016', 'France'),
	(10965, 'OLDWO', 6, '1998-03-20', '1998-04-17', '1998-03-30', 3, 144.38, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
	(10966, 'CHOPS', 4, '1998-03-20', '1998-04-17', '1998-04-08', 1, 27.19, 'Chop-suey Chinese', 'Hauptstr. 31', 'Bern', NULL, '3012', 'Switzerland'),
	(10967, 'TOMSP', 2, '1998-03-23', '1998-04-20', '1998-04-02', 2, 62.22, 'Toms Spezialitäten', 'Luisenstr. 48', 'Münster', NULL, '44087', 'Germany'),
	(10968, 'ERNSH', 1, '1998-03-23', '1998-04-20', '1998-04-01', 3, 74.6, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10969, 'COMMI', 1, '1998-03-23', '1998-04-20', '1998-03-30', 2, 0.21, 'Comércio Mineiro', 'Av. dos Lusíadas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil'),
	(10970, 'BOLID', 9, '1998-03-24', '1998-04-07', '1998-04-24', 1, 16.16, 'Bólido Comidas preparadas', 'C/ Araquil, 67', 'Madrid', NULL, '28023', 'Spain'),
	(10971, 'FRANR', 2, '1998-03-24', '1998-04-21', '1998-04-02', 2, 121.82, 'France restauration', '54, rue Royale', 'Nantes', NULL, '44000', 'France'),
	(10972, 'LACOR', 4, '1998-03-24', '1998-04-21', '1998-03-26', 2, 0.02, 'La corne d''abondance', '67, avenue de l''Europe', 'Versailles', NULL, '78000', 'France'),
	(10973, 'LACOR', 6, '1998-03-24', '1998-04-21', '1998-03-27', 2, 15.17, 'La corne d''abondance', '67, avenue de l''Europe', 'Versailles', NULL, '78000', 'France'),
	(10974, 'SPLIR', 3, '1998-03-25', '1998-04-08', '1998-04-03', 3, 12.96, 'Split Rail Beer & Ale', 'P.O. Box 555', 'Lander', 'WY', '82520', 'USA'),
	(10975, 'BOTTM', 1, '1998-03-25', '1998-04-22', '1998-03-27', 3, 32.27, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
	(10976, 'HILAA', 1, '1998-03-25', '1998-05-06', '1998-04-03', 1, 37.97, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(10977, 'FOLKO', 8, '1998-03-26', '1998-04-23', '1998-04-10', 3, 208.5, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10978, 'MAISD', 9, '1998-03-26', '1998-04-23', '1998-04-23', 2, 32.82, 'Maison Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', NULL, 'B-1180', 'Belgium'),
	(10979, 'ERNSH', 8, '1998-03-26', '1998-04-23', '1998-03-31', 2, 353.07, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10980, 'FOLKO', 4, '1998-03-27', '1998-05-08', '1998-04-17', 1, 1.26, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10981, 'HANAR', 1, '1998-03-27', '1998-04-24', '1998-04-02', 2, 193.37, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
	(10982, 'BOTTM', 2, '1998-03-27', '1998-04-24', '1998-04-08', 1, 14.01, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
	(10983, 'SAVEA', 2, '1998-03-27', '1998-04-24', '1998-04-06', 2, 657.54, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10984, 'SAVEA', 1, '1998-03-30', '1998-04-27', '1998-04-03', 3, 211.22, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(10985, 'HUNGO', 2, '1998-03-30', '1998-04-27', '1998-04-02', 1, 91.51, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(10986, 'OCEAN', 8, '1998-03-30', '1998-04-27', '1998-04-21', 2, 217.86, 'Océano Atlántico Ltda.', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', NULL, '1010', 'Argentina'),
	(10987, 'EASTC', 8, '1998-03-31', '1998-04-28', '1998-04-06', 1, 185.48, 'Eastern Connection', '35 King George', 'London', NULL, 'WX3 6FW', 'UK'),
	(10988, 'RATTC', 3, '1998-03-31', '1998-04-28', '1998-04-10', 2, 61.14, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(10989, 'QUEDE', 2, '1998-03-31', '1998-04-28', '1998-04-02', 1, 34.76, 'Que Delícia', 'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil'),
	(10990, 'ERNSH', 2, '1998-04-01', '1998-05-13', '1998-04-07', 3, 117.61, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(10991, 'QUICK', 1, '1998-04-01', '1998-04-29', '1998-04-07', 1, 38.51, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10992, 'THEBI', 1, '1998-04-01', '1998-04-29', '1998-04-03', 3, 4.27, 'The Big Cheese', '89 Jefferson Way Suite 2', 'Portland', 'OR', '97201', 'USA'),
	(10993, 'FOLKO', 7, '1998-04-01', '1998-04-29', '1998-04-10', 3, 8.81, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(10994, 'VAFFE', 2, '1998-04-02', '1998-04-16', '1998-04-09', 3, 65.53, 'Vaffeljernet', 'Smagsloget 45', 'Århus', NULL, '8200', 'Denmark'),
	(10995, 'PERIC', 1, '1998-04-02', '1998-04-30', '1998-04-06', 3, 46, 'Pericles Comidas clásicas', 'Calle Dr. Jorge Cash 321', 'México D.F.', NULL, '05033', 'Mexico'),
	(10996, 'QUICK', 4, '1998-04-02', '1998-04-30', '1998-04-10', 2, 1.12, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(10997, 'LILAS', 8, '1998-04-03', '1998-05-15', '1998-04-13', 2, 73.91, 'LILA-Supermercado', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
	(10998, 'WOLZA', 8, '1998-04-03', '1998-04-17', '1998-04-17', 2, 20.31, 'Wolski Zajazd', 'ul. Filtrowa 68', 'Warszawa', NULL, '01-012', 'Poland'),
	(10999, 'OTTIK', 6, '1998-04-03', '1998-05-01', '1998-04-10', 2, 96.35, 'Ottilies Käseladen', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany'),
	(11000, 'RATTC', 2, '1998-04-06', '1998-05-04', '1998-04-14', 3, 55.12, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA'),
	(11001, 'FOLKO', 2, '1998-04-06', '1998-05-04', '1998-04-14', 2, 197.3, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(11002, 'SAVEA', 4, '1998-04-06', '1998-05-04', '1998-04-16', 1, 141.16, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(11003, 'THECR', 3, '1998-04-06', '1998-05-04', '1998-04-08', 3, 14.91, 'The Cracker Box', '55 Grizzly Peak Rd.', 'Butte', 'MT', '59801', 'USA'),
	(11004, 'MAISD', 3, '1998-04-07', '1998-05-05', '1998-04-20', 1, 44.84, 'Maison Dewey', 'Rue Joseph-Bens 532', 'Bruxelles', NULL, 'B-1180', 'Belgium'),
	(11005, 'WILMK', 2, '1998-04-07', '1998-05-05', '1998-04-10', 1, 0.75, 'Wilman Kala', 'Keskuskatu 45', 'Helsinki', NULL, '21240', 'Finland'),
	(11006, 'GREAL', 3, '1998-04-07', '1998-05-05', '1998-04-15', 2, 25.19, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
	(11007, 'PRINI', 8, '1998-04-08', '1998-05-06', '1998-04-13', 2, 202.24, 'Princesa Isabel Vinhos', 'Estrada da saúde n. 58', 'Lisboa', NULL, '1756', 'Portugal'),
	(11008, 'ERNSH', 7, '1998-04-08', '1998-05-06', NULL, 3, 79.46, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(11009, 'GODOS', 2, '1998-04-08', '1998-05-06', '1998-04-10', 1, 59.11, 'Godos Cocina Típica', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain'),
	(11010, 'REGGC', 2, '1998-04-09', '1998-05-07', '1998-04-21', 2, 28.71, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy'),
	(11011, 'ALFKI', 3, '1998-04-09', '1998-05-07', '1998-04-13', 1, 1.21, 'Alfred''s Futterkiste', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany'),
	(11012, 'FRANK', 1, '1998-04-09', '1998-04-23', '1998-04-17', 3, 242.95, 'Frankenversand', 'Berliner Platz 43', 'München', NULL, '80805', 'Germany'),
	(11013, 'ROMEY', 2, '1998-04-09', '1998-05-07', '1998-04-10', 1, 32.99, 'Romero y tomillo', 'Gran Vía, 1', 'Madrid', NULL, '28001', 'Spain'),
	(11014, 'LINOD', 2, '1998-04-10', '1998-05-08', '1998-04-15', 3, 23.6, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
	(11015, 'SANTG', 2, '1998-04-10', '1998-04-24', '1998-04-20', 2, 4.62, 'Santé Gourmet', 'Erling Skakkes gate 78', 'Stavern', NULL, '4110', 'Norway'),
	(11016, 'AROUT', 9, '1998-04-10', '1998-05-08', '1998-04-13', 2, 33.8, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK'),
	(11017, 'ERNSH', 9, '1998-04-13', '1998-05-11', '1998-04-20', 2, 754.26, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(11018, 'LONEP', 4, '1998-04-13', '1998-05-11', '1998-04-16', 2, 11.65, 'Lonesome Pine Restaurant', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA'),
	(11019, 'RANCH', 6, '1998-04-13', '1998-05-11', NULL, 3, 3.17, 'Rancho grande', 'Av. del Libertador 900', 'Buenos Aires', NULL, '1010', 'Argentina'),
	(11020, 'OTTIK', 2, '1998-04-14', '1998-05-12', '1998-04-16', 2, 43.3, 'Ottilies Käseladen', 'Mehrheimerstr. 369', 'Köln', NULL, '50739', 'Germany'),
	(11021, 'QUICK', 3, '1998-04-14', '1998-05-12', '1998-04-21', 1, 297.18, 'QUICK-Stop', 'Taucherstraße 10', 'Cunewalde', NULL, '01307', 'Germany'),
	(11022, 'HANAR', 9, '1998-04-14', '1998-05-12', '1998-05-04', 2, 6.27, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
	(11023, 'BSBEV', 1, '1998-04-14', '1998-04-28', '1998-04-24', 2, 123.83, 'B''s Beverages', 'Fauntleroy Circus', 'London', NULL, 'EC2 5NT', 'UK'),
	(11024, 'EASTC', 4, '1998-04-15', '1998-05-13', '1998-04-20', 1, 74.36, 'Eastern Connection', '35 King George', 'London', NULL, 'WX3 6FW', 'UK'),
	(11025, 'WARTH', 6, '1998-04-15', '1998-05-13', '1998-04-24', 3, 29.17, 'Wartian Herkku', 'Torikatu 38', 'Oulu', NULL, '90110', 'Finland'),
	(11026, 'FRANS', 4, '1998-04-15', '1998-05-13', '1998-04-28', 1, 47.09, 'Franchi S.p.A.', 'Via Monte Bianco 34', 'Torino', NULL, '10100', 'Italy'),
	(11027, 'BOTTM', 1, '1998-04-16', '1998-05-14', '1998-04-20', 1, 52.52, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
	(11028, 'KOENE', 2, '1998-04-16', '1998-05-14', '1998-04-22', 1, 29.59, 'Königlich Essen', 'Maubelstr. 90', 'Brandenburg', NULL, '14776', 'Germany'),
	(11029, 'CHOPS', 4, '1998-04-16', '1998-05-14', '1998-04-27', 1, 47.84, 'Chop-suey Chinese', 'Hauptstr. 31', 'Bern', NULL, '3012', 'Switzerland'),
	(11030, 'SAVEA', 7, '1998-04-17', '1998-05-15', '1998-04-27', 2, 830.75, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(11031, 'SAVEA', 6, '1998-04-17', '1998-05-15', '1998-04-24', 2, 227.22, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(11032, 'WHITC', 2, '1998-04-17', '1998-05-15', '1998-04-23', 3, 606.19, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
	(11033, 'RICSU', 7, '1998-04-17', '1998-05-15', '1998-04-23', 3, 84.74, 'Richter Supermarkt', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland'),
	(11034, 'OLDWO', 8, '1998-04-20', '1998-06-01', '1998-04-27', 1, 40.32, 'Old World Delicatessen', '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA'),
	(11035, 'SUPRD', 2, '1998-04-20', '1998-05-18', '1998-04-24', 2, 0.17, 'Suprêmes délices', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium'),
	(11036, 'DRACD', 8, '1998-04-20', '1998-05-18', '1998-04-22', 3, 149.47, 'Drachenblut Delikatessen', 'Walserweg 21', 'Aachen', NULL, '52066', 'Germany'),
	(11037, 'GODOS', 7, '1998-04-21', '1998-05-19', '1998-04-27', 1, 3.2, 'Godos Cocina Típica', 'C/ Romero, 33', 'Sevilla', NULL, '41101', 'Spain'),
	(11038, 'SUPRD', 1, '1998-04-21', '1998-05-19', '1998-04-30', 2, 29.59, 'Suprêmes délices', 'Boulevard Tirou, 255', 'Charleroi', NULL, 'B-6000', 'Belgium'),
	(11039, 'LINOD', 1, '1998-04-21', '1998-05-19', NULL, 2, 65, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela'),
	(11040, 'GREAL', 4, '1998-04-22', '1998-05-20', NULL, 3, 18.84, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
	(11041, 'CHOPS', 3, '1998-04-22', '1998-05-20', '1998-04-28', 2, 48.22, 'Chop-suey Chinese', 'Hauptstr. 31', 'Bern', NULL, '3012', 'Switzerland'),
	(11042, 'COMMI', 2, '1998-04-22', '1998-05-06', '1998-05-01', 1, 29.99, 'Comércio Mineiro', 'Av. dos Lusíadas, 23', 'Sao Paulo', 'SP', '05432-043', 'Brazil'),
	(11043, 'SPECD', 5, '1998-04-22', '1998-05-20', '1998-04-29', 2, 8.8, 'Spécialités du monde', '25, rue Lauriston', 'Paris', NULL, '75016', 'France'),
	(11044, 'WOLZA', 4, '1998-04-23', '1998-05-21', '1998-05-01', 1, 8.72, 'Wolski Zajazd', 'ul. Filtrowa 68', 'Warszawa', NULL, '01-012', 'Poland'),
	(11045, 'BOTTM', 6, '1998-04-23', '1998-05-21', NULL, 2, 70.58, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
	(11046, 'WANDK', 8, '1998-04-23', '1998-05-21', '1998-04-24', 2, 71.64, 'Die Wandernde Kuh', 'Adenauerallee 900', 'Stuttgart', NULL, '70563', 'Germany'),
	(11047, 'EASTC', 7, '1998-04-24', '1998-05-22', '1998-05-01', 3, 46.62, 'Eastern Connection', '35 King George', 'London', NULL, 'WX3 6FW', 'UK'),
	(11048, 'BOTTM', 7, '1998-04-24', '1998-05-22', '1998-04-30', 3, 24.12, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada'),
	(11049, 'GOURL', 3, '1998-04-24', '1998-05-22', '1998-05-04', 1, 8.34, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil'),
	(11050, 'FOLKO', 8, '1998-04-27', '1998-05-25', '1998-05-05', 2, 59.41, 'Folk och fä HB', 'Åkergatan 24', 'Bräcke', NULL, 'S-844 67', 'Sweden'),
	(11051, 'LAMAI', 7, '1998-04-27', '1998-05-25', NULL, 3, 2.79, 'La maison d''Asie', '1 rue Alsace-Lorraine', 'Toulouse', NULL, '31000', 'France'),
	(11052, 'HANAR', 3, '1998-04-27', '1998-05-25', '1998-05-01', 1, 67.26, 'Hanari Carnes', 'Rua do Paço, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil'),
	(11053, 'PICCO', 2, '1998-04-27', '1998-05-25', '1998-04-29', 2, 53.05, 'Piccolo und mehr', 'Geislweg 14', 'Salzburg', NULL, '5020', 'Austria'),
	(11054, 'CACTU', 8, '1998-04-28', '1998-05-26', NULL, 1, 0.33, 'Cactus Comidas para llevar', 'Cerrito 333', 'Buenos Aires', NULL, '1010', 'Argentina'),
	(11055, 'HILAA', 7, '1998-04-28', '1998-05-26', '1998-05-05', 2, 120.92, 'HILARION-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristóbal', 'Táchira', '5022', 'Venezuela'),
	(11056, 'EASTC', 8, '1998-04-28', '1998-05-12', '1998-05-01', 2, 278.96, 'Eastern Connection', '35 King George', 'London', NULL, 'WX3 6FW', 'UK'),
	(11057, 'NORTS', 3, '1998-04-29', '1998-05-27', '1998-05-01', 3, 4.13, 'North/South', 'South House 300 Queensbridge', 'London', NULL, 'SW7 1RZ', 'UK'),
	(11058, 'BLAUS', 9, '1998-04-29', '1998-05-27', NULL, 3, 31.14, 'Blauer See Delikatessen', 'Forsterstr. 57', 'Mannheim', NULL, '68306', 'Germany'),
	(11059, 'RICAR', 2, '1998-04-29', '1998-06-10', NULL, 2, 85.8, 'Ricardo Adocicados', 'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil'),
	(11060, 'FRANS', 2, '1998-04-30', '1998-05-28', '1998-05-04', 2, 10.98, 'Franchi S.p.A.', 'Via Monte Bianco 34', 'Torino', NULL, '10100', 'Italy'),
	(11061, 'GREAL', 4, '1998-04-30', '1998-06-11', NULL, 3, 14.01, 'Great Lakes Food Market', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA'),
	(11062, 'REGGC', 4, '1998-04-30', '1998-05-28', NULL, 2, 29.93, 'Reggiani Caseifici', 'Strada Provinciale 124', 'Reggio Emilia', NULL, '42100', 'Italy'),
	(11063, 'HUNGO', 3, '1998-04-30', '1998-05-28', '1998-05-06', 2, 81.73, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 'Cork', 'Co. Cork', NULL, 'Ireland'),
	(11064, 'SAVEA', 1, '1998-05-01', '1998-05-29', '1998-05-04', 1, 30.09, 'Save-a-lot Markets', '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA'),
	(11065, 'LILAS', 8, '1998-05-01', '1998-05-29', NULL, 1, 12.91, 'LILA-Supermercado', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
	(11066, 'WHITC', 7, '1998-05-01', '1998-05-29', '1998-05-04', 2, 44.72, 'White Clover Markets', '1029 - 12th Ave. S.', 'Seattle', 'WA', '98124', 'USA'),
	(11067, 'DRACD', 1, '1998-05-04', '1998-05-18', '1998-05-06', 2, 7.98, 'Drachenblut Delikatessen', 'Walserweg 21', 'Aachen', NULL, '52066', 'Germany'),
	(11068, 'QUEEN', 8, '1998-05-04', '1998-06-01', NULL, 2, 81.75, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 'Sao Paulo', 'SP', '05487-020', 'Brazil'),
	(11069, 'TORTU', 1, '1998-05-04', '1998-06-01', '1998-05-06', 2, 15.67, 'Tortuga Restaurante', 'Avda. Azteca 123', 'México D.F.', NULL, '05033', 'Mexico'),
	(11070, 'LEHMS', 2, '1998-05-05', '1998-06-02', NULL, 1, 136, 'Lehmanns Marktstand', 'Magazinweg 7', 'Frankfurt a.M.', NULL, '60528', 'Germany'),
	(11071, 'LILAS', 1, '1998-05-05', '1998-06-02', NULL, 1, 0.93, 'LILA-Supermercado', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela'),
	(11072, 'ERNSH', 4, '1998-05-05', '1998-06-02', NULL, 2, 258.64, 'Ernst Handel', 'Kirchgasse 6', 'Graz', NULL, '8010', 'Austria'),
	(11073, 'PERIC', 2, '1998-05-05', '1998-06-02', NULL, 2, 24.95, 'Pericles Comidas clásicas', 'Calle Dr. Jorge Cash 321', 'México D.F.', NULL, '05033', 'Mexico'),
	(11074, 'SIMOB', 7, '1998-05-06', '1998-06-03', NULL, 2, 18.44, 'Simons bistro', 'Vinbæltet 34', 'Kobenhavn', NULL, '1734', 'Denmark'),
	(11075, 'RICSU', 8, '1998-05-06', '1998-06-03', NULL, 2, 6.19, 'Richter Supermarkt', 'Starenweg 5', 'Genève', NULL, '1204', 'Switzerland'),
	(11076, 'BONAP', 4, '1998-05-06', '1998-06-03', NULL, 2, 38.28, 'Bon app''', '12, rue des Bouchers', 'Marseille', NULL, '13008', 'France'),
	(11077, 'RATTC', 1, '1998-05-06', '1998-06-03', NULL, 2, 8.53, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO Suppliers VALUES
	(1, 'Exotic Liquids', 'Charlotte Cooper', 'Purchasing Manager', '49 Gilbert St.', 'London', NULL, 'EC1 4SD', 'UK', '(171) 555-2222', NULL, NULL),
	(2, 'New Orleans Cajun Delights', 'Shelley Burke', 'Order Administrator', 'P.O. Box 78934', 'New Orleans', 'LA', '70117', 'USA', '(100) 555-4822', NULL, '#CAJUN.HTM#'),
	(3, 'Grandma Kelly''s Homestead', 'Regina Murphy', 'Sales Representative', '707 Oxford Rd.', 'Ann Arbor', 'MI', '48104', 'USA', '(313) 555-5735', '(313) 555-3349', NULL),
	(4, 'Tokyo Traders', 'Yoshi Nagase', 'Marketing Manager', '9-8 Sekimai Musashino-shi', 'Tokyo', NULL, '100', 'Japan', '(03) 3555-5011', NULL, NULL),
	(5, 'Cooperativa de Quesos ''Las Cabras''', 'Antonio del Valle Saavedra', 'Export Administrator', 'Calle del Rosal 4', 'Oviedo', 'Asturias', '33007', 'Spain', '(98) 598 76 54', NULL, NULL),
	(6, 'Mayumi''s', 'Mayumi Ohno', 'Marketing Representative', '92 Setsuko Chuo-ku', 'Osaka', NULL, '545', 'Japan', '(06) 431-7877', NULL, 'Mayumi''s (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/mayumi.htm#'),
	(7, 'Pavlova, Ltd.', 'Ian Devling', 'Marketing Manager', '74 Rose St. Moonie Ponds', 'Melbourne', 'Victoria', '3058', 'Australia', '(03) 444-2343', '(03) 444-6588', NULL),
	(8, 'Specialty Biscuits, Ltd.', 'Peter Wilson', 'Sales Representative', '29 King''s Way', 'Manchester', NULL, 'M14 GSD', 'UK', '(161) 555-4448', NULL, NULL),
	(9, 'PB Knäckebröd AB', 'Lars Peterson', 'Sales Agent', 'Kaloadagatan 13', 'Göteborg', NULL, 'S-345 67', 'Sweden', '031-987 65 43', '031-987 65 91', NULL),
	(10, 'Refrescos Americanas LTDA', 'Carlos Diaz', 'Marketing Manager', 'Av. das Americanas 12.890', 'Sao Paulo', NULL, '5442', 'Brazil', '(11) 555 4640', NULL, NULL),
	(11, 'Heli Süßwaren GmbH & Co. KG', 'Petra Winkler', 'Sales Manager', 'Tiergartenstraße 5', 'Berlin', NULL, '10785', 'Germany', '(010) 9984510', NULL, NULL),
	(12, 'Plutzer Lebensmittelgroßmärkte AG', 'Martin Bein', 'International Marketing Mgr.', 'Bogenallee 51', 'Frankfurt', NULL, '60439', 'Germany', '(069) 992755', NULL, 'Plutzer (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/plutzer.htm#'),
	(13, 'Nord-Ost-Fisch Handelsgesellschaft mbH', 'Sven Petersen', 'Coordinator Foreign Markets', 'Frahmredder 112a', 'Cuxhaven', NULL, '27478', 'Germany', '(04721) 8713', '(04721) 8714', NULL),
	(14, 'Formaggi Fortini s.r.l.', 'Elio Rossi', 'Sales Representative', 'Viale Dante, 75', 'Ravenna', NULL, '48100', 'Italy', '(0544) 60323', '(0544) 60603', '#FORMAGGI.HTM#'),
	(15, 'Norske Meierier', 'Beate Vileid', 'Marketing Manager', 'Hatlevegen 5', 'Sandvika', NULL, '1320', 'Norway', '(0)2-953010', NULL, NULL),
	(16, 'Bigfoot Breweries', 'Cheryl Saylor', 'Regional Account Rep.', '3400 - 8th Avenue Suite 210', 'Bend', 'OR', '97101', 'USA', '(503) 555-9931', NULL, NULL),
	(17, 'Svensk Sjöföda AB', 'Michael Björn', 'Sales Representative', 'Brovallavägen 231', 'Stockholm', NULL, 'S-123 45', 'Sweden', '08-123 45 67', NULL, NULL),
	(18, 'Aux joyeux ecclésiastiques', 'Guylène Nodier', 'Sales Manager', '203, Rue des Francs-Bourgeois', 'Paris', NULL, '75004', 'France', '(1) 03.83.00.68', '(1) 03.83.00.62', NULL),
	(19, 'New England Seafood Cannery', 'Robb Merchant', 'Wholesale Account Agent', 'Order Processing Dept. 2100 Paul Revere Blvd.', 'Boston', 'MA', '02134', 'USA', '(617) 555-3267', '(617) 555-3389', NULL),
	(20, 'Leka Trading', 'Chandra Leka', 'Owner', '471 Serangoon Loop, Suite #402', 'Singapore', NULL, '0512', 'Singapore', '555-8787', NULL, NULL),
	(21, 'Lyngbysild', 'Niels Petersen', 'Sales Manager', 'Lyngbysild Fiskebakken 10', 'Lyngby', NULL, '2800', 'Denmark', '43844108', '43844115', NULL),
	(22, 'Zaanse Snoepfabriek', 'Dirk Luchte', 'Accounting Manager', 'Verkoop Rijnweg 22', 'Zaandam', NULL, '9999 ZZ', 'Netherlands', '(12345) 1212', '(12345) 1210', NULL),
	(23, 'Karkki Oy', 'Anne Heikkonen', 'Product Manager', 'Valtakatu 12', 'Lappeenranta', NULL, '53120', 'Finland', '(953) 10956', NULL, NULL),
	(24, 'G''day, Mate', 'Wendy Mackenzie', 'Sales Representative', '170 Prince Edward Parade Hunter''s Hill', 'Sydney', 'NSW', '2042', 'Australia', '(02) 555-5914', '(02) 555-4873', 'G''day Mate (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/gdaymate.htm#'),
	(25, 'Ma Maison', 'Jean-Guy Lauzon', 'Marketing Manager', '2960 Rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada', '(514) 555-9022', NULL, NULL),
	(26, 'Pasta Buttini s.r.l.', 'Giovanni Giudici', 'Order Administrator', 'Via dei Gelsomini, 153', 'Salerno', NULL, '84100', 'Italy', '(089) 6547665', '(089) 6547667', NULL),
	(27, 'Escargots Nouveaux', 'Marie Delamare', 'Sales Manager', '22, rue H. Voiron', 'Montceau', NULL, '71300', 'France', '85.57.00.07', NULL, NULL),
	(28, 'Gai pâturage', 'Eliane Noz', 'Sales Representative', 'Bat. B 3, rue des Alpes', 'Annecy', NULL, '74000', 'France', '38.76.98.06', '38.76.98.58', NULL),
	(29, 'Forêts d''érables', 'Chantal Goulet', 'Accounting Manager', '148 rue Chasseur', 'Ste-Hyacinthe', 'Québec', 'J2S 7S8', 'Canada', '(514) 555-2955', '(514) 555-2921', NULL);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO Products VALUES
	(1, 'Chai', 8, 1, '10 boxes x 30 bags', 18, 39, 0, 10, 1),
	(2, 'Chang', 1, 1, '24 - 12 oz bottles', 19, 17, 40, 25, 1),
	(3, 'Aniseed Syrup', 1, 2, '12 - 550 ml bottles', 10, 13, 70, 25, 0),
	(4, 'Chef Anton''s Cajun Seasoning', 2, 2, '48 - 6 oz jars', 22, 53, 0, 0, 0),
	(5, 'Chef Anton''s Gumbo Mix', 2, 2, '36 boxes', 21.35, 0, 0, 0, 1),
	(6, 'Grandma''s Boysenberry Spread', 3, 2, '12 - 8 oz jars', 25, 120, 0, 25, 0),
	(7, 'Uncle Bob''s Organic Dried Pears', 3, 7, '12 - 1 lb pkgs.', 30, 15, 0, 10, 0),
	(8, 'Northwoods Cranberry Sauce', 3, 2, '12 - 12 oz jars', 40, 6, 0, 0, 0),
	(9, 'Mishi Kobe Niku', 4, 6, '18 - 500 g pkgs.', 97, 29, 0, 0, 1),
	(10, 'Ikura', 4, 8, '12 - 200 ml jars', 31, 31, 0, 0, 0),
	(11, 'Queso Cabrales', 5, 4, '1 kg pkg.', 21, 22, 30, 30, 0),
	(12, 'Queso Manchego La Pastora', 5, 4, '10 - 500 g pkgs.', 38, 86, 0, 0, 0),
	(13, 'Konbu', 6, 8, '2 kg box', 6, 24, 0, 5, 0),
	(14, 'Tofu', 6, 7, '40 - 100 g pkgs.', 23.25, 35, 0, 0, 0),
	(15, 'Genen Shouyu', 6, 2, '24 - 250 ml bottles', 13, 39, 0, 5, 0),
	(16, 'Pavlova', 7, 3, '32 - 500 g boxes', 17.45, 29, 0, 10, 0),
	(17, 'Alice Mutton', 7, 6, '20 - 1 kg tins', 39, 0, 0, 0, 1),
	(18, 'Carnarvon Tigers', 7, 8, '16 kg pkg.', 62.5, 42, 0, 0, 0),
	(19, 'Teatime Chocolate Biscuits', 8, 3, '10 boxes x 12 pieces', 9.2, 25, 0, 5, 0),
	(20, 'Sir Rodney''s Marmalade', 8, 3, '30 gift boxes', 81, 40, 0, 0, 0),
	(21, 'Sir Rodney''s Scones', 8, 3, '24 pkgs. x 4 pieces', 10, 3, 40, 5, 0),
	(22, 'Gustaf''s Knäckebröd', 9, 5, '24 - 500 g pkgs.', 21, 104, 0, 25, 0),
	(23, 'Tunnbröd', 9, 5, '12 - 250 g pkgs.', 9, 61, 0, 25, 0),
	(24, 'Guaraná Fantástica', 10, 1, '12 - 355 ml cans', 4.5, 20, 0, 0, 1),
	(25, 'NuNuCa Nuß-Nougat-Creme', 11, 3, '20 - 450 g glasses', 14, 76, 0, 30, 0),
	(26, 'Gumbär Gummibärchen', 11, 3, '100 - 250 g bags', 31.23, 15, 0, 0, 0),
	(27, 'Schoggi Schokolade', 11, 3, '100 - 100 g pieces', 43.9, 49, 0, 30, 0),
	(28, 'Rössle Sauerkraut', 12, 7, '25 - 825 g cans', 45.6, 26, 0, 0, 1),
	(29, 'Thüringer Rostbratwurst', 12, 6, '50 bags x 30 sausgs.', 123.79, 0, 0, 0, 1),
	(30, 'Nord-Ost Matjeshering', 13, 8, '10 - 200 g glasses', 25.89, 10, 0, 15, 0),
	(31, 'Gorgonzola Telino', 14, 4, '12 - 100 g pkgs', 12.5, 0, 70, 20, 0),
	(32, 'Mascarpone Fabioli', 14, 4, '24 - 200 g pkgs.', 32, 9, 40, 25, 0),
	(33, 'Geitost', 15, 4, '500 g', 2.5, 112, 0, 20, 0),
	(34, 'Sasquatch Ale', 16, 1, '24 - 12 oz bottles', 14, 111, 0, 15, 0),
	(35, 'Steeleye Stout', 16, 1, '24 - 12 oz bottles', 18, 20, 0, 15, 0),
	(36, 'Inlagd Sill', 17, 8, '24 - 250 g  jars', 19, 112, 0, 20, 0),
	(37, 'Gravad lax', 17, 8, '12 - 500 g pkgs.', 26, 11, 50, 25, 0),
	(38, 'Côte de Blaye', 18, 1, '12 - 75 cl bottles', 263.5, 17, 0, 15, 0),
	(39, 'Chartreuse verte', 18, 1, '750 cc per bottle', 18, 69, 0, 5, 0),
	(40, 'Boston Crab Meat', 19, 8, '24 - 4 oz tins', 18.4, 123, 0, 30, 0),
	(41, 'Jack''s New England Clam Chowder', 19, 8, '12 - 12 oz cans', 9.65, 85, 0, 10, 0),
	(42, 'Singaporean Hokkien Fried Mee', 20, 5, '32 - 1 kg pkgs.', 14, 26, 0, 0, 1),
	(43, 'Ipoh Coffee', 20, 1, '16 - 500 g tins', 46, 17, 10, 25, 0),
	(44, 'Gula Malacca', 20, 2, '20 - 2 kg bags', 19.45, 27, 0, 15, 0),
	(45, 'Rogede sild', 21, 8, '1k pkg.', 9.5, 5, 70, 15, 0),
	(46, 'Spegesild', 21, 8, '4 - 450 g glasses', 12, 95, 0, 0, 0),
	(47, 'Zaanse koeken', 22, 3, '10 - 4 oz boxes', 9.5, 36, 0, 0, 0),
	(48, 'Chocolade', 22, 3, '10 pkgs.', 12.75, 15, 70, 25, 0),
	(49, 'Maxilaku', 23, 3, '24 - 50 g pkgs.', 20, 10, 60, 15, 0),
	(50, 'Valkoinen suklaa', 23, 3, '12 - 100 g bars', 16.25, 65, 0, 30, 0),
	(51, 'Manjimup Dried Apples', 24, 7, '50 - 300 g pkgs.', 53, 20, 0, 10, 0),
	(52, 'Filo Mix', 24, 5, '16 - 2 kg boxes', 7, 38, 0, 25, 0),
	(53, 'Perth Pasties', 24, 6, '48 pieces', 32.8, 0, 0, 0, 1),
	(54, 'Tourtière', 25, 6, '16 pies', 7.45, 21, 0, 10, 0),
	(55, 'Pâté chinois', 25, 6, '24 boxes x 2 pies', 24, 115, 0, 20, 0),
	(56, 'Gnocchi di nonna Alice', 26, 5, '24 - 250 g pkgs.', 38, 21, 10, 30, 0),
	(57, 'Ravioli Angelo', 26, 5, '24 - 250 g pkgs.', 19.5, 36, 0, 20, 0),
	(58, 'Escargots de Bourgogne', 27, 8, '24 pieces', 13.25, 62, 0, 20, 0),
	(59, 'Raclette Courdavault', 28, 4, '5 kg pkg.', 55, 79, 0, 0, 0),
	(60, 'Camembert Pierrot', 28, 4, '15 - 300 g rounds', 34, 19, 0, 0, 0),
	(61, 'Sirop d''érable', 29, 2, '24 - 500 ml bottles', 28.5, 113, 0, 25, 0),
	(62, 'Tarte au sucre', 29, 3, '48 pies', 49.3, 17, 0, 0, 0),
	(63, 'Vegie-spread', 7, 2, '15 - 625 g jars', 43.9, 24, 0, 5, 0),
	(64, 'Wimmers gute Semmelknödel', 12, 5, '20 bags x 4 pieces', 33.25, 22, 80, 30, 0),
	(65, 'Louisiana Fiery Hot Pepper Sauce', 2, 2, '32 - 8 oz bottles', 21.05, 76, 0, 0, 0),
	(66, 'Louisiana Hot Spiced Okra', 2, 2, '24 - 8 oz jars', 17, 4, 100, 20, 0),
	(67, 'Laughing Lumberjack Lager', 16, 1, '24 - 12 oz bottles', 14, 52, 0, 10, 0),
	(68, 'Scottish Longbreads', 8, 3, '10 boxes x 8 pieces', 12.5, 6, 10, 15, 0),
	(69, 'Gudbrandsdalsost', 15, 4, '10 kg pkg.', 36, 26, 0, 15, 0),
	(70, 'Outback Lager', 7, 1, '24 - 355 ml bottles', 15, 15, 10, 30, 0),
	(71, 'Flotemysost', 15, 4, '10 - 500 g pkgs.', 21.5, 26, 0, 0, 0),
	(72, 'Mozzarella di Giovanni', 14, 4, '24 - 200 g pkgs.', 34.8, 14, 0, 0, 0),
	(73, 'Röd Kaviar', 17, 8, '24 - 150 g jars', 15, 101, 0, 5, 0),
	(74, 'Longlife Tofu', 4, 7, '5 kg pkg.', 10, 4, 20, 5, 0),
	(75, 'Rhönbräu Klosterbier', 12, 1, '24 - 0.5 l bottles', 7.75, 125, 0, 25, 0),
	(76, 'Lakkalikööri', 23, 1, '500 ml', 18, 57, 0, 20, 0),
	(77, 'Original Frankfurter grüne Soße', 12, 2, '12 boxes', 13, 32, 0, 15, 0);


--
-- Data for Name: order_details; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO Order_Details VALUES
	(10248, 11, 14, 12, 0),
	(10248, 42, 9.8, 10, 0),
	(10248, 72, 34.8, 5, 0),
	(10249, 14, 18.6, 9, 0),
	(10249, 51, 42.4, 40, 0),
	(10250, 41, 7.7, 10, 0),
	(10250, 51, 42.4, 35, 0.15),
	(10250, 65, 16.8, 15, 0.15),
	(10251, 22, 16.8, 6, 0.05),
	(10251, 57, 15.6, 15, 0.05),
	(10251, 65, 16.8, 20, 0),
	(10252, 20, 64.8, 40, 0.05),
	(10252, 33, 2, 25, 0.05),
	(10252, 60, 27.2, 40, 0),
	(10253, 31, 10, 20, 0),
	(10253, 39, 14.4, 42, 0),
	(10253, 49, 16, 40, 0),
	(10254, 24, 3.6, 15, 0.15),
	(10254, 55, 19.2, 21, 0.15),
	(10254, 74, 8, 21, 0),
	(10255, 2, 15.2, 20, 0),
	(10255, 16, 13.9, 35, 0),
	(10255, 36, 15.2, 25, 0),
	(10255, 59, 44, 30, 0),
	(10256, 53, 26.2, 15, 0),
	(10256, 77, 10.4, 12, 0),
	(10257, 27, 35.1, 25, 0),
	(10257, 39, 14.4, 6, 0),
	(10257, 77, 10.4, 15, 0),
	(10258, 2, 15.2, 50, 0.2),
	(10258, 5, 17, 65, 0.2),
	(10258, 32, 25.6, 6, 0.2),
	(10259, 21, 8, 10, 0),
	(10259, 37, 20.8, 1, 0),
	(10260, 41, 7.7, 16, 0.25),
	(10260, 57, 15.6, 50, 0),
	(10260, 62, 39.4, 15, 0.25),
	(10260, 70, 12, 21, 0.25),
	(10261, 21, 8, 20, 0),
	(10261, 35, 14.4, 20, 0),
	(10262, 5, 17, 12, 0.2),
	(10262, 7, 24, 15, 0),
	(10262, 56, 30.4, 2, 0),
	(10263, 16, 13.9, 60, 0.25),
	(10263, 24, 3.6, 28, 0),
	(10263, 30, 20.7, 60, 0.25),
	(10263, 74, 8, 36, 0.25),
	(10264, 2, 15.2, 35, 0),
	(10264, 41, 7.7, 25, 0.15),
	(10265, 17, 31.2, 30, 0),
	(10265, 70, 12, 20, 0),
	(10266, 12, 30.4, 12, 0.05),
	(10267, 40, 14.7, 50, 0),
	(10267, 59, 44, 70, 0.15),
	(10267, 76, 14.4, 15, 0.15),
	(10268, 29, 99, 10, 0),
	(10268, 72, 27.8, 4, 0),
	(10269, 33, 2, 60, 0.05),
	(10269, 72, 27.8, 20, 0.05),
	(10270, 36, 15.2, 30, 0),
	(10270, 43, 36.8, 25, 0),
	(10271, 33, 2, 24, 0),
	(10272, 20, 64.8, 6, 0),
	(10272, 31, 10, 40, 0),
	(10272, 72, 27.8, 24, 0),
	(10273, 10, 24.8, 24, 0.05),
	(10273, 31, 10, 15, 0.05),
	(10273, 33, 2, 20, 0),
	(10273, 40, 14.7, 60, 0.05),
	(10273, 76, 14.4, 33, 0.05),
	(10274, 71, 17.2, 20, 0),
	(10274, 72, 27.8, 7, 0),
	(10275, 24, 3.6, 12, 0.05),
	(10275, 59, 44, 6, 0.05),
	(10276, 10, 24.8, 15, 0),
	(10276, 13, 4.8, 10, 0),
	(10277, 28, 36.4, 20, 0),
	(10277, 62, 39.4, 12, 0),
	(10278, 44, 15.5, 16, 0),
	(10278, 59, 44, 15, 0),
	(10278, 63, 35.1, 8, 0),
	(10278, 73, 12, 25, 0),
	(10279, 17, 31.2, 15, 0.25),
	(10280, 24, 3.6, 12, 0),
	(10280, 55, 19.2, 20, 0),
	(10280, 75, 6.2, 30, 0),
	(10281, 19, 7.3, 1, 0),
	(10281, 24, 3.6, 6, 0),
	(10281, 35, 14.4, 4, 0),
	(10282, 30, 20.7, 6, 0),
	(10282, 57, 15.6, 2, 0),
	(10283, 15, 12.4, 20, 0),
	(10283, 19, 7.3, 18, 0),
	(10283, 60, 27.2, 35, 0),
	(10283, 72, 27.8, 3, 0),
	(10284, 27, 35.1, 15, 0.25),
	(10284, 44, 15.5, 21, 0),
	(10284, 60, 27.2, 20, 0.25),
	(10284, 67, 11.2, 5, 0.25),
	(10285, 1, 14.4, 45, 0.2),
	(10285, 40, 14.7, 40, 0.2),
	(10285, 53, 26.2, 36, 0.2),
	(10286, 35, 14.4, 100, 0),
	(10286, 62, 39.4, 40, 0),
	(10287, 16, 13.9, 40, 0.15),
	(10287, 34, 11.2, 20, 0),
	(10287, 46, 9.6, 15, 0.15),
	(10288, 54, 5.9, 10, 0.1),
	(10288, 68, 10, 3, 0.1),
	(10289, 3, 8, 30, 0),
	(10289, 64, 26.6, 9, 0),
	(10290, 5, 17, 20, 0),
	(10290, 29, 99, 15, 0),
	(10290, 49, 16, 15, 0),
	(10290, 77, 10.4, 10, 0),
	(10291, 13, 4.8, 20, 0.1),
	(10291, 44, 15.5, 24, 0.1),
	(10291, 51, 42.4, 2, 0.1),
	(10292, 20, 64.8, 20, 0),
	(10293, 18, 50, 12, 0),
	(10293, 24, 3.6, 10, 0),
	(10293, 63, 35.1, 5, 0),
	(10293, 75, 6.2, 6, 0),
	(10294, 1, 14.4, 18, 0),
	(10294, 17, 31.2, 15, 0),
	(10294, 43, 36.8, 15, 0),
	(10294, 60, 27.2, 21, 0),
	(10294, 75, 6.2, 6, 0),
	(10295, 56, 30.4, 4, 0),
	(10296, 11, 16.8, 12, 0),
	(10296, 16, 13.9, 30, 0),
	(10296, 69, 28.8, 15, 0),
	(10297, 39, 14.4, 60, 0),
	(10297, 72, 27.8, 20, 0),
	(10298, 2, 15.2, 40, 0),
	(10298, 36, 15.2, 40, 0.25),
	(10298, 59, 44, 30, 0.25),
	(10298, 62, 39.4, 15, 0),
	(10299, 19, 7.3, 15, 0),
	(10299, 70, 12, 20, 0),
	(10300, 66, 13.6, 30, 0),
	(10300, 68, 10, 20, 0),
	(10301, 40, 14.7, 10, 0),
	(10301, 56, 30.4, 20, 0),
	(10302, 17, 31.2, 40, 0),
	(10302, 28, 36.4, 28, 0),
	(10302, 43, 36.8, 12, 0),
	(10303, 40, 14.7, 40, 0.1),
	(10303, 65, 16.8, 30, 0.1),
	(10303, 68, 10, 15, 0.1),
	(10304, 49, 16, 30, 0),
	(10304, 59, 44, 10, 0),
	(10304, 71, 17.2, 2, 0),
	(10305, 18, 50, 25, 0.1),
	(10305, 29, 99, 25, 0.1),
	(10305, 39, 14.4, 30, 0.1),
	(10306, 30, 20.7, 10, 0),
	(10306, 53, 26.2, 10, 0),
	(10306, 54, 5.9, 5, 0),
	(10307, 62, 39.4, 10, 0),
	(10307, 68, 10, 3, 0),
	(10308, 69, 28.8, 1, 0),
	(10308, 70, 12, 5, 0),
	(10309, 4, 17.6, 20, 0),
	(10309, 6, 20, 30, 0),
	(10309, 42, 11.2, 2, 0),
	(10309, 43, 36.8, 20, 0),
	(10309, 71, 17.2, 3, 0),
	(10310, 16, 13.9, 10, 0),
	(10310, 62, 39.4, 5, 0),
	(10311, 42, 11.2, 6, 0),
	(10311, 69, 28.8, 7, 0),
	(10312, 28, 36.4, 4, 0),
	(10312, 43, 36.8, 24, 0),
	(10312, 53, 26.2, 20, 0),
	(10312, 75, 6.2, 10, 0),
	(10313, 36, 15.2, 12, 0),
	(10314, 32, 25.6, 40, 0.1),
	(10314, 58, 10.6, 30, 0.1),
	(10314, 62, 39.4, 25, 0.1),
	(10315, 34, 11.2, 14, 0),
	(10315, 70, 12, 30, 0),
	(10316, 41, 7.7, 10, 0),
	(10316, 62, 39.4, 70, 0),
	(10317, 1, 14.4, 20, 0),
	(10318, 41, 7.7, 20, 0),
	(10318, 76, 14.4, 6, 0),
	(10319, 17, 31.2, 8, 0),
	(10319, 28, 36.4, 14, 0),
	(10319, 76, 14.4, 30, 0),
	(10320, 71, 17.2, 30, 0),
	(10321, 35, 14.4, 10, 0),
	(10322, 52, 5.6, 20, 0),
	(10323, 15, 12.4, 5, 0),
	(10323, 25, 11.2, 4, 0),
	(10323, 39, 14.4, 4, 0),
	(10324, 16, 13.9, 21, 0.15),
	(10324, 35, 14.4, 70, 0.15),
	(10324, 46, 9.6, 30, 0),
	(10324, 59, 44, 40, 0.15),
	(10324, 63, 35.1, 80, 0.15),
	(10325, 6, 20, 6, 0),
	(10325, 13, 4.8, 12, 0),
	(10325, 14, 18.6, 9, 0),
	(10325, 31, 10, 4, 0),
	(10325, 72, 27.8, 40, 0),
	(10326, 4, 17.6, 24, 0),
	(10326, 57, 15.6, 16, 0),
	(10326, 75, 6.2, 50, 0),
	(10327, 2, 15.2, 25, 0.2),
	(10327, 11, 16.8, 50, 0.2),
	(10327, 30, 20.7, 35, 0.2),
	(10327, 58, 10.6, 30, 0.2),
	(10328, 59, 44, 9, 0),
	(10328, 65, 16.8, 40, 0),
	(10328, 68, 10, 10, 0),
	(10329, 19, 7.3, 10, 0.05),
	(10329, 30, 20.7, 8, 0.05),
	(10329, 38, 210.8, 20, 0.05),
	(10329, 56, 30.4, 12, 0.05),
	(10330, 26, 24.9, 50, 0.15),
	(10330, 72, 27.8, 25, 0.15),
	(10331, 54, 5.9, 15, 0),
	(10332, 18, 50, 40, 0.2),
	(10332, 42, 11.2, 10, 0.2),
	(10332, 47, 7.6, 16, 0.2),
	(10333, 14, 18.6, 10, 0),
	(10333, 21, 8, 10, 0.1),
	(10333, 71, 17.2, 40, 0.1),
	(10334, 52, 5.6, 8, 0),
	(10334, 68, 10, 10, 0),
	(10335, 2, 15.2, 7, 0.2),
	(10335, 31, 10, 25, 0.2),
	(10335, 32, 25.6, 6, 0.2),
	(10335, 51, 42.4, 48, 0.2),
	(10336, 4, 17.6, 18, 0.1),
	(10337, 23, 7.2, 40, 0),
	(10337, 26, 24.9, 24, 0),
	(10337, 36, 15.2, 20, 0),
	(10337, 37, 20.8, 28, 0),
	(10337, 72, 27.8, 25, 0),
	(10338, 17, 31.2, 20, 0),
	(10338, 30, 20.7, 15, 0),
	(10339, 4, 17.6, 10, 0),
	(10339, 17, 31.2, 70, 0.05),
	(10339, 62, 39.4, 28, 0),
	(10340, 18, 50, 20, 0.05),
	(10340, 41, 7.7, 12, 0.05),
	(10340, 43, 36.8, 40, 0.05),
	(10341, 33, 2, 8, 0),
	(10341, 59, 44, 9, 0.15),
	(10342, 2, 15.2, 24, 0.2),
	(10342, 31, 10, 56, 0.2),
	(10342, 36, 15.2, 40, 0.2),
	(10342, 55, 19.2, 40, 0.2),
	(10343, 64, 26.6, 50, 0),
	(10343, 68, 10, 4, 0.05),
	(10343, 76, 14.4, 15, 0),
	(10344, 4, 17.6, 35, 0),
	(10344, 8, 32, 70, 0.25),
	(10345, 8, 32, 70, 0),
	(10345, 19, 7.3, 80, 0),
	(10345, 42, 11.2, 9, 0),
	(10346, 17, 31.2, 36, 0.1),
	(10346, 56, 30.4, 20, 0),
	(10347, 25, 11.2, 10, 0),
	(10347, 39, 14.4, 50, 0.15),
	(10347, 40, 14.7, 4, 0),
	(10347, 75, 6.2, 6, 0.15),
	(10348, 1, 14.4, 15, 0.15),
	(10348, 23, 7.2, 25, 0),
	(10349, 54, 5.9, 24, 0),
	(10350, 50, 13, 15, 0.1),
	(10350, 69, 28.8, 18, 0.1),
	(10351, 38, 210.8, 20, 0.05),
	(10351, 41, 7.7, 13, 0),
	(10351, 44, 15.5, 77, 0.05),
	(10351, 65, 16.8, 10, 0.05),
	(10352, 24, 3.6, 10, 0),
	(10352, 54, 5.9, 20, 0.15),
	(10353, 11, 16.8, 12, 0.2),
	(10353, 38, 210.8, 50, 0.2),
	(10354, 1, 14.4, 12, 0),
	(10354, 29, 99, 4, 0),
	(10355, 24, 3.6, 25, 0),
	(10355, 57, 15.6, 25, 0),
	(10356, 31, 10, 30, 0),
	(10356, 55, 19.2, 12, 0),
	(10356, 69, 28.8, 20, 0),
	(10357, 10, 24.8, 30, 0.2),
	(10357, 26, 24.9, 16, 0),
	(10357, 60, 27.2, 8, 0.2),
	(10358, 24, 3.6, 10, 0.05),
	(10358, 34, 11.2, 10, 0.05),
	(10358, 36, 15.2, 20, 0.05),
	(10359, 16, 13.9, 56, 0.05),
	(10359, 31, 10, 70, 0.05),
	(10359, 60, 27.2, 80, 0.05),
	(10360, 28, 36.4, 30, 0),
	(10360, 29, 99, 35, 0),
	(10360, 38, 210.8, 10, 0),
	(10360, 49, 16, 35, 0),
	(10360, 54, 5.9, 28, 0),
	(10361, 39, 14.4, 54, 0.1),
	(10361, 60, 27.2, 55, 0.1),
	(10362, 25, 11.2, 50, 0),
	(10362, 51, 42.4, 20, 0),
	(10362, 54, 5.9, 24, 0),
	(10363, 31, 10, 20, 0),
	(10363, 75, 6.2, 12, 0),
	(10363, 76, 14.4, 12, 0),
	(10364, 69, 28.8, 30, 0),
	(10364, 71, 17.2, 5, 0),
	(10365, 11, 16.8, 24, 0),
	(10366, 65, 16.8, 5, 0),
	(10366, 77, 10.4, 5, 0),
	(10367, 34, 11.2, 36, 0),
	(10367, 54, 5.9, 18, 0),
	(10367, 65, 16.8, 15, 0),
	(10367, 77, 10.4, 7, 0),
	(10368, 21, 8, 5, 0.1),
	(10368, 28, 36.4, 13, 0.1),
	(10368, 57, 15.6, 25, 0),
	(10368, 64, 26.6, 35, 0.1),
	(10369, 29, 99, 20, 0),
	(10369, 56, 30.4, 18, 0.25),
	(10370, 1, 14.4, 15, 0.15),
	(10370, 64, 26.6, 30, 0),
	(10370, 74, 8, 20, 0.15),
	(10371, 36, 15.2, 6, 0.2),
	(10372, 20, 64.8, 12, 0.25),
	(10372, 38, 210.8, 40, 0.25),
	(10372, 60, 27.2, 70, 0.25),
	(10372, 72, 27.8, 42, 0.25),
	(10373, 58, 10.6, 80, 0.2),
	(10373, 71, 17.2, 50, 0.2),
	(10374, 31, 10, 30, 0),
	(10374, 58, 10.6, 15, 0),
	(10375, 14, 18.6, 15, 0),
	(10375, 54, 5.9, 10, 0),
	(10376, 31, 10, 42, 0.05),
	(10377, 28, 36.4, 20, 0.15),
	(10377, 39, 14.4, 20, 0.15),
	(10378, 71, 17.2, 6, 0),
	(10379, 41, 7.7, 8, 0.1),
	(10379, 63, 35.1, 16, 0.1),
	(10379, 65, 16.8, 20, 0.1),
	(10380, 30, 20.7, 18, 0.1),
	(10380, 53, 26.2, 20, 0.1),
	(10380, 60, 27.2, 6, 0.1),
	(10380, 70, 12, 30, 0),
	(10381, 74, 8, 14, 0),
	(10382, 5, 17, 32, 0),
	(10382, 18, 50, 9, 0),
	(10382, 29, 99, 14, 0),
	(10382, 33, 2, 60, 0),
	(10382, 74, 8, 50, 0),
	(10383, 13, 4.8, 20, 0),
	(10383, 50, 13, 15, 0),
	(10383, 56, 30.4, 20, 0),
	(10384, 20, 64.8, 28, 0),
	(10384, 60, 27.2, 15, 0),
	(10385, 7, 24, 10, 0.2),
	(10385, 60, 27.2, 20, 0.2),
	(10385, 68, 10, 8, 0.2),
	(10386, 24, 3.6, 15, 0),
	(10386, 34, 11.2, 10, 0),
	(10387, 24, 3.6, 15, 0),
	(10387, 28, 36.4, 6, 0),
	(10387, 59, 44, 12, 0),
	(10387, 71, 17.2, 15, 0),
	(10388, 45, 7.6, 15, 0.2),
	(10388, 52, 5.6, 20, 0.2),
	(10388, 53, 26.2, 40, 0),
	(10389, 10, 24.8, 16, 0),
	(10389, 55, 19.2, 15, 0),
	(10389, 62, 39.4, 20, 0),
	(10389, 70, 12, 30, 0),
	(10390, 31, 10, 60, 0.1),
	(10390, 35, 14.4, 40, 0.1),
	(10390, 46, 9.6, 45, 0),
	(10390, 72, 27.8, 24, 0.1),
	(10391, 13, 4.8, 18, 0),
	(10392, 69, 28.8, 50, 0),
	(10393, 2, 15.2, 25, 0.25),
	(10393, 14, 18.6, 42, 0.25),
	(10393, 25, 11.2, 7, 0.25),
	(10393, 26, 24.9, 70, 0.25),
	(10393, 31, 10, 32, 0),
	(10394, 13, 4.8, 10, 0),
	(10394, 62, 39.4, 10, 0),
	(10395, 46, 9.6, 28, 0.1),
	(10395, 53, 26.2, 70, 0.1),
	(10395, 69, 28.8, 8, 0),
	(10396, 23, 7.2, 40, 0),
	(10396, 71, 17.2, 60, 0),
	(10396, 72, 27.8, 21, 0),
	(10397, 21, 8, 10, 0.15),
	(10397, 51, 42.4, 18, 0.15),
	(10398, 35, 14.4, 30, 0),
	(10398, 55, 19.2, 120, 0.1),
	(10399, 68, 10, 60, 0),
	(10399, 71, 17.2, 30, 0),
	(10399, 76, 14.4, 35, 0),
	(10399, 77, 10.4, 14, 0),
	(10400, 29, 99, 21, 0),
	(10400, 35, 14.4, 35, 0),
	(10400, 49, 16, 30, 0),
	(10401, 30, 20.7, 18, 0),
	(10401, 56, 30.4, 70, 0),
	(10401, 65, 16.8, 20, 0),
	(10401, 71, 17.2, 60, 0),
	(10402, 23, 7.2, 60, 0),
	(10402, 63, 35.1, 65, 0),
	(10403, 16, 13.9, 21, 0.15),
	(10403, 48, 10.2, 70, 0.15),
	(10404, 26, 24.9, 30, 0.05),
	(10404, 42, 11.2, 40, 0.05),
	(10404, 49, 16, 30, 0.05),
	(10405, 3, 8, 50, 0),
	(10406, 1, 14.4, 10, 0),
	(10406, 21, 8, 30, 0.1),
	(10406, 28, 36.4, 42, 0.1),
	(10406, 36, 15.2, 5, 0.1),
	(10406, 40, 14.7, 2, 0.1),
	(10407, 11, 16.8, 30, 0),
	(10407, 69, 28.8, 15, 0),
	(10407, 71, 17.2, 15, 0),
	(10408, 37, 20.8, 10, 0),
	(10408, 54, 5.9, 6, 0),
	(10408, 62, 39.4, 35, 0),
	(10409, 14, 18.6, 12, 0),
	(10409, 21, 8, 12, 0),
	(10410, 33, 2, 49, 0),
	(10410, 59, 44, 16, 0),
	(10411, 41, 7.7, 25, 0.2),
	(10411, 44, 15.5, 40, 0.2),
	(10411, 59, 44, 9, 0.2),
	(10412, 14, 18.6, 20, 0.1),
	(10413, 1, 14.4, 24, 0),
	(10413, 62, 39.4, 40, 0),
	(10413, 76, 14.4, 14, 0),
	(10414, 19, 7.3, 18, 0.05),
	(10414, 33, 2, 50, 0),
	(10415, 17, 31.2, 2, 0),
	(10415, 33, 2, 20, 0),
	(10416, 19, 7.3, 20, 0),
	(10416, 53, 26.2, 10, 0),
	(10416, 57, 15.6, 20, 0),
	(10417, 38, 210.8, 50, 0),
	(10417, 46, 9.6, 2, 0.25),
	(10417, 68, 10, 36, 0.25),
	(10417, 77, 10.4, 35, 0),
	(10418, 2, 15.2, 60, 0),
	(10418, 47, 7.6, 55, 0),
	(10418, 61, 22.8, 16, 0),
	(10418, 74, 8, 15, 0),
	(10419, 60, 27.2, 60, 0.05),
	(10419, 69, 28.8, 20, 0.05),
	(10420, 9, 77.6, 20, 0.1),
	(10420, 13, 4.8, 2, 0.1),
	(10420, 70, 12, 8, 0.1),
	(10420, 73, 12, 20, 0.1),
	(10421, 19, 7.3, 4, 0.15),
	(10421, 26, 24.9, 30, 0),
	(10421, 53, 26.2, 15, 0.15),
	(10421, 77, 10.4, 10, 0.15),
	(10422, 26, 24.9, 2, 0),
	(10423, 31, 10, 14, 0),
	(10423, 59, 44, 20, 0),
	(10424, 35, 14.4, 60, 0.2),
	(10424, 38, 210.8, 49, 0.2),
	(10424, 68, 10, 30, 0.2),
	(10425, 55, 19.2, 10, 0.25),
	(10425, 76, 14.4, 20, 0.25),
	(10426, 56, 30.4, 5, 0),
	(10426, 64, 26.6, 7, 0),
	(10427, 14, 18.6, 35, 0),
	(10428, 46, 9.6, 20, 0),
	(10429, 50, 13, 40, 0),
	(10429, 63, 35.1, 35, 0.25),
	(10430, 17, 31.2, 45, 0.2),
	(10430, 21, 8, 50, 0),
	(10430, 56, 30.4, 30, 0),
	(10430, 59, 44, 70, 0.2),
	(10431, 17, 31.2, 50, 0.25),
	(10431, 40, 14.7, 50, 0.25),
	(10431, 47, 7.6, 30, 0.25),
	(10432, 26, 24.9, 10, 0),
	(10432, 54, 5.9, 40, 0),
	(10433, 56, 30.4, 28, 0),
	(10434, 11, 16.8, 6, 0),
	(10434, 76, 14.4, 18, 0.15),
	(10435, 2, 15.2, 10, 0),
	(10435, 22, 16.8, 12, 0),
	(10435, 72, 27.8, 10, 0),
	(10436, 46, 9.6, 5, 0),
	(10436, 56, 30.4, 40, 0.1),
	(10436, 64, 26.6, 30, 0.1),
	(10436, 75, 6.2, 24, 0.1),
	(10437, 53, 26.2, 15, 0),
	(10438, 19, 7.3, 15, 0.2),
	(10438, 34, 11.2, 20, 0.2),
	(10438, 57, 15.6, 15, 0.2),
	(10439, 12, 30.4, 15, 0),
	(10439, 16, 13.9, 16, 0),
	(10439, 64, 26.6, 6, 0),
	(10439, 74, 8, 30, 0),
	(10440, 2, 15.2, 45, 0.15),
	(10440, 16, 13.9, 49, 0.15),
	(10440, 29, 99, 24, 0.15),
	(10440, 61, 22.8, 90, 0.15),
	(10441, 27, 35.1, 50, 0),
	(10442, 11, 16.8, 30, 0),
	(10442, 54, 5.9, 80, 0),
	(10442, 66, 13.6, 60, 0),
	(10443, 11, 16.8, 6, 0.2),
	(10443, 28, 36.4, 12, 0),
	(10444, 17, 31.2, 10, 0),
	(10444, 26, 24.9, 15, 0),
	(10444, 35, 14.4, 8, 0),
	(10444, 41, 7.7, 30, 0),
	(10445, 39, 14.4, 6, 0),
	(10445, 54, 5.9, 15, 0),
	(10446, 19, 7.3, 12, 0.1),
	(10446, 24, 3.6, 20, 0.1),
	(10446, 31, 10, 3, 0.1),
	(10446, 52, 5.6, 15, 0.1),
	(10447, 19, 7.3, 40, 0),
	(10447, 65, 16.8, 35, 0),
	(10447, 71, 17.2, 2, 0),
	(10448, 26, 24.9, 6, 0),
	(10448, 40, 14.7, 20, 0),
	(10449, 10, 24.8, 14, 0),
	(10449, 52, 5.6, 20, 0),
	(10449, 62, 39.4, 35, 0),
	(10450, 10, 24.8, 20, 0.2),
	(10450, 54, 5.9, 6, 0.2),
	(10451, 55, 19.2, 120, 0.1),
	(10451, 64, 26.6, 35, 0.1),
	(10451, 65, 16.8, 28, 0.1),
	(10451, 77, 10.4, 55, 0.1),
	(10452, 28, 36.4, 15, 0),
	(10452, 44, 15.5, 100, 0.05),
	(10453, 48, 10.2, 15, 0.1),
	(10453, 70, 12, 25, 0.1),
	(10454, 16, 13.9, 20, 0.2),
	(10454, 33, 2, 20, 0.2),
	(10454, 46, 9.6, 10, 0.2),
	(10455, 39, 14.4, 20, 0),
	(10455, 53, 26.2, 50, 0),
	(10455, 61, 22.8, 25, 0),
	(10455, 71, 17.2, 30, 0),
	(10456, 21, 8, 40, 0.15),
	(10456, 49, 16, 21, 0.15),
	(10457, 59, 44, 36, 0),
	(10458, 26, 24.9, 30, 0),
	(10458, 28, 36.4, 30, 0),
	(10458, 43, 36.8, 20, 0),
	(10458, 56, 30.4, 15, 0),
	(10458, 71, 17.2, 50, 0),
	(10459, 7, 24, 16, 0.05),
	(10459, 46, 9.6, 20, 0.05),
	(10459, 72, 27.8, 40, 0),
	(10460, 68, 10, 21, 0.25),
	(10460, 75, 6.2, 4, 0.25),
	(10461, 21, 8, 40, 0.25),
	(10461, 30, 20.7, 28, 0.25),
	(10461, 55, 19.2, 60, 0.25),
	(10462, 13, 4.8, 1, 0),
	(10462, 23, 7.2, 21, 0),
	(10463, 19, 7.3, 21, 0),
	(10463, 42, 11.2, 50, 0),
	(10464, 4, 17.6, 16, 0.2),
	(10464, 43, 36.8, 3, 0),
	(10464, 56, 30.4, 30, 0.2),
	(10464, 60, 27.2, 20, 0),
	(10465, 24, 3.6, 25, 0),
	(10465, 29, 99, 18, 0.1),
	(10465, 40, 14.7, 20, 0),
	(10465, 45, 7.6, 30, 0.1),
	(10465, 50, 13, 25, 0),
	(10466, 11, 16.8, 10, 0),
	(10466, 46, 9.6, 5, 0),
	(10467, 24, 3.6, 28, 0),
	(10467, 25, 11.2, 12, 0),
	(10468, 30, 20.7, 8, 0),
	(10468, 43, 36.8, 15, 0),
	(10469, 2, 15.2, 40, 0.15),
	(10469, 16, 13.9, 35, 0.15),
	(10469, 44, 15.5, 2, 0.15),
	(10470, 18, 50, 30, 0),
	(10470, 23, 7.2, 15, 0),
	(10470, 64, 26.6, 8, 0),
	(10471, 7, 24, 30, 0),
	(10471, 56, 30.4, 20, 0),
	(10472, 24, 3.6, 80, 0.05),
	(10472, 51, 42.4, 18, 0),
	(10473, 33, 2, 12, 0),
	(10473, 71, 17.2, 12, 0),
	(10474, 14, 18.6, 12, 0),
	(10474, 28, 36.4, 18, 0),
	(10474, 40, 14.7, 21, 0),
	(10474, 75, 6.2, 10, 0),
	(10475, 31, 10, 35, 0.15),
	(10475, 66, 13.6, 60, 0.15),
	(10475, 76, 14.4, 42, 0.15),
	(10476, 55, 19.2, 2, 0.05),
	(10476, 70, 12, 12, 0),
	(10477, 1, 14.4, 15, 0),
	(10477, 21, 8, 21, 0.25),
	(10477, 39, 14.4, 20, 0.25),
	(10478, 10, 24.8, 20, 0.05),
	(10479, 38, 210.8, 30, 0),
	(10479, 53, 26.2, 28, 0),
	(10479, 59, 44, 60, 0),
	(10479, 64, 26.6, 30, 0),
	(10480, 47, 7.6, 30, 0),
	(10480, 59, 44, 12, 0),
	(10481, 49, 16, 24, 0),
	(10481, 60, 27.2, 40, 0),
	(10482, 40, 14.7, 10, 0),
	(10483, 34, 11.2, 35, 0.05),
	(10483, 77, 10.4, 30, 0.05),
	(10484, 21, 8, 14, 0),
	(10484, 40, 14.7, 10, 0),
	(10484, 51, 42.4, 3, 0),
	(10485, 2, 15.2, 20, 0.1),
	(10485, 3, 8, 20, 0.1),
	(10485, 55, 19.2, 30, 0.1),
	(10485, 70, 12, 60, 0.1),
	(10486, 11, 16.8, 5, 0),
	(10486, 51, 42.4, 25, 0),
	(10486, 74, 8, 16, 0),
	(10487, 19, 7.3, 5, 0),
	(10487, 26, 24.9, 30, 0),
	(10487, 54, 5.9, 24, 0.25),
	(10488, 59, 44, 30, 0),
	(10488, 73, 12, 20, 0.2),
	(10489, 11, 16.8, 15, 0.25),
	(10489, 16, 13.9, 18, 0),
	(10490, 59, 44, 60, 0),
	(10490, 68, 10, 30, 0),
	(10490, 75, 6.2, 36, 0),
	(10491, 44, 15.5, 15, 0.15),
	(10491, 77, 10.4, 7, 0.15),
	(10492, 25, 11.2, 60, 0.05),
	(10492, 42, 11.2, 20, 0.05),
	(10493, 65, 16.8, 15, 0.1),
	(10493, 66, 13.6, 10, 0.1),
	(10493, 69, 28.8, 10, 0.1),
	(10494, 56, 30.4, 30, 0),
	(10495, 23, 7.2, 10, 0),
	(10495, 41, 7.7, 20, 0),
	(10495, 77, 10.4, 5, 0),
	(10496, 31, 10, 20, 0.05),
	(10497, 56, 30.4, 14, 0),
	(10497, 72, 27.8, 25, 0),
	(10497, 77, 10.4, 25, 0),
	(10498, 24, 4.5, 14, 0),
	(10498, 40, 18.4, 5, 0),
	(10498, 42, 14, 30, 0),
	(10499, 28, 45.6, 20, 0),
	(10499, 49, 20, 25, 0),
	(10500, 15, 15.5, 12, 0.05),
	(10500, 28, 45.6, 8, 0.05),
	(10501, 54, 7.45, 20, 0),
	(10502, 45, 9.5, 21, 0),
	(10502, 53, 32.8, 6, 0),
	(10502, 67, 14, 30, 0),
	(10503, 14, 23.25, 70, 0),
	(10503, 65, 21.05, 20, 0),
	(10504, 2, 19, 12, 0),
	(10504, 21, 10, 12, 0),
	(10504, 53, 32.8, 10, 0),
	(10504, 61, 28.5, 25, 0),
	(10505, 62, 49.3, 3, 0),
	(10506, 25, 14, 18, 0.1),
	(10506, 70, 15, 14, 0.1),
	(10507, 43, 46, 15, 0.15),
	(10507, 48, 12.75, 15, 0.15),
	(10508, 13, 6, 10, 0),
	(10508, 39, 18, 10, 0),
	(10509, 28, 45.6, 3, 0),
	(10510, 29, 123.79, 36, 0),
	(10510, 75, 7.75, 36, 0.1),
	(10511, 4, 22, 50, 0.15),
	(10511, 7, 30, 50, 0.15),
	(10511, 8, 40, 10, 0.15),
	(10512, 24, 4.5, 10, 0.15),
	(10512, 46, 12, 9, 0.15),
	(10512, 47, 9.5, 6, 0.15),
	(10512, 60, 34, 12, 0.15),
	(10513, 21, 10, 40, 0.2),
	(10513, 32, 32, 50, 0.2),
	(10513, 61, 28.5, 15, 0.2),
	(10514, 20, 81, 39, 0),
	(10514, 28, 45.6, 35, 0),
	(10514, 56, 38, 70, 0),
	(10514, 65, 21.05, 39, 0),
	(10514, 75, 7.75, 50, 0),
	(10515, 9, 97, 16, 0.15),
	(10515, 16, 17.45, 50, 0),
	(10515, 27, 43.9, 120, 0),
	(10515, 33, 2.5, 16, 0.15),
	(10515, 60, 34, 84, 0.15),
	(10516, 18, 62.5, 25, 0.1),
	(10516, 41, 9.65, 80, 0.1),
	(10516, 42, 14, 20, 0),
	(10517, 52, 7, 6, 0),
	(10517, 59, 55, 4, 0),
	(10517, 70, 15, 6, 0),
	(10518, 24, 4.5, 5, 0),
	(10518, 38, 263.5, 15, 0),
	(10518, 44, 19.45, 9, 0),
	(10519, 10, 31, 16, 0.05),
	(10519, 56, 38, 40, 0),
	(10519, 60, 34, 10, 0.05),
	(10520, 24, 4.5, 8, 0),
	(10520, 53, 32.8, 5, 0),
	(10521, 35, 18, 3, 0),
	(10521, 41, 9.65, 10, 0),
	(10521, 68, 12.5, 6, 0),
	(10522, 1, 18, 40, 0.2),
	(10522, 8, 40, 24, 0),
	(10522, 30, 25.89, 20, 0.2),
	(10522, 40, 18.4, 25, 0.2),
	(10523, 17, 39, 25, 0.1),
	(10523, 20, 81, 15, 0.1),
	(10523, 37, 26, 18, 0.1),
	(10523, 41, 9.65, 6, 0.1),
	(10524, 10, 31, 2, 0),
	(10524, 30, 25.89, 10, 0),
	(10524, 43, 46, 60, 0),
	(10524, 54, 7.45, 15, 0),
	(10525, 36, 19, 30, 0),
	(10525, 40, 18.4, 15, 0.1),
	(10526, 1, 18, 8, 0.15),
	(10526, 13, 6, 10, 0),
	(10526, 56, 38, 30, 0.15),
	(10527, 4, 22, 50, 0.1),
	(10527, 36, 19, 30, 0.1),
	(10528, 11, 21, 3, 0),
	(10528, 33, 2.5, 8, 0.2),
	(10528, 72, 34.8, 9, 0),
	(10529, 55, 24, 14, 0),
	(10529, 68, 12.5, 20, 0),
	(10529, 69, 36, 10, 0),
	(10530, 17, 39, 40, 0),
	(10530, 43, 46, 25, 0),
	(10530, 61, 28.5, 20, 0),
	(10530, 76, 18, 50, 0),
	(10531, 59, 55, 2, 0),
	(10532, 30, 25.89, 15, 0),
	(10532, 66, 17, 24, 0),
	(10533, 4, 22, 50, 0.05),
	(10533, 72, 34.8, 24, 0),
	(10533, 73, 15, 24, 0.05),
	(10534, 30, 25.89, 10, 0),
	(10534, 40, 18.4, 10, 0.2),
	(10534, 54, 7.45, 10, 0.2),
	(10535, 11, 21, 50, 0.1),
	(10535, 40, 18.4, 10, 0.1),
	(10535, 57, 19.5, 5, 0.1),
	(10535, 59, 55, 15, 0.1),
	(10536, 12, 38, 15, 0.25),
	(10536, 31, 12.5, 20, 0),
	(10536, 33, 2.5, 30, 0),
	(10536, 60, 34, 35, 0.25),
	(10537, 31, 12.5, 30, 0),
	(10537, 51, 53, 6, 0),
	(10537, 58, 13.25, 20, 0),
	(10537, 72, 34.8, 21, 0),
	(10537, 73, 15, 9, 0),
	(10538, 70, 15, 7, 0),
	(10538, 72, 34.8, 1, 0),
	(10539, 13, 6, 8, 0),
	(10539, 21, 10, 15, 0),
	(10539, 33, 2.5, 15, 0),
	(10539, 49, 20, 6, 0),
	(10540, 3, 10, 60, 0),
	(10540, 26, 31.23, 40, 0),
	(10540, 38, 263.5, 30, 0),
	(10540, 68, 12.5, 35, 0),
	(10541, 24, 4.5, 35, 0.1),
	(10541, 38, 263.5, 4, 0.1),
	(10541, 65, 21.05, 36, 0.1),
	(10541, 71, 21.5, 9, 0.1),
	(10542, 11, 21, 15, 0.05),
	(10542, 54, 7.45, 24, 0.05),
	(10543, 12, 38, 30, 0.15),
	(10543, 23, 9, 70, 0.15),
	(10544, 28, 45.6, 7, 0),
	(10544, 67, 14, 7, 0),
	(10545, 11, 21, 10, 0),
	(10546, 7, 30, 10, 0),
	(10546, 35, 18, 30, 0),
	(10546, 62, 49.3, 40, 0),
	(10547, 32, 32, 24, 0.15),
	(10547, 36, 19, 60, 0),
	(10548, 34, 14, 10, 0.25),
	(10548, 41, 9.65, 14, 0),
	(10549, 31, 12.5, 55, 0.15),
	(10549, 45, 9.5, 100, 0.15),
	(10549, 51, 53, 48, 0.15),
	(10550, 17, 39, 8, 0.1),
	(10550, 19, 9.2, 10, 0),
	(10550, 21, 10, 6, 0.1),
	(10550, 61, 28.5, 10, 0.1),
	(10551, 16, 17.45, 40, 0.15),
	(10551, 35, 18, 20, 0.15),
	(10551, 44, 19.45, 40, 0),
	(10552, 69, 36, 18, 0),
	(10552, 75, 7.75, 30, 0),
	(10553, 11, 21, 15, 0),
	(10553, 16, 17.45, 14, 0),
	(10553, 22, 21, 24, 0),
	(10553, 31, 12.5, 30, 0),
	(10553, 35, 18, 6, 0),
	(10554, 16, 17.45, 30, 0.05),
	(10554, 23, 9, 20, 0.05),
	(10554, 62, 49.3, 20, 0.05),
	(10554, 77, 13, 10, 0.05),
	(10555, 14, 23.25, 30, 0.2),
	(10555, 19, 9.2, 35, 0.2),
	(10555, 24, 4.5, 18, 0.2),
	(10555, 51, 53, 20, 0.2),
	(10555, 56, 38, 40, 0.2),
	(10556, 72, 34.8, 24, 0),
	(10557, 64, 33.25, 30, 0),
	(10557, 75, 7.75, 20, 0),
	(10558, 47, 9.5, 25, 0),
	(10558, 51, 53, 20, 0),
	(10558, 52, 7, 30, 0),
	(10558, 53, 32.8, 18, 0),
	(10558, 73, 15, 3, 0),
	(10559, 41, 9.65, 12, 0.05),
	(10559, 55, 24, 18, 0.05),
	(10560, 30, 25.89, 20, 0),
	(10560, 62, 49.3, 15, 0.25),
	(10561, 44, 19.45, 10, 0),
	(10561, 51, 53, 50, 0),
	(10562, 33, 2.5, 20, 0.1),
	(10562, 62, 49.3, 10, 0.1),
	(10563, 36, 19, 25, 0),
	(10563, 52, 7, 70, 0),
	(10564, 17, 39, 16, 0.05),
	(10564, 31, 12.5, 6, 0.05),
	(10564, 55, 24, 25, 0.05),
	(10565, 24, 4.5, 25, 0.1),
	(10565, 64, 33.25, 18, 0.1),
	(10566, 11, 21, 35, 0.15),
	(10566, 18, 62.5, 18, 0.15),
	(10566, 76, 18, 10, 0),
	(10567, 31, 12.5, 60, 0.2),
	(10567, 51, 53, 3, 0),
	(10567, 59, 55, 40, 0.2),
	(10568, 10, 31, 5, 0),
	(10569, 31, 12.5, 35, 0.2),
	(10569, 76, 18, 30, 0),
	(10570, 11, 21, 15, 0.05),
	(10570, 56, 38, 60, 0.05),
	(10571, 14, 23.25, 11, 0.15),
	(10571, 42, 14, 28, 0.15),
	(10572, 16, 17.45, 12, 0.1),
	(10572, 32, 32, 10, 0.1),
	(10572, 40, 18.4, 50, 0),
	(10572, 75, 7.75, 15, 0.1),
	(10573, 17, 39, 18, 0),
	(10573, 34, 14, 40, 0),
	(10573, 53, 32.8, 25, 0),
	(10574, 33, 2.5, 14, 0),
	(10574, 40, 18.4, 2, 0),
	(10574, 62, 49.3, 10, 0),
	(10574, 64, 33.25, 6, 0),
	(10575, 59, 55, 12, 0),
	(10575, 63, 43.9, 6, 0),
	(10575, 72, 34.8, 30, 0),
	(10575, 76, 18, 10, 0),
	(10576, 1, 18, 10, 0),
	(10576, 31, 12.5, 20, 0),
	(10576, 44, 19.45, 21, 0),
	(10577, 39, 18, 10, 0),
	(10577, 75, 7.75, 20, 0),
	(10577, 77, 13, 18, 0),
	(10578, 35, 18, 20, 0),
	(10578, 57, 19.5, 6, 0),
	(10579, 15, 15.5, 10, 0),
	(10579, 75, 7.75, 21, 0),
	(10580, 14, 23.25, 15, 0.05),
	(10580, 41, 9.65, 9, 0.05),
	(10580, 65, 21.05, 30, 0.05),
	(10581, 75, 7.75, 50, 0.2),
	(10582, 57, 19.5, 4, 0),
	(10582, 76, 18, 14, 0),
	(10583, 29, 123.79, 10, 0),
	(10583, 60, 34, 24, 0.15),
	(10583, 69, 36, 10, 0.15),
	(10584, 31, 12.5, 50, 0.05),
	(10585, 47, 9.5, 15, 0),
	(10586, 52, 7, 4, 0.15),
	(10587, 26, 31.23, 6, 0),
	(10587, 35, 18, 20, 0),
	(10587, 77, 13, 20, 0),
	(10588, 18, 62.5, 40, 0.2),
	(10588, 42, 14, 100, 0.2),
	(10589, 35, 18, 4, 0),
	(10590, 1, 18, 20, 0),
	(10590, 77, 13, 60, 0.05),
	(10591, 3, 10, 14, 0),
	(10591, 7, 30, 10, 0),
	(10591, 54, 7.45, 50, 0),
	(10592, 15, 15.5, 25, 0.05),
	(10592, 26, 31.23, 5, 0.05),
	(10593, 20, 81, 21, 0.2),
	(10593, 69, 36, 20, 0.2),
	(10593, 76, 18, 4, 0.2),
	(10594, 52, 7, 24, 0),
	(10594, 58, 13.25, 30, 0),
	(10595, 35, 18, 30, 0.25),
	(10595, 61, 28.5, 120, 0.25),
	(10595, 69, 36, 65, 0.25),
	(10596, 56, 38, 5, 0.2),
	(10596, 63, 43.9, 24, 0.2),
	(10596, 75, 7.75, 30, 0.2),
	(10597, 24, 4.5, 35, 0.2),
	(10597, 57, 19.5, 20, 0),
	(10597, 65, 21.05, 12, 0.2),
	(10598, 27, 43.9, 50, 0),
	(10598, 71, 21.5, 9, 0),
	(10599, 62, 49.3, 10, 0),
	(10600, 54, 7.45, 4, 0),
	(10600, 73, 15, 30, 0),
	(10601, 13, 6, 60, 0),
	(10601, 59, 55, 35, 0),
	(10602, 77, 13, 5, 0.25),
	(10603, 22, 21, 48, 0),
	(10603, 49, 20, 25, 0.05),
	(10604, 48, 12.75, 6, 0.1),
	(10604, 76, 18, 10, 0.1),
	(10605, 16, 17.45, 30, 0.05),
	(10605, 59, 55, 20, 0.05),
	(10605, 60, 34, 70, 0.05),
	(10605, 71, 21.5, 15, 0.05),
	(10606, 4, 22, 20, 0.2),
	(10606, 55, 24, 20, 0.2),
	(10606, 62, 49.3, 10, 0.2),
	(10607, 7, 30, 45, 0),
	(10607, 17, 39, 100, 0),
	(10607, 33, 2.5, 14, 0),
	(10607, 40, 18.4, 42, 0),
	(10607, 72, 34.8, 12, 0),
	(10608, 56, 38, 28, 0),
	(10609, 1, 18, 3, 0),
	(10609, 10, 31, 10, 0),
	(10609, 21, 10, 6, 0),
	(10610, 36, 19, 21, 0.25),
	(10611, 1, 18, 6, 0),
	(10611, 2, 19, 10, 0),
	(10611, 60, 34, 15, 0),
	(10612, 10, 31, 70, 0),
	(10612, 36, 19, 55, 0),
	(10612, 49, 20, 18, 0),
	(10612, 60, 34, 40, 0),
	(10612, 76, 18, 80, 0),
	(10613, 13, 6, 8, 0.1),
	(10613, 75, 7.75, 40, 0),
	(10614, 11, 21, 14, 0),
	(10614, 21, 10, 8, 0),
	(10614, 39, 18, 5, 0),
	(10615, 55, 24, 5, 0),
	(10616, 38, 263.5, 15, 0.05),
	(10616, 56, 38, 14, 0),
	(10616, 70, 15, 15, 0.05),
	(10616, 71, 21.5, 15, 0.05),
	(10617, 59, 55, 30, 0.15),
	(10618, 6, 25, 70, 0),
	(10618, 56, 38, 20, 0),
	(10618, 68, 12.5, 15, 0),
	(10619, 21, 10, 42, 0),
	(10619, 22, 21, 40, 0),
	(10620, 24, 4.5, 5, 0),
	(10620, 52, 7, 5, 0),
	(10621, 19, 9.2, 5, 0),
	(10621, 23, 9, 10, 0),
	(10621, 70, 15, 20, 0),
	(10621, 71, 21.5, 15, 0),
	(10622, 2, 19, 20, 0),
	(10622, 68, 12.5, 18, 0.2),
	(10623, 14, 23.25, 21, 0),
	(10623, 19, 9.2, 15, 0.1),
	(10623, 21, 10, 25, 0.1),
	(10623, 24, 4.5, 3, 0),
	(10623, 35, 18, 30, 0.1),
	(10624, 28, 45.6, 10, 0),
	(10624, 29, 123.79, 6, 0),
	(10624, 44, 19.45, 10, 0),
	(10625, 14, 23.25, 3, 0),
	(10625, 42, 14, 5, 0),
	(10625, 60, 34, 10, 0),
	(10626, 53, 32.8, 12, 0),
	(10626, 60, 34, 20, 0),
	(10626, 71, 21.5, 20, 0),
	(10627, 62, 49.3, 15, 0),
	(10627, 73, 15, 35, 0.15),
	(10628, 1, 18, 25, 0),
	(10629, 29, 123.79, 20, 0),
	(10629, 64, 33.25, 9, 0),
	(10630, 55, 24, 12, 0.05),
	(10630, 76, 18, 35, 0),
	(10631, 75, 7.75, 8, 0.1),
	(10632, 2, 19, 30, 0.05),
	(10632, 33, 2.5, 20, 0.05),
	(10633, 12, 38, 36, 0.15),
	(10633, 13, 6, 13, 0.15),
	(10633, 26, 31.23, 35, 0.15),
	(10633, 62, 49.3, 80, 0.15),
	(10634, 7, 30, 35, 0),
	(10634, 18, 62.5, 50, 0),
	(10634, 51, 53, 15, 0),
	(10634, 75, 7.75, 2, 0),
	(10635, 4, 22, 10, 0.1),
	(10635, 5, 21.35, 15, 0.1),
	(10635, 22, 21, 40, 0),
	(10636, 4, 22, 25, 0),
	(10636, 58, 13.25, 6, 0),
	(10637, 11, 21, 10, 0),
	(10637, 50, 16.25, 25, 0.05),
	(10637, 56, 38, 60, 0.05),
	(10638, 45, 9.5, 20, 0),
	(10638, 65, 21.05, 21, 0),
	(10638, 72, 34.8, 60, 0),
	(10639, 18, 62.5, 8, 0),
	(10640, 69, 36, 20, 0.25),
	(10640, 70, 15, 15, 0.25),
	(10641, 2, 19, 50, 0),
	(10641, 40, 18.4, 60, 0),
	(10642, 21, 10, 30, 0.2),
	(10642, 61, 28.5, 20, 0.2),
	(10643, 28, 45.6, 15, 0.25),
	(10643, 39, 18, 21, 0.25),
	(10643, 46, 12, 2, 0.25),
	(10644, 18, 62.5, 4, 0.1),
	(10644, 43, 46, 20, 0),
	(10644, 46, 12, 21, 0.1),
	(10645, 18, 62.5, 20, 0),
	(10645, 36, 19, 15, 0),
	(10646, 1, 18, 15, 0.25),
	(10646, 10, 31, 18, 0.25),
	(10646, 71, 21.5, 30, 0.25),
	(10646, 77, 13, 35, 0.25),
	(10647, 19, 9.2, 30, 0),
	(10647, 39, 18, 20, 0),
	(10648, 22, 21, 15, 0),
	(10648, 24, 4.5, 15, 0.15),
	(10649, 28, 45.6, 20, 0),
	(10649, 72, 34.8, 15, 0),
	(10650, 30, 25.89, 30, 0),
	(10650, 53, 32.8, 25, 0.05),
	(10650, 54, 7.45, 30, 0),
	(10651, 19, 9.2, 12, 0.25),
	(10651, 22, 21, 20, 0.25),
	(10652, 30, 25.89, 2, 0.25),
	(10652, 42, 14, 20, 0),
	(10653, 16, 17.45, 30, 0.1),
	(10653, 60, 34, 20, 0.1),
	(10654, 4, 22, 12, 0.1),
	(10654, 39, 18, 20, 0.1),
	(10654, 54, 7.45, 6, 0.1),
	(10655, 41, 9.65, 20, 0.2),
	(10656, 14, 23.25, 3, 0.1),
	(10656, 44, 19.45, 28, 0.1),
	(10656, 47, 9.5, 6, 0.1),
	(10657, 15, 15.5, 50, 0),
	(10657, 41, 9.65, 24, 0),
	(10657, 46, 12, 45, 0),
	(10657, 47, 9.5, 10, 0),
	(10657, 56, 38, 45, 0),
	(10657, 60, 34, 30, 0),
	(10658, 21, 10, 60, 0),
	(10658, 40, 18.4, 70, 0.05),
	(10658, 60, 34, 55, 0.05),
	(10658, 77, 13, 70, 0.05),
	(10659, 31, 12.5, 20, 0.05),
	(10659, 40, 18.4, 24, 0.05),
	(10659, 70, 15, 40, 0.05),
	(10660, 20, 81, 21, 0),
	(10661, 39, 18, 3, 0.2),
	(10661, 58, 13.25, 49, 0.2),
	(10662, 68, 12.5, 10, 0),
	(10663, 40, 18.4, 30, 0.05),
	(10663, 42, 14, 30, 0.05),
	(10663, 51, 53, 20, 0.05),
	(10664, 10, 31, 24, 0.15),
	(10664, 56, 38, 12, 0.15),
	(10664, 65, 21.05, 15, 0.15),
	(10665, 51, 53, 20, 0),
	(10665, 59, 55, 1, 0),
	(10665, 76, 18, 10, 0),
	(10666, 29, 123.79, 36, 0),
	(10666, 65, 21.05, 10, 0),
	(10667, 69, 36, 45, 0.2),
	(10667, 71, 21.5, 14, 0.2),
	(10668, 31, 12.5, 8, 0.1),
	(10668, 55, 24, 4, 0.1),
	(10668, 64, 33.25, 15, 0.1),
	(10669, 36, 19, 30, 0),
	(10670, 23, 9, 32, 0),
	(10670, 46, 12, 60, 0),
	(10670, 67, 14, 25, 0),
	(10670, 73, 15, 50, 0),
	(10670, 75, 7.75, 25, 0),
	(10671, 16, 17.45, 10, 0),
	(10671, 62, 49.3, 10, 0),
	(10671, 65, 21.05, 12, 0),
	(10672, 38, 263.5, 15, 0.1),
	(10672, 71, 21.5, 12, 0),
	(10673, 16, 17.45, 3, 0),
	(10673, 42, 14, 6, 0),
	(10673, 43, 46, 6, 0),
	(10674, 23, 9, 5, 0),
	(10675, 14, 23.25, 30, 0),
	(10675, 53, 32.8, 10, 0),
	(10675, 58, 13.25, 30, 0),
	(10676, 10, 31, 2, 0),
	(10676, 19, 9.2, 7, 0),
	(10676, 44, 19.45, 21, 0),
	(10677, 26, 31.23, 30, 0.15),
	(10677, 33, 2.5, 8, 0.15),
	(10678, 12, 38, 100, 0),
	(10678, 33, 2.5, 30, 0),
	(10678, 41, 9.65, 120, 0),
	(10678, 54, 7.45, 30, 0),
	(10679, 59, 55, 12, 0),
	(10680, 16, 17.45, 50, 0.25),
	(10680, 31, 12.5, 20, 0.25),
	(10680, 42, 14, 40, 0.25),
	(10681, 19, 9.2, 30, 0.1),
	(10681, 21, 10, 12, 0.1),
	(10681, 64, 33.25, 28, 0),
	(10682, 33, 2.5, 30, 0),
	(10682, 66, 17, 4, 0),
	(10682, 75, 7.75, 30, 0),
	(10683, 52, 7, 9, 0),
	(10684, 40, 18.4, 20, 0),
	(10684, 47, 9.5, 40, 0),
	(10684, 60, 34, 30, 0),
	(10685, 10, 31, 20, 0),
	(10685, 41, 9.65, 4, 0),
	(10685, 47, 9.5, 15, 0),
	(10686, 17, 39, 30, 0.2),
	(10686, 26, 31.23, 15, 0),
	(10687, 9, 97, 50, 0.25),
	(10687, 29, 123.79, 10, 0),
	(10687, 36, 19, 6, 0.25),
	(10688, 10, 31, 18, 0.1),
	(10688, 28, 45.6, 60, 0.1),
	(10688, 34, 14, 14, 0),
	(10689, 1, 18, 35, 0.25),
	(10690, 56, 38, 20, 0.25),
	(10690, 77, 13, 30, 0.25),
	(10691, 1, 18, 30, 0),
	(10691, 29, 123.79, 40, 0),
	(10691, 43, 46, 40, 0),
	(10691, 44, 19.45, 24, 0),
	(10691, 62, 49.3, 48, 0),
	(10692, 63, 43.9, 20, 0),
	(10693, 9, 97, 6, 0),
	(10693, 54, 7.45, 60, 0.15),
	(10693, 69, 36, 30, 0.15),
	(10693, 73, 15, 15, 0.15),
	(10694, 7, 30, 90, 0),
	(10694, 59, 55, 25, 0),
	(10694, 70, 15, 50, 0),
	(10695, 8, 40, 10, 0),
	(10695, 12, 38, 4, 0),
	(10695, 24, 4.5, 20, 0),
	(10696, 17, 39, 20, 0),
	(10696, 46, 12, 18, 0),
	(10697, 19, 9.2, 7, 0.25),
	(10697, 35, 18, 9, 0.25),
	(10697, 58, 13.25, 30, 0.25),
	(10697, 70, 15, 30, 0.25),
	(10698, 11, 21, 15, 0),
	(10698, 17, 39, 8, 0.05),
	(10698, 29, 123.79, 12, 0.05),
	(10698, 65, 21.05, 65, 0.05),
	(10698, 70, 15, 8, 0.05),
	(10699, 47, 9.5, 12, 0),
	(10700, 1, 18, 5, 0.2),
	(10700, 34, 14, 12, 0.2),
	(10700, 68, 12.5, 40, 0.2),
	(10700, 71, 21.5, 60, 0.2),
	(10701, 59, 55, 42, 0.15),
	(10701, 71, 21.5, 20, 0.15),
	(10701, 76, 18, 35, 0.15),
	(10702, 3, 10, 6, 0),
	(10702, 76, 18, 15, 0),
	(10703, 2, 19, 5, 0),
	(10703, 59, 55, 35, 0),
	(10703, 73, 15, 35, 0),
	(10704, 4, 22, 6, 0),
	(10704, 24, 4.5, 35, 0),
	(10704, 48, 12.75, 24, 0),
	(10705, 31, 12.5, 20, 0),
	(10705, 32, 32, 4, 0),
	(10706, 16, 17.45, 20, 0),
	(10706, 43, 46, 24, 0),
	(10706, 59, 55, 8, 0),
	(10707, 55, 24, 21, 0),
	(10707, 57, 19.5, 40, 0),
	(10707, 70, 15, 28, 0.15),
	(10708, 5, 21.35, 4, 0),
	(10708, 36, 19, 5, 0),
	(10709, 8, 40, 40, 0),
	(10709, 51, 53, 28, 0),
	(10709, 60, 34, 10, 0),
	(10710, 19, 9.2, 5, 0),
	(10710, 47, 9.5, 5, 0),
	(10711, 19, 9.2, 12, 0),
	(10711, 41, 9.65, 42, 0),
	(10711, 53, 32.8, 120, 0),
	(10712, 53, 32.8, 3, 0.05),
	(10712, 56, 38, 30, 0),
	(10713, 10, 31, 18, 0),
	(10713, 26, 31.23, 30, 0),
	(10713, 45, 9.5, 110, 0),
	(10713, 46, 12, 24, 0),
	(10714, 2, 19, 30, 0.25),
	(10714, 17, 39, 27, 0.25),
	(10714, 47, 9.5, 50, 0.25),
	(10714, 56, 38, 18, 0.25),
	(10714, 58, 13.25, 12, 0.25),
	(10715, 10, 31, 21, 0),
	(10715, 71, 21.5, 30, 0),
	(10716, 21, 10, 5, 0),
	(10716, 51, 53, 7, 0),
	(10716, 61, 28.5, 10, 0),
	(10717, 21, 10, 32, 0.05),
	(10717, 54, 7.45, 15, 0),
	(10717, 69, 36, 25, 0.05),
	(10718, 12, 38, 36, 0),
	(10718, 16, 17.45, 20, 0),
	(10718, 36, 19, 40, 0),
	(10718, 62, 49.3, 20, 0),
	(10719, 18, 62.5, 12, 0.25),
	(10719, 30, 25.89, 3, 0.25),
	(10719, 54, 7.45, 40, 0.25),
	(10720, 35, 18, 21, 0),
	(10720, 71, 21.5, 8, 0),
	(10721, 44, 19.45, 50, 0.05),
	(10722, 2, 19, 3, 0),
	(10722, 31, 12.5, 50, 0),
	(10722, 68, 12.5, 45, 0),
	(10722, 75, 7.75, 42, 0),
	(10723, 26, 31.23, 15, 0),
	(10724, 10, 31, 16, 0),
	(10724, 61, 28.5, 5, 0),
	(10725, 41, 9.65, 12, 0),
	(10725, 52, 7, 4, 0),
	(10725, 55, 24, 6, 0),
	(10726, 4, 22, 25, 0),
	(10726, 11, 21, 5, 0),
	(10727, 17, 39, 20, 0.05),
	(10727, 56, 38, 10, 0.05),
	(10727, 59, 55, 10, 0.05),
	(10728, 30, 25.89, 15, 0),
	(10728, 40, 18.4, 6, 0),
	(10728, 55, 24, 12, 0),
	(10728, 60, 34, 15, 0),
	(10729, 1, 18, 50, 0),
	(10729, 21, 10, 30, 0),
	(10729, 50, 16.25, 40, 0),
	(10730, 16, 17.45, 15, 0.05),
	(10730, 31, 12.5, 3, 0.05),
	(10730, 65, 21.05, 10, 0.05),
	(10731, 21, 10, 40, 0.05),
	(10731, 51, 53, 30, 0.05),
	(10732, 76, 18, 20, 0),
	(10733, 14, 23.25, 16, 0),
	(10733, 28, 45.6, 20, 0),
	(10733, 52, 7, 25, 0),
	(10734, 6, 25, 30, 0),
	(10734, 30, 25.89, 15, 0),
	(10734, 76, 18, 20, 0),
	(10735, 61, 28.5, 20, 0.1),
	(10735, 77, 13, 2, 0.1),
	(10736, 65, 21.05, 40, 0),
	(10736, 75, 7.75, 20, 0),
	(10737, 13, 6, 4, 0),
	(10737, 41, 9.65, 12, 0),
	(10738, 16, 17.45, 3, 0),
	(10739, 36, 19, 6, 0),
	(10739, 52, 7, 18, 0),
	(10740, 28, 45.6, 5, 0.2),
	(10740, 35, 18, 35, 0.2),
	(10740, 45, 9.5, 40, 0.2),
	(10740, 56, 38, 14, 0.2),
	(10741, 2, 19, 15, 0.2),
	(10742, 3, 10, 20, 0),
	(10742, 60, 34, 50, 0),
	(10742, 72, 34.8, 35, 0),
	(10743, 46, 12, 28, 0.05),
	(10744, 40, 18.4, 50, 0.2),
	(10745, 18, 62.5, 24, 0),
	(10745, 44, 19.45, 16, 0),
	(10745, 59, 55, 45, 0),
	(10745, 72, 34.8, 7, 0),
	(10746, 13, 6, 6, 0),
	(10746, 42, 14, 28, 0),
	(10746, 62, 49.3, 9, 0),
	(10746, 69, 36, 40, 0),
	(10747, 31, 12.5, 8, 0),
	(10747, 41, 9.65, 35, 0),
	(10747, 63, 43.9, 9, 0),
	(10747, 69, 36, 30, 0),
	(10748, 23, 9, 44, 0),
	(10748, 40, 18.4, 40, 0),
	(10748, 56, 38, 28, 0),
	(10749, 56, 38, 15, 0),
	(10749, 59, 55, 6, 0),
	(10749, 76, 18, 10, 0),
	(10750, 14, 23.25, 5, 0.15),
	(10750, 45, 9.5, 40, 0.15),
	(10750, 59, 55, 25, 0.15),
	(10751, 26, 31.23, 12, 0.1),
	(10751, 30, 25.89, 30, 0),
	(10751, 50, 16.25, 20, 0.1),
	(10751, 73, 15, 15, 0),
	(10752, 1, 18, 8, 0),
	(10752, 69, 36, 3, 0),
	(10753, 45, 9.5, 4, 0),
	(10753, 74, 10, 5, 0),
	(10754, 40, 18.4, 3, 0),
	(10755, 47, 9.5, 30, 0.25),
	(10755, 56, 38, 30, 0.25),
	(10755, 57, 19.5, 14, 0.25),
	(10755, 69, 36, 25, 0.25),
	(10756, 18, 62.5, 21, 0.2),
	(10756, 36, 19, 20, 0.2),
	(10756, 68, 12.5, 6, 0.2),
	(10756, 69, 36, 20, 0.2),
	(10757, 34, 14, 30, 0),
	(10757, 59, 55, 7, 0),
	(10757, 62, 49.3, 30, 0),
	(10757, 64, 33.25, 24, 0),
	(10758, 26, 31.23, 20, 0),
	(10758, 52, 7, 60, 0),
	(10758, 70, 15, 40, 0),
	(10759, 32, 32, 10, 0),
	(10760, 25, 14, 12, 0.25),
	(10760, 27, 43.9, 40, 0),
	(10760, 43, 46, 30, 0.25),
	(10761, 25, 14, 35, 0.25),
	(10761, 75, 7.75, 18, 0),
	(10762, 39, 18, 16, 0),
	(10762, 47, 9.5, 30, 0),
	(10762, 51, 53, 28, 0),
	(10762, 56, 38, 60, 0),
	(10763, 21, 10, 40, 0),
	(10763, 22, 21, 6, 0),
	(10763, 24, 4.5, 20, 0),
	(10764, 3, 10, 20, 0.1),
	(10764, 39, 18, 130, 0.1),
	(10765, 65, 21.05, 80, 0.1),
	(10766, 2, 19, 40, 0),
	(10766, 7, 30, 35, 0),
	(10766, 68, 12.5, 40, 0),
	(10767, 42, 14, 2, 0),
	(10768, 22, 21, 4, 0),
	(10768, 31, 12.5, 50, 0),
	(10768, 60, 34, 15, 0),
	(10768, 71, 21.5, 12, 0),
	(10769, 41, 9.65, 30, 0.05),
	(10769, 52, 7, 15, 0.05),
	(10769, 61, 28.5, 20, 0),
	(10769, 62, 49.3, 15, 0),
	(10770, 11, 21, 15, 0.25),
	(10771, 71, 21.5, 16, 0),
	(10772, 29, 123.79, 18, 0),
	(10772, 59, 55, 25, 0),
	(10773, 17, 39, 33, 0),
	(10773, 31, 12.5, 70, 0.2),
	(10773, 75, 7.75, 7, 0.2),
	(10774, 31, 12.5, 2, 0.25),
	(10774, 66, 17, 50, 0),
	(10775, 10, 31, 6, 0),
	(10775, 67, 14, 3, 0),
	(10776, 31, 12.5, 16, 0.05),
	(10776, 42, 14, 12, 0.05),
	(10776, 45, 9.5, 27, 0.05),
	(10776, 51, 53, 120, 0.05),
	(10777, 42, 14, 20, 0.2),
	(10778, 41, 9.65, 10, 0),
	(10779, 16, 17.45, 20, 0),
	(10779, 62, 49.3, 20, 0),
	(10780, 70, 15, 35, 0),
	(10780, 77, 13, 15, 0),
	(10781, 54, 7.45, 3, 0.2),
	(10781, 56, 38, 20, 0.2),
	(10781, 74, 10, 35, 0),
	(10782, 31, 12.5, 1, 0),
	(10783, 31, 12.5, 10, 0),
	(10783, 38, 263.5, 5, 0),
	(10784, 36, 19, 30, 0),
	(10784, 39, 18, 2, 0.15),
	(10784, 72, 34.8, 30, 0.15),
	(10785, 10, 31, 10, 0),
	(10785, 75, 7.75, 10, 0),
	(10786, 8, 40, 30, 0.2),
	(10786, 30, 25.89, 15, 0.2),
	(10786, 75, 7.75, 42, 0.2),
	(10787, 2, 19, 15, 0.05),
	(10787, 29, 123.79, 20, 0.05),
	(10788, 19, 9.2, 50, 0.05),
	(10788, 75, 7.75, 40, 0.05),
	(10789, 18, 62.5, 30, 0),
	(10789, 35, 18, 15, 0),
	(10789, 63, 43.9, 30, 0),
	(10789, 68, 12.5, 18, 0),
	(10790, 7, 30, 3, 0.15),
	(10790, 56, 38, 20, 0.15),
	(10791, 29, 123.79, 14, 0.05),
	(10791, 41, 9.65, 20, 0.05),
	(10792, 2, 19, 10, 0),
	(10792, 54, 7.45, 3, 0),
	(10792, 68, 12.5, 15, 0),
	(10793, 41, 9.65, 14, 0),
	(10793, 52, 7, 8, 0),
	(10794, 14, 23.25, 15, 0.2),
	(10794, 54, 7.45, 6, 0.2),
	(10795, 16, 17.45, 65, 0),
	(10795, 17, 39, 35, 0.25),
	(10796, 26, 31.23, 21, 0.2),
	(10796, 44, 19.45, 10, 0),
	(10796, 64, 33.25, 35, 0.2),
	(10796, 69, 36, 24, 0.2),
	(10797, 11, 21, 20, 0),
	(10798, 62, 49.3, 2, 0),
	(10798, 72, 34.8, 10, 0),
	(10799, 13, 6, 20, 0.15),
	(10799, 24, 4.5, 20, 0.15),
	(10799, 59, 55, 25, 0),
	(10800, 11, 21, 50, 0.1),
	(10800, 51, 53, 10, 0.1),
	(10800, 54, 7.45, 7, 0.1),
	(10801, 17, 39, 40, 0.25),
	(10801, 29, 123.79, 20, 0.25),
	(10802, 30, 25.89, 25, 0.25),
	(10802, 51, 53, 30, 0.25),
	(10802, 55, 24, 60, 0.25),
	(10802, 62, 49.3, 5, 0.25),
	(10803, 19, 9.2, 24, 0.05),
	(10803, 25, 14, 15, 0.05),
	(10803, 59, 55, 15, 0.05),
	(10804, 10, 31, 36, 0),
	(10804, 28, 45.6, 24, 0),
	(10804, 49, 20, 4, 0.15),
	(10805, 34, 14, 10, 0),
	(10805, 38, 263.5, 10, 0),
	(10806, 2, 19, 20, 0.25),
	(10806, 65, 21.05, 2, 0),
	(10806, 74, 10, 15, 0.25),
	(10807, 40, 18.4, 1, 0),
	(10808, 56, 38, 20, 0.15),
	(10808, 76, 18, 50, 0.15),
	(10809, 52, 7, 20, 0),
	(10810, 13, 6, 7, 0),
	(10810, 25, 14, 5, 0),
	(10810, 70, 15, 5, 0),
	(10811, 19, 9.2, 15, 0),
	(10811, 23, 9, 18, 0),
	(10811, 40, 18.4, 30, 0),
	(10812, 31, 12.5, 16, 0.1),
	(10812, 72, 34.8, 40, 0.1),
	(10812, 77, 13, 20, 0),
	(10813, 2, 19, 12, 0.2),
	(10813, 46, 12, 35, 0),
	(10814, 41, 9.65, 20, 0),
	(10814, 43, 46, 20, 0.15),
	(10814, 48, 12.75, 8, 0.15),
	(10814, 61, 28.5, 30, 0.15),
	(10815, 33, 2.5, 16, 0),
	(10816, 38, 263.5, 30, 0.05),
	(10816, 62, 49.3, 20, 0.05),
	(10817, 26, 31.23, 40, 0.15),
	(10817, 38, 263.5, 30, 0),
	(10817, 40, 18.4, 60, 0.15),
	(10817, 62, 49.3, 25, 0.15),
	(10818, 32, 32, 20, 0),
	(10818, 41, 9.65, 20, 0),
	(10819, 43, 46, 7, 0),
	(10819, 75, 7.75, 20, 0),
	(10820, 56, 38, 30, 0),
	(10821, 35, 18, 20, 0),
	(10821, 51, 53, 6, 0),
	(10822, 62, 49.3, 3, 0),
	(10822, 70, 15, 6, 0),
	(10823, 11, 21, 20, 0.1),
	(10823, 57, 19.5, 15, 0),
	(10823, 59, 55, 40, 0.1),
	(10823, 77, 13, 15, 0.1),
	(10824, 41, 9.65, 12, 0),
	(10824, 70, 15, 9, 0),
	(10825, 26, 31.23, 12, 0),
	(10825, 53, 32.8, 20, 0),
	(10826, 31, 12.5, 35, 0),
	(10826, 57, 19.5, 15, 0),
	(10827, 10, 31, 15, 0),
	(10827, 39, 18, 21, 0),
	(10828, 20, 81, 5, 0),
	(10828, 38, 263.5, 2, 0),
	(10829, 2, 19, 10, 0),
	(10829, 8, 40, 20, 0),
	(10829, 13, 6, 10, 0),
	(10829, 60, 34, 21, 0),
	(10830, 6, 25, 6, 0),
	(10830, 39, 18, 28, 0),
	(10830, 60, 34, 30, 0),
	(10830, 68, 12.5, 24, 0),
	(10831, 19, 9.2, 2, 0),
	(10831, 35, 18, 8, 0),
	(10831, 38, 263.5, 8, 0),
	(10831, 43, 46, 9, 0),
	(10832, 13, 6, 3, 0.2),
	(10832, 25, 14, 10, 0.2),
	(10832, 44, 19.45, 16, 0.2),
	(10832, 64, 33.25, 3, 0),
	(10833, 7, 30, 20, 0.1),
	(10833, 31, 12.5, 9, 0.1),
	(10833, 53, 32.8, 9, 0.1),
	(10834, 29, 123.79, 8, 0.05),
	(10834, 30, 25.89, 20, 0.05),
	(10835, 59, 55, 15, 0),
	(10835, 77, 13, 2, 0.2),
	(10836, 22, 21, 52, 0),
	(10836, 35, 18, 6, 0),
	(10836, 57, 19.5, 24, 0),
	(10836, 60, 34, 60, 0),
	(10836, 64, 33.25, 30, 0),
	(10837, 13, 6, 6, 0),
	(10837, 40, 18.4, 25, 0),
	(10837, 47, 9.5, 40, 0.25),
	(10837, 76, 18, 21, 0.25),
	(10838, 1, 18, 4, 0.25),
	(10838, 18, 62.5, 25, 0.25),
	(10838, 36, 19, 50, 0.25),
	(10839, 58, 13.25, 30, 0.1),
	(10839, 72, 34.8, 15, 0.1),
	(10840, 25, 14, 6, 0.2),
	(10840, 39, 18, 10, 0.2),
	(10841, 10, 31, 16, 0),
	(10841, 56, 38, 30, 0),
	(10841, 59, 55, 50, 0),
	(10841, 77, 13, 15, 0),
	(10842, 11, 21, 15, 0),
	(10842, 43, 46, 5, 0),
	(10842, 68, 12.5, 20, 0),
	(10842, 70, 15, 12, 0),
	(10843, 51, 53, 4, 0.25),
	(10844, 22, 21, 35, 0),
	(10845, 23, 9, 70, 0.1),
	(10845, 35, 18, 25, 0.1),
	(10845, 42, 14, 42, 0.1),
	(10845, 58, 13.25, 60, 0.1),
	(10845, 64, 33.25, 48, 0),
	(10846, 4, 22, 21, 0),
	(10846, 70, 15, 30, 0),
	(10846, 74, 10, 20, 0),
	(10847, 1, 18, 80, 0.2),
	(10847, 19, 9.2, 12, 0.2),
	(10847, 37, 26, 60, 0.2),
	(10847, 45, 9.5, 36, 0.2),
	(10847, 60, 34, 45, 0.2),
	(10847, 71, 21.5, 55, 0.2),
	(10848, 5, 21.35, 30, 0),
	(10848, 9, 97, 3, 0),
	(10849, 3, 10, 49, 0),
	(10849, 26, 31.23, 18, 0.15),
	(10850, 25, 14, 20, 0.15),
	(10850, 33, 2.5, 4, 0.15),
	(10850, 70, 15, 30, 0.15),
	(10851, 2, 19, 5, 0.05),
	(10851, 25, 14, 10, 0.05),
	(10851, 57, 19.5, 10, 0.05),
	(10851, 59, 55, 42, 0.05),
	(10852, 2, 19, 15, 0),
	(10852, 17, 39, 6, 0),
	(10852, 62, 49.3, 50, 0),
	(10853, 18, 62.5, 10, 0),
	(10854, 10, 31, 100, 0.15),
	(10854, 13, 6, 65, 0.15),
	(10855, 16, 17.45, 50, 0),
	(10855, 31, 12.5, 14, 0),
	(10855, 56, 38, 24, 0),
	(10855, 65, 21.05, 15, 0.15),
	(10856, 2, 19, 20, 0),
	(10856, 42, 14, 20, 0),
	(10857, 3, 10, 30, 0),
	(10857, 26, 31.23, 35, 0.25),
	(10857, 29, 123.79, 10, 0.25),
	(10858, 7, 30, 5, 0),
	(10858, 27, 43.9, 10, 0),
	(10858, 70, 15, 4, 0),
	(10859, 24, 4.5, 40, 0.25),
	(10859, 54, 7.45, 35, 0.25),
	(10859, 64, 33.25, 30, 0.25),
	(10860, 51, 53, 3, 0),
	(10860, 76, 18, 20, 0),
	(10861, 17, 39, 42, 0),
	(10861, 18, 62.5, 20, 0),
	(10861, 21, 10, 40, 0),
	(10861, 33, 2.5, 35, 0),
	(10861, 62, 49.3, 3, 0),
	(10862, 11, 21, 25, 0),
	(10862, 52, 7, 8, 0),
	(10863, 1, 18, 20, 0.15),
	(10863, 58, 13.25, 12, 0.15),
	(10864, 35, 18, 4, 0),
	(10864, 67, 14, 15, 0),
	(10865, 38, 263.5, 60, 0.05),
	(10865, 39, 18, 80, 0.05),
	(10866, 2, 19, 21, 0.25),
	(10866, 24, 4.5, 6, 0.25),
	(10866, 30, 25.89, 40, 0.25),
	(10867, 53, 32.8, 3, 0),
	(10868, 26, 31.23, 20, 0),
	(10868, 35, 18, 30, 0),
	(10868, 49, 20, 42, 0.1),
	(10869, 1, 18, 40, 0),
	(10869, 11, 21, 10, 0),
	(10869, 23, 9, 50, 0),
	(10869, 68, 12.5, 20, 0),
	(10870, 35, 18, 3, 0),
	(10870, 51, 53, 2, 0),
	(10871, 6, 25, 50, 0.05),
	(10871, 16, 17.45, 12, 0.05),
	(10871, 17, 39, 16, 0.05),
	(10872, 55, 24, 10, 0.05),
	(10872, 62, 49.3, 20, 0.05),
	(10872, 64, 33.25, 15, 0.05),
	(10872, 65, 21.05, 21, 0.05),
	(10873, 21, 10, 20, 0),
	(10873, 28, 45.6, 3, 0),
	(10874, 10, 31, 10, 0),
	(10875, 19, 9.2, 25, 0),
	(10875, 47, 9.5, 21, 0.1),
	(10875, 49, 20, 15, 0),
	(10876, 46, 12, 21, 0),
	(10876, 64, 33.25, 20, 0),
	(10877, 16, 17.45, 30, 0.25),
	(10877, 18, 62.5, 25, 0),
	(10878, 20, 81, 20, 0.05),
	(10879, 40, 18.4, 12, 0),
	(10879, 65, 21.05, 10, 0),
	(10879, 76, 18, 10, 0),
	(10880, 23, 9, 30, 0.2),
	(10880, 61, 28.5, 30, 0.2),
	(10880, 70, 15, 50, 0.2),
	(10881, 73, 15, 10, 0),
	(10882, 42, 14, 25, 0),
	(10882, 49, 20, 20, 0.15),
	(10882, 54, 7.45, 32, 0.15),
	(10883, 24, 4.5, 8, 0),
	(10884, 21, 10, 40, 0.05),
	(10884, 56, 38, 21, 0.05),
	(10884, 65, 21.05, 12, 0.05),
	(10885, 2, 19, 20, 0),
	(10885, 24, 4.5, 12, 0),
	(10885, 70, 15, 30, 0),
	(10885, 77, 13, 25, 0),
	(10886, 10, 31, 70, 0),
	(10886, 31, 12.5, 35, 0),
	(10886, 77, 13, 40, 0),
	(10887, 25, 14, 5, 0),
	(10888, 2, 19, 20, 0),
	(10888, 68, 12.5, 18, 0),
	(10889, 11, 21, 40, 0),
	(10889, 38, 263.5, 40, 0),
	(10890, 17, 39, 15, 0),
	(10890, 34, 14, 10, 0),
	(10890, 41, 9.65, 14, 0),
	(10891, 30, 25.89, 15, 0.05),
	(10892, 59, 55, 40, 0.05),
	(10893, 8, 40, 30, 0),
	(10893, 24, 4.5, 10, 0),
	(10893, 29, 123.79, 24, 0),
	(10893, 30, 25.89, 35, 0),
	(10893, 36, 19, 20, 0),
	(10894, 13, 6, 28, 0.05),
	(10894, 69, 36, 50, 0.05),
	(10894, 75, 7.75, 120, 0.05),
	(10895, 24, 4.5, 110, 0),
	(10895, 39, 18, 45, 0),
	(10895, 40, 18.4, 91, 0),
	(10895, 60, 34, 100, 0),
	(10896, 45, 9.5, 15, 0),
	(10896, 56, 38, 16, 0),
	(10897, 29, 123.79, 80, 0),
	(10897, 30, 25.89, 36, 0),
	(10898, 13, 6, 5, 0),
	(10899, 39, 18, 8, 0.15),
	(10900, 70, 15, 3, 0.25),
	(10901, 41, 9.65, 30, 0),
	(10901, 71, 21.5, 30, 0),
	(10902, 55, 24, 30, 0.15),
	(10902, 62, 49.3, 6, 0.15),
	(10903, 13, 6, 40, 0),
	(10903, 65, 21.05, 21, 0),
	(10903, 68, 12.5, 20, 0),
	(10904, 58, 13.25, 15, 0),
	(10904, 62, 49.3, 35, 0),
	(10905, 1, 18, 20, 0.05),
	(10906, 61, 28.5, 15, 0),
	(10907, 75, 7.75, 14, 0),
	(10908, 7, 30, 20, 0.05),
	(10908, 52, 7, 14, 0.05),
	(10909, 7, 30, 12, 0),
	(10909, 16, 17.45, 15, 0),
	(10909, 41, 9.65, 5, 0),
	(10910, 19, 9.2, 12, 0),
	(10910, 49, 20, 10, 0),
	(10910, 61, 28.5, 5, 0),
	(10911, 1, 18, 10, 0),
	(10911, 17, 39, 12, 0),
	(10911, 67, 14, 15, 0),
	(10912, 11, 21, 40, 0.25),
	(10912, 29, 123.79, 60, 0.25),
	(10913, 4, 22, 30, 0.25),
	(10913, 33, 2.5, 40, 0.25),
	(10913, 58, 13.25, 15, 0),
	(10914, 71, 21.5, 25, 0),
	(10915, 17, 39, 10, 0),
	(10915, 33, 2.5, 30, 0),
	(10915, 54, 7.45, 10, 0),
	(10916, 16, 17.45, 6, 0),
	(10916, 32, 32, 6, 0),
	(10916, 57, 19.5, 20, 0),
	(10917, 30, 25.89, 1, 0),
	(10917, 60, 34, 10, 0),
	(10918, 1, 18, 60, 0.25),
	(10918, 60, 34, 25, 0.25),
	(10919, 16, 17.45, 24, 0),
	(10919, 25, 14, 24, 0),
	(10919, 40, 18.4, 20, 0),
	(10920, 50, 16.25, 24, 0),
	(10921, 35, 18, 10, 0),
	(10921, 63, 43.9, 40, 0),
	(10922, 17, 39, 15, 0),
	(10922, 24, 4.5, 35, 0),
	(10923, 42, 14, 10, 0.2),
	(10923, 43, 46, 10, 0.2),
	(10923, 67, 14, 24, 0.2),
	(10924, 10, 31, 20, 0.1),
	(10924, 28, 45.6, 30, 0.1),
	(10924, 75, 7.75, 6, 0),
	(10925, 36, 19, 25, 0.15),
	(10925, 52, 7, 12, 0.15),
	(10926, 11, 21, 2, 0),
	(10926, 13, 6, 10, 0),
	(10926, 19, 9.2, 7, 0),
	(10926, 72, 34.8, 10, 0),
	(10927, 20, 81, 5, 0),
	(10927, 52, 7, 5, 0),
	(10927, 76, 18, 20, 0),
	(10928, 47, 9.5, 5, 0),
	(10928, 76, 18, 5, 0),
	(10929, 21, 10, 60, 0),
	(10929, 75, 7.75, 49, 0),
	(10929, 77, 13, 15, 0),
	(10930, 21, 10, 36, 0),
	(10930, 27, 43.9, 25, 0),
	(10930, 55, 24, 25, 0.2),
	(10930, 58, 13.25, 30, 0.2),
	(10931, 13, 6, 42, 0.15),
	(10931, 57, 19.5, 30, 0),
	(10932, 16, 17.45, 30, 0.1),
	(10932, 62, 49.3, 14, 0.1),
	(10932, 72, 34.8, 16, 0),
	(10932, 75, 7.75, 20, 0.1),
	(10933, 53, 32.8, 2, 0),
	(10933, 61, 28.5, 30, 0),
	(10934, 6, 25, 20, 0),
	(10935, 1, 18, 21, 0),
	(10935, 18, 62.5, 4, 0.25),
	(10935, 23, 9, 8, 0.25),
	(10936, 36, 19, 30, 0.2),
	(10937, 28, 45.6, 8, 0),
	(10937, 34, 14, 20, 0),
	(10938, 13, 6, 20, 0.25),
	(10938, 43, 46, 24, 0.25),
	(10938, 60, 34, 49, 0.25),
	(10938, 71, 21.5, 35, 0.25),
	(10939, 2, 19, 10, 0.15),
	(10939, 67, 14, 40, 0.15),
	(10940, 7, 30, 8, 0),
	(10940, 13, 6, 20, 0),
	(10941, 31, 12.5, 44, 0.25),
	(10941, 62, 49.3, 30, 0.25),
	(10941, 68, 12.5, 80, 0.25),
	(10941, 72, 34.8, 50, 0),
	(10942, 49, 20, 28, 0),
	(10943, 13, 6, 15, 0),
	(10943, 22, 21, 21, 0),
	(10943, 46, 12, 15, 0),
	(10944, 11, 21, 5, 0.25),
	(10944, 44, 19.45, 18, 0.25),
	(10944, 56, 38, 18, 0),
	(10945, 13, 6, 20, 0),
	(10945, 31, 12.5, 10, 0),
	(10946, 10, 31, 25, 0),
	(10946, 24, 4.5, 25, 0),
	(10946, 77, 13, 40, 0),
	(10947, 59, 55, 4, 0),
	(10948, 50, 16.25, 9, 0),
	(10948, 51, 53, 40, 0),
	(10948, 55, 24, 4, 0),
	(10949, 6, 25, 12, 0),
	(10949, 10, 31, 30, 0),
	(10949, 17, 39, 6, 0),
	(10949, 62, 49.3, 60, 0),
	(10950, 4, 22, 5, 0),
	(10951, 33, 2.5, 15, 0.05),
	(10951, 41, 9.65, 6, 0.05),
	(10951, 75, 7.75, 50, 0.05),
	(10952, 6, 25, 16, 0.05),
	(10952, 28, 45.6, 2, 0),
	(10953, 20, 81, 50, 0.05),
	(10953, 31, 12.5, 50, 0.05),
	(10954, 16, 17.45, 28, 0.15),
	(10954, 31, 12.5, 25, 0.15),
	(10954, 45, 9.5, 30, 0),
	(10954, 60, 34, 24, 0.15),
	(10955, 75, 7.75, 12, 0.2),
	(10956, 21, 10, 12, 0),
	(10956, 47, 9.5, 14, 0),
	(10956, 51, 53, 8, 0),
	(10957, 30, 25.89, 30, 0),
	(10957, 35, 18, 40, 0),
	(10957, 64, 33.25, 8, 0),
	(10958, 5, 21.35, 20, 0),
	(10958, 7, 30, 6, 0),
	(10958, 72, 34.8, 5, 0),
	(10959, 75, 7.75, 20, 0.15),
	(10960, 24, 4.5, 10, 0.25),
	(10960, 41, 9.65, 24, 0),
	(10961, 52, 7, 6, 0.05),
	(10961, 76, 18, 60, 0),
	(10962, 7, 30, 45, 0),
	(10962, 13, 6, 77, 0),
	(10962, 53, 32.8, 20, 0),
	(10962, 69, 36, 9, 0),
	(10962, 76, 18, 44, 0),
	(10963, 60, 34, 2, 0.15),
	(10964, 18, 62.5, 6, 0),
	(10964, 38, 263.5, 5, 0),
	(10964, 69, 36, 10, 0),
	(10965, 51, 53, 16, 0),
	(10966, 37, 26, 8, 0),
	(10966, 56, 38, 12, 0.15),
	(10966, 62, 49.3, 12, 0.15),
	(10967, 19, 9.2, 12, 0),
	(10967, 49, 20, 40, 0),
	(10968, 12, 38, 30, 0),
	(10968, 24, 4.5, 30, 0),
	(10968, 64, 33.25, 4, 0),
	(10969, 46, 12, 9, 0),
	(10970, 52, 7, 40, 0.2),
	(10971, 29, 123.79, 14, 0),
	(10972, 17, 39, 6, 0),
	(10972, 33, 2.5, 7, 0),
	(10973, 26, 31.23, 5, 0),
	(10973, 41, 9.65, 6, 0),
	(10973, 75, 7.75, 10, 0),
	(10974, 63, 43.9, 10, 0),
	(10975, 8, 40, 16, 0),
	(10975, 75, 7.75, 10, 0),
	(10976, 28, 45.6, 20, 0),
	(10977, 39, 18, 30, 0),
	(10977, 47, 9.5, 30, 0),
	(10977, 51, 53, 10, 0),
	(10977, 63, 43.9, 20, 0),
	(10978, 8, 40, 20, 0.15),
	(10978, 21, 10, 40, 0.15),
	(10978, 40, 18.4, 10, 0),
	(10978, 44, 19.45, 6, 0.15),
	(10979, 7, 30, 18, 0),
	(10979, 12, 38, 20, 0),
	(10979, 24, 4.5, 80, 0),
	(10979, 27, 43.9, 30, 0),
	(10979, 31, 12.5, 24, 0),
	(10979, 63, 43.9, 35, 0),
	(10980, 75, 7.75, 40, 0.2),
	(10981, 38, 263.5, 60, 0),
	(10982, 7, 30, 20, 0),
	(10982, 43, 46, 9, 0),
	(10983, 13, 6, 84, 0.15),
	(10983, 57, 19.5, 15, 0),
	(10984, 16, 17.45, 55, 0),
	(10984, 24, 4.5, 20, 0),
	(10984, 36, 19, 40, 0),
	(10985, 16, 17.45, 36, 0.1),
	(10985, 18, 62.5, 8, 0.1),
	(10985, 32, 32, 35, 0.1),
	(10986, 11, 21, 30, 0),
	(10986, 20, 81, 15, 0),
	(10986, 76, 18, 10, 0),
	(10986, 77, 13, 15, 0),
	(10987, 7, 30, 60, 0),
	(10987, 43, 46, 6, 0),
	(10987, 72, 34.8, 20, 0),
	(10988, 7, 30, 60, 0),
	(10988, 62, 49.3, 40, 0.1),
	(10989, 6, 25, 40, 0),
	(10989, 11, 21, 15, 0),
	(10989, 41, 9.65, 4, 0),
	(10990, 21, 10, 65, 0),
	(10990, 34, 14, 60, 0.15),
	(10990, 55, 24, 65, 0.15),
	(10990, 61, 28.5, 66, 0.15),
	(10991, 2, 19, 50, 0.2),
	(10991, 70, 15, 20, 0.2),
	(10991, 76, 18, 90, 0.2),
	(10992, 72, 34.8, 2, 0),
	(10993, 29, 123.79, 50, 0.25),
	(10993, 41, 9.65, 35, 0.25),
	(10994, 59, 55, 18, 0.05),
	(10995, 51, 53, 20, 0),
	(10995, 60, 34, 4, 0),
	(10996, 42, 14, 40, 0),
	(10997, 32, 32, 50, 0),
	(10997, 46, 12, 20, 0.25),
	(10997, 52, 7, 20, 0.25),
	(10998, 24, 4.5, 12, 0),
	(10998, 61, 28.5, 7, 0),
	(10998, 74, 10, 20, 0),
	(10998, 75, 7.75, 30, 0),
	(10999, 41, 9.65, 20, 0.05),
	(10999, 51, 53, 15, 0.05),
	(10999, 77, 13, 21, 0.05),
	(11000, 4, 22, 25, 0.25),
	(11000, 24, 4.5, 30, 0.25),
	(11000, 77, 13, 30, 0),
	(11001, 7, 30, 60, 0),
	(11001, 22, 21, 25, 0),
	(11001, 46, 12, 25, 0),
	(11001, 55, 24, 6, 0),
	(11002, 13, 6, 56, 0),
	(11002, 35, 18, 15, 0.15),
	(11002, 42, 14, 24, 0.15),
	(11002, 55, 24, 40, 0),
	(11003, 1, 18, 4, 0),
	(11003, 40, 18.4, 10, 0),
	(11003, 52, 7, 10, 0),
	(11004, 26, 31.23, 6, 0),
	(11004, 76, 18, 6, 0),
	(11005, 1, 18, 2, 0),
	(11005, 59, 55, 10, 0),
	(11006, 1, 18, 8, 0),
	(11006, 29, 123.79, 2, 0.25),
	(11007, 8, 40, 30, 0),
	(11007, 29, 123.79, 10, 0),
	(11007, 42, 14, 14, 0),
	(11008, 28, 45.6, 70, 0.05),
	(11008, 34, 14, 90, 0.05),
	(11008, 71, 21.5, 21, 0),
	(11009, 24, 4.5, 12, 0),
	(11009, 36, 19, 18, 0.25),
	(11009, 60, 34, 9, 0),
	(11010, 7, 30, 20, 0),
	(11010, 24, 4.5, 10, 0),
	(11011, 58, 13.25, 40, 0.05),
	(11011, 71, 21.5, 20, 0),
	(11012, 19, 9.2, 50, 0.05),
	(11012, 60, 34, 36, 0.05),
	(11012, 71, 21.5, 60, 0.05),
	(11013, 23, 9, 10, 0),
	(11013, 42, 14, 4, 0),
	(11013, 45, 9.5, 20, 0),
	(11013, 68, 12.5, 2, 0),
	(11014, 41, 9.65, 28, 0.1),
	(11015, 30, 25.89, 15, 0),
	(11015, 77, 13, 18, 0),
	(11016, 31, 12.5, 15, 0),
	(11016, 36, 19, 16, 0),
	(11017, 3, 10, 25, 0),
	(11017, 59, 55, 110, 0),
	(11017, 70, 15, 30, 0),
	(11018, 12, 38, 20, 0),
	(11018, 18, 62.5, 10, 0),
	(11018, 56, 38, 5, 0),
	(11019, 46, 12, 3, 0),
	(11019, 49, 20, 2, 0),
	(11020, 10, 31, 24, 0.15),
	(11021, 2, 19, 11, 0.25),
	(11021, 20, 81, 15, 0),
	(11021, 26, 31.23, 63, 0),
	(11021, 51, 53, 44, 0.25),
	(11021, 72, 34.8, 35, 0),
	(11022, 19, 9.2, 35, 0),
	(11022, 69, 36, 30, 0),
	(11023, 7, 30, 4, 0),
	(11023, 43, 46, 30, 0),
	(11024, 26, 31.23, 12, 0),
	(11024, 33, 2.5, 30, 0),
	(11024, 65, 21.05, 21, 0),
	(11024, 71, 21.5, 50, 0),
	(11025, 1, 18, 10, 0.1),
	(11025, 13, 6, 20, 0.1),
	(11026, 18, 62.5, 8, 0),
	(11026, 51, 53, 10, 0),
	(11027, 24, 4.5, 30, 0.25),
	(11027, 62, 49.3, 21, 0.25),
	(11028, 55, 24, 35, 0),
	(11028, 59, 55, 24, 0),
	(11029, 56, 38, 20, 0),
	(11029, 63, 43.9, 12, 0),
	(11030, 2, 19, 100, 0.25),
	(11030, 5, 21.35, 70, 0),
	(11030, 29, 123.79, 60, 0.25),
	(11030, 59, 55, 100, 0.25),
	(11031, 1, 18, 45, 0),
	(11031, 13, 6, 80, 0),
	(11031, 24, 4.5, 21, 0),
	(11031, 64, 33.25, 20, 0),
	(11031, 71, 21.5, 16, 0),
	(11032, 36, 19, 35, 0),
	(11032, 38, 263.5, 25, 0),
	(11032, 59, 55, 30, 0),
	(11033, 53, 32.8, 70, 0.1),
	(11033, 69, 36, 36, 0.1),
	(11034, 21, 10, 15, 0.1),
	(11034, 44, 19.45, 12, 0),
	(11034, 61, 28.5, 6, 0),
	(11035, 1, 18, 10, 0),
	(11035, 35, 18, 60, 0),
	(11035, 42, 14, 30, 0),
	(11035, 54, 7.45, 10, 0),
	(11036, 13, 6, 7, 0),
	(11036, 59, 55, 30, 0),
	(11037, 70, 15, 4, 0),
	(11038, 40, 18.4, 5, 0.2),
	(11038, 52, 7, 2, 0),
	(11038, 71, 21.5, 30, 0),
	(11039, 28, 45.6, 20, 0),
	(11039, 35, 18, 24, 0),
	(11039, 49, 20, 60, 0),
	(11039, 57, 19.5, 28, 0),
	(11040, 21, 10, 20, 0),
	(11041, 2, 19, 30, 0.2),
	(11041, 63, 43.9, 30, 0),
	(11042, 44, 19.45, 15, 0),
	(11042, 61, 28.5, 4, 0),
	(11043, 11, 21, 10, 0),
	(11044, 62, 49.3, 12, 0),
	(11045, 33, 2.5, 15, 0),
	(11045, 51, 53, 24, 0),
	(11046, 12, 38, 20, 0.05),
	(11046, 32, 32, 15, 0.05),
	(11046, 35, 18, 18, 0.05),
	(11047, 1, 18, 25, 0.25),
	(11047, 5, 21.35, 30, 0.25),
	(11048, 68, 12.5, 42, 0),
	(11049, 2, 19, 10, 0.2),
	(11049, 12, 38, 4, 0.2),
	(11050, 76, 18, 50, 0.1),
	(11051, 24, 4.5, 10, 0.2),
	(11052, 43, 46, 30, 0.2),
	(11052, 61, 28.5, 10, 0.2),
	(11053, 18, 62.5, 35, 0.2),
	(11053, 32, 32, 20, 0),
	(11053, 64, 33.25, 25, 0.2),
	(11054, 33, 2.5, 10, 0),
	(11054, 67, 14, 20, 0),
	(11055, 24, 4.5, 15, 0),
	(11055, 25, 14, 15, 0),
	(11055, 51, 53, 20, 0),
	(11055, 57, 19.5, 20, 0),
	(11056, 7, 30, 40, 0),
	(11056, 55, 24, 35, 0),
	(11056, 60, 34, 50, 0),
	(11057, 70, 15, 3, 0),
	(11058, 21, 10, 3, 0),
	(11058, 60, 34, 21, 0),
	(11058, 61, 28.5, 4, 0),
	(11059, 13, 6, 30, 0),
	(11059, 17, 39, 12, 0),
	(11059, 60, 34, 35, 0),
	(11060, 60, 34, 4, 0),
	(11060, 77, 13, 10, 0),
	(11061, 60, 34, 15, 0),
	(11062, 53, 32.8, 10, 0.2),
	(11062, 70, 15, 12, 0.2),
	(11063, 34, 14, 30, 0),
	(11063, 40, 18.4, 40, 0.1),
	(11063, 41, 9.65, 30, 0.1),
	(11064, 17, 39, 77, 0.1),
	(11064, 41, 9.65, 12, 0),
	(11064, 53, 32.8, 25, 0.1),
	(11064, 55, 24, 4, 0.1),
	(11064, 68, 12.5, 55, 0),
	(11065, 30, 25.89, 4, 0.25),
	(11065, 54, 7.45, 20, 0.25),
	(11066, 16, 17.45, 3, 0),
	(11066, 19, 9.2, 42, 0),
	(11066, 34, 14, 35, 0),
	(11067, 41, 9.65, 9, 0),
	(11068, 28, 45.6, 8, 0.15),
	(11068, 43, 46, 36, 0.15),
	(11068, 77, 13, 28, 0.15),
	(11069, 39, 18, 20, 0),
	(11070, 1, 18, 40, 0.15),
	(11070, 2, 19, 20, 0.15),
	(11070, 16, 17.45, 30, 0.15),
	(11070, 31, 12.5, 20, 0),
	(11071, 7, 30, 15, 0.05),
	(11071, 13, 6, 10, 0.05),
	(11072, 2, 19, 8, 0),
	(11072, 41, 9.65, 40, 0),
	(11072, 50, 16.25, 22, 0),
	(11072, 64, 33.25, 130, 0),
	(11073, 11, 21, 10, 0),
	(11073, 24, 4.5, 20, 0),
	(11074, 16, 17.45, 14, 0.05),
	(11075, 2, 19, 10, 0.15),
	(11075, 46, 12, 30, 0.15),
	(11075, 76, 18, 2, 0.15),
	(11076, 6, 25, 20, 0.25),
	(11076, 14, 23.25, 20, 0.25),
	(11076, 19, 9.2, 10, 0.25),
	(11077, 2, 19, 24, 0.2),
	(11077, 3, 10, 4, 0),
	(11077, 4, 22, 1, 0),
	(11077, 6, 25, 1, 0.02),
	(11077, 7, 30, 1, 0.05),
	(11077, 8, 40, 2, 0.1),
	(11077, 10, 31, 1, 0),
	(11077, 12, 38, 2, 0.05),
	(11077, 13, 6, 4, 0),
	(11077, 14, 23.25, 1, 0.03),
	(11077, 16, 17.45, 2, 0.03),
	(11077, 20, 81, 1, 0.04),
	(11077, 23, 9, 2, 0),
	(11077, 32, 32, 1, 0),
	(11077, 39, 18, 2, 0.05),
	(11077, 41, 9.65, 3, 0),
	(11077, 46, 12, 3, 0.02),
	(11077, 52, 7, 2, 0),
	(11077, 55, 24, 2, 0),
	(11077, 60, 34, 2, 0.06),
	(11077, 64, 33.25, 2, 0.03),
	(11077, 66, 17, 1, 0),
	(11077, 73, 15, 2, 0.01),
	(11077, 75, 7.75, 4, 0),
	(11077, 77, 13, 2, 0);


--
-- Data for Name: us_states; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO US_States VALUES
	(1, 'Alabama', 'AL', 'south'),
	(2, 'Alaska', 'AK', 'north'),
	(3, 'Arizona', 'AZ', 'west'),
	(4, 'Arkansas', 'AR', 'south'),
	(5, 'California', 'CA', 'west'),
	(6, 'Colorado', 'CO', 'west'),
	(7, 'Connecticut', 'CT', 'east'),
	(8, 'Delaware', 'DE', 'east'),
	(9, 'District of Columbia', 'DC', 'east'),
	(10, 'Florida', 'FL', 'south'),
	(11, 'Georgia', 'GA', 'south'),
	(12, 'Hawaii', 'HI', 'west'),
	(13, 'Idaho', 'ID', 'midwest'),
	(14, 'Illinois', 'IL', 'midwest'),
	(15, 'Indiana', 'IN', 'midwest'),
	(16, 'Iowa', 'IO', 'midwest'),
	(17, 'Kansas', 'KS', 'midwest'),
	(18, 'Kentucky', 'KY', 'south'),
	(19, 'Louisiana', 'LA', 'south'),
	(20, 'Maine', 'ME', 'north'),
	(21, 'Maryland', 'MD', 'east'),
	(22, 'Massachusetts', 'MA', 'north'),
	(23, 'Michigan', 'MI', 'north'),
	(24, 'Minnesota', 'MN', 'north'),
	(25, 'Mississippi', 'MS', 'south'),
	(26, 'Missouri', 'MO', 'south'),
	(27, 'Montana', 'MT', 'west'),
	(28, 'Nebraska', 'NE', 'midwest'),
	(29, 'Nevada', 'NV', 'west'),
	(30, 'New Hampshire', 'NH', 'east'),
	(31, 'New Jersey', 'NJ', 'east'),
	(32, 'New Mexico', 'NM', 'west'),
	(33, 'New York', 'NY', 'east'),
	(34, 'North Carolina', 'NC', 'east'),
	(35, 'North Dakota', 'ND', 'midwest'),
	(36, 'Ohio', 'OH', 'midwest'),
	(37, 'Oklahoma', 'OK', 'midwest'),
	(38, 'Oregon', 'OR', 'west'),
	(39, 'Pennsylvania', 'PA', 'east'),
	(40, 'Rhode Island', 'RI', 'east'),
	(41, 'South Carolina', 'SC', 'east'),
	(42, 'South Dakota', 'SD', 'midwest'),
	(43, 'Tennessee', 'TN', 'midwest'),
	(44, 'Texas', 'TX', 'west'),
	(45, 'Utah', 'UT', 'west'),
	(46, 'Vermont', 'VT', 'east'),
	(47, 'Virginia', 'VA', 'east'),
	(48, 'Washington', 'WA', 'west'),
	(49, 'West Virginia', 'WV', 'south'),
	(50, 'Wisconsin', 'WI', 'midwest'),
	(51, 'Wyoming', 'WY', 'west');


--
-- Задания для анализа
--


-- 1. Определение объема продаж по категориям
-- Задача: Проанализировать, какие категории товаров приносят наибольшую выручку

SELECT 
    c.category_name,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) as total_revenue,
    COUNT(DISTINCT o.order_id) as total_orders,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)) / COUNT(DISTINCT o.order_id), 2) as avg_revenue_per_order
FROM Categories c
JOIN Products p USING (category_id)
JOIN Order_Details od USING (product_id)
JOIN Orders o USING (order_id)
GROUP BY c.category_name
ORDER BY total_revenue DESC;

/*
Результат запроса:
---------------------------------------------------------------------------------------------------------------
category_name		|	total_revenue	|	total_orders	|	avg_revenue_per_order
----------------------------------------------------------------------------------------------------------------
Beverages		|	267868.18		|	354				|	756.69
Dairy Products		|	234507.28		|	303				|	773.95
Confections		|	167357.23		|	295				|	567.31
Meat/Poultry		|	163022.36		|	161				|	1012.56
Seafood			|	131261.74		|	291				|	451.07
Condiments		|	106047.08		|	193				|	549.47
Produce			|	99984.58		|	129				|	775.07
Grains/Cereals		|	95744.59		|	182				|	526.07
----------------------------------------------------------------------------------------------------------------

-- Выводы по 1-заданию:

Лидеры по общей выручке:
- Напитки (Beverages) - 267,868.18
- Молочные продукты (Dairy Products) - 234,507.28
- Кондитерские изделия (Confections) - 167,357.23

Хотя категория "Мясо/Птица" находится на 4-м месте по общей выручке, она имеет самый высокий средний чек на заказ, что говорит о высокой ценности каждой транзакции.
Категория "Напитки" лидирует по общей выручке, несмотря на средний показатель по количеству заказов, что указывает на хорошую маржинальность и объем продаж в каждом заказе.
Молочные продукты показывают стабильно высокие результаты по всем метрикам: второе место по выручке, лидерство по количеству заказов и хороший средний чек.
*/


-- 2. Анализ сезонности продаж
-- Задача: Исследовать сезонные колебания продаж и выявить месяцы с наивысшими и наименьшими продажами.

SELECT 
    -- YEAR(o.order_date) as year,
    MONTH(o.order_date) as month,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) as monthly_revenue,
    COUNT(DISTINCT o.order_id) as order_count
FROM Orders o
JOIN Order_Details od USING (order_id)
GROUP BY MONTH(o.order_date)
ORDER BY monthly_revenue DESC;

/*
Результат запроса:
-----------------------------------------------------------
month		|	monthly_revenue |   order_count
-----------------------------------------------------------
4		|	176831.63		|	105
1		|	155480.18		|	88
3		|	143401.38		|	103
2		|	137898.92		|	83
12		|	116638.06		|	79
10		|	104264.95		|	64
11		|	89133.85		|	59
9		|	82010.64		|	60
7		|	78882.75		|	55
8		|	72772.94		|	58
5		|	72114.92		|	46
6		|	36362.8			|	30
-----------------------------------------------------------

-- Выводы по 2-заданию:

ТОП 3 прибыльных месяцев (скорее всего связано с праздниками, когда покупатели активно начинают закупаться):
	Апрель (176,831.63)
	Январь (155,480.18)
	Март (143401.38)
                    
Наименьшие продажи наблюдаются в июне (36,362.8)

Данные показывают явную сезонность продаж, с пиковой активностью в начале года (январь, февраль, март) и в осенний период (октябрь, ноябрь).
Летние месяцы (июнь, июль, август) характеризуются снижением продаж, что может быть связано с отпускной активностью потребителей.
*/


-- 3. Эффективность работы сотрудников
-- Задача: Оценить продажи, обработанные каждым сотрудником, ранжируйте сотрудников от самого продуктивного к менее.

SELECT 
    CONCAT(e.first_name, ' ', e.last_name) as employee_name,
    COUNT(DISTINCT o.order_id) as total_orders,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) as total_sales,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)) / COUNT(DISTINCT o.order_id), 2) as avg_order_value,
    COUNT(DISTINCT o.customer_id) as unique_customers,
    AVG(TIMESTAMPDIFF(DAY, o.order_date, o.shipped_date)) AS avg_days_to_ship,
    DENSE_RANK() OVER (
        ORDER BY 
            SUM(od.unit_price * od.quantity * (1 - od.discount)) DESC, 
            AVG(TIMESTAMPDIFF(DAY, o.order_date, o.shipped_date))
    ) AS performance_rank
FROM Employees e
JOIN Orders o USING (employee_id)
JOIN Order_Details od USING (order_id)
WHERE o.shipped_date IS NOT NULL
GROUP BY e.employee_id, employee_name
ORDER BY performance_rank;

/*
Результат запроса:
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
employee_name		|  total_orders 		|	total_sales	|	avg_order_value 	| unique_customers  			| avg_days_to_ship  		| performance_rank
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Margaret Peacock	|	151			|	225763.7	|	1495.12			|	75				|	8.6235			|	1
Janet Leverling		|	127			|	202812.84	|	1596.95			|	63				|	8.5296			|	2
Nancy Davolio		|	120			|	187277.38	|	1560.64			|	65				|	7.4968			|	3
Andrew Fuller		|	93			|	162769.78	|	1750.21			|	58				|	8.2457			|	4
Laura Callahan		|	100			|	123842.68	|	1238.43			|	55				|	8.6200			|	5
Robert King		|	69			|	119619.25	|	1733.61			|	45				|	8.2807			|	6
Anne Dodsworth		|	42			|	76450.07	|	1820.24			|	29				|	10.3942			|	7
Michael Suyama		|	65			|	72527.63	|	1115.81			|	42				|	8.5427			|	8
Steven Buchanan		|	42			|	68792.28	|	1637.91			|	29				|	6.7521			|	9
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Выводы по 3-заданию:

- Лучшие сотрудники:
1. Margaret Peacock: 151 заказ на сумму 225,763.7, средний доход на заказ 1,495.12, обслужила 75 уникальных клиентов, со средней скоростью обработки заказа 8.62 дня.
2. Janet Leverling: 127 заказов на сумму 202,812.84, средний доход на заказ 1,596.95, обслужила 63 уникальных клиентов, со средней скоростью обработки заказа 8.53 дня.
3. Nancy Davolio: 120 заказов на сумму 187,277.38, средний доход на заказ 1,560.64, обслужила 65 уникальных клиентов, со средней скоростью обработки заказа 7.50 дня.

Менее продуктивные сотрудники:
1. Steven Buchanan (9-е место): 42 заказа на сумму 68,792.28, средний доход на заказ 1,637.91, обслужил 29 уникальных клиентов, со средней скоростью обработки заказа (6.75 дня).
2. Anne Dodsworth (7-е место): 42 заказа на сумму 76,450.07, средний доход на заказ 1,820.24, обслужила 29 уникальных клиентов, с самой низкой скоростью обработки заказа — 10.39 дня.

Margaret Peacock, Janet Leverling и Nancy Davolio являются самыми эффективными сотрудниками, так как они не только увеличивают продажи, но и имеют сбалансированные показатели по скорости обработки заказа.
В свою очередь, Steven Buchanan и Anne Dodsworth показывают меньшую продуктивность, что связано как с количеством обслуженных клиентов, так и с более длительным временем обработки заказа.
*/

-- 4. Анализ повторных заказов
-- Задача: Определить клиентов с наибольшим числом заказов, используя подзапросы для выявления значимых клиентов.

SELECT 
    c.company_name,
    c.contact_name,
    order_count,
    total_spent,
    ROUND(total_spent / order_count, 2) as avg_order_value
FROM Customers c
JOIN (
    -- Подзапрос для подсчета количества заказов и общей суммы
    SELECT 
        customer_id,
        COUNT(DISTINCT o.order_id) as order_count,
        ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) as total_spent
    FROM Orders o
    JOIN Order_Details od USING (order_id)
    GROUP BY customer_id
    HAVING order_count > (
        -- Вложенный подзапрос для определения среднего количества заказов
        SELECT AVG(orders_per_customer)
        FROM (
            SELECT COUNT(order_id) as orders_per_customer
            FROM Orders
            GROUP BY customer_id
        ) avg_orders
    )
) order_stats USING (customer_id)
ORDER BY order_count DESC, total_spent DESC;


/*
Результат запроса:
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
company_name					|	contact_name		   	 | order_count  		|	total_spent	|	avg_order_value
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Save-a-lot Markets				|	Jose Pavarotti			|	31		   	|	104361.95	|	3366.51
Ernst Handel					|	Roland Mendel			|	30			|	104874.98	|	3495.83
QUICK-Stop					|	Horst Kloss			|	28			|	110277.31	|	3938.48
Hungry Owl All-Night Grocers			|	Patricia McKenna		|	19			|	49979.91	|	2630.52
Folk och fä HB					|	Maria Larsson			|	19			|	29567.56	|	1556.19
Rattlesnake Canyon Grocery			|	Paula Wilson			|	18			|	51097.8		|	2838.77
Berglunds snabbköp				|	Christina Berglund		|	18			|	24927.58	|	1384.87
HILARION-Abastos				|	Carlos Hernández		|	18			|	22768.76	|	1264.93
Bon app'					|	Laurence Lebihan		|	17			|	21963.25	|	1291.96
Frankenversand					|	Peter Franken			|	15			|	26656.56	|	1777.1
Lehmanns Marktstand				|	Renate Messner			|	15			|	19261.41	|	1284.09
Wartian Herkku					|	Pirkko Koskitalo		|	15			|	15648.7		|	1043.25
Hanari Carnes					|	Mario Pontes			|	14			|	32841.37	|	2345.81
Königlich Essen					|	Philip Cramer			|	14			|	30908.38	|	2207.74
White Clover Markets				|	Karl Jablonski			|	14			|	27363.6		|	1954.54
Bottom-Dollar Markets				|	Elizabeth Lincoln		|	14			|	20801.6		|	1485.83
LILA-Supermercado				|	Carlos González			|	14			|	16076.6		|	1148.33
La maison d'Asie				|	Annette Roulet			|	14			|	9328.2		|	666.3
Mère Paillarde					|	Jean Fresnière			|	13			|	28872.19	|	2220.94
Queen Cozinha					|	Lúcia Carvalho			|	13			|	25717.5		|	1978.27
Around the Horn					|	Thomas Hardy			|	13			|	13390.65	|	1030.05
Suprêmes délices				|	Pascale Cartrain		|	12			|	24088.78	|	2007.4
LINO-Delicateses				|	Felipe Izquierdo		|	12			|	16476.56	|	1373.05
Reggiani Caseifici				|	Maurizio Moroni			|	12			|	7048.24		|	587.35
Blondesddsl père et fils			|	Frédérique Citeaux		|	11			|	18534.08	|	1684.92
Great Lakes Food Market				|	Howard Snyder			|	11			|	18507.45	|	1682.5
Vaffeljernet					|	Palle Ibsen			|	11			|	15843.92	|	1440.36
Ricardo Adocicados				|	Janete Limeira			|	11			|	12450.8		|	1131.89
Piccolo und mehr				|	Georg Pipps			|	10			|	23128.86	|	2312.89
Richter Supermarkt				|	Michael Holz			|	10			|	19343.78	|	1934.38
Old World Delicatessen				|	Rene Phillips			|	10			|	15177.46	|	1517.75
Ottilies Käseladen				|	Henriette Pfalzheim		|	10			|	12496.2		|	1249.62
Godos Cocina Típica				|	José Pedro Freyre		|	10			|	11446.36	|	1144.64
Tortuga Restaurante				|	Miguel Angel Paolino		|	10			|	10812.15	|	1081.21
Die Wandernde Kuh				|	Rita Müller			|	10			|	9588.42		|	958.84
Victuailles en stock				|	Mary Saveley			|	10			|	9182.43		|	918.24
Magazzini Alimentari Riuniti			|	Giovanni Rovelli		|	10			|	7176.21		|	717.62
Island Trading					|	Helen Bennett			|	10			|	6146.3		|	614.63
B's Beverages					|	Victoria Ashworth		|	10			|	6089.9		|	608.99
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Выводы по 4-заданию:

- Топ-3 клиентов с наибольшим числом заказов:
1. Save-a-lot Markets (31 заказ) на сумму 104,361.95, средняя стоимость заказа 3,366.51.
2. Ernst Handel (30 заказов) на сумму 104,874.98, средняя стоимость заказа 3,495.83.
3. QUICK-Stop (28 заказов) на сумму 110,277.31, средняя стоимость заказа 3,938.48.

Эти клиенты ведут самый активный бизнес, часто размещают заказы и имеют высокие показатели по сумме покупок и средней стоимости заказа.
Среди них выделяется QUICK-Stop, у которого наибольшая средняя стоимость заказа.

Хотя у некоторых клиентов количество заказов ниже, их суммарные траты и стоимость заказов также представляют значительную ценность для компании.
*/


-- 5. Анализ географического распределения продаж.
-- Задача: Исследовать географическое распределение продаж и наиболее активные рынки.

SELECT 
    o.ship_country,
    COUNT(DISTINCT o.order_id) as total_orders,
    COUNT(DISTINCT o.customer_id) as unique_customers,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2) as total_revenue,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount)) / COUNT(DISTINCT o.order_id), 2) as avg_order_value
FROM Orders o
JOIN Order_Details od USING (order_id)
GROUP BY o.ship_country
ORDER BY total_revenue DESC;

/*
Результат запроса:
---------------------------------------------------------------------------------------------------------------------------------------------------------------
ship_country		|	total_orders 		 |  unique_customers				|	total_revenue		|	avg_order_value
---------------------------------------------------------------------------------------------------------------------------------------------------------------
USA			|	122		 	 |	13					|	245584.61		|	2012.99
Germany			|	122			 |	11					|	230284.63		|	1887.58
Austria			|	40			 |	2					|	128003.84		|	3200.1
Brazil			|	83			 |	9					|	106925.78		|	1288.26
France			|	77			 |	10					|	81358.32		|	1056.6
UK			|	56			 |	7					|	58971.31		|	1053.06
Venezuela		|	46			 |	4					|	56810.63		|	1235.01
Sweden			|	37			 |	2					|	54495.14		|	1472.84
Canada			|	30			 |	3					|	50196.29		|	1673.21
Ireland			|	19			 |	1					|	49979.91		|	2630.52
Belgium			|	19			 |	2					|	33824.86		|	1780.26
Denmark			|	18			 |	2					|	32661.02		|	1814.5
Switzerland		|	18			 |	2					|	31692.66		|	1760.7
Mexico			|	28			 |	5					|	23582.08		|	842.22
Finland			|	22			 |	2					|	18810.05		|	855
Spain			|	23			 |	4					|	17983.2			|	781.88
Italy			|	28			 |	3					|	15770.15		|	563.22
Portugal		|	13			 |	2					|	11472.36		|	882.49
Argentina		|	16			 |	3					|	8119.1			|	507.44
Norway			|	6			 |	1					|	5735.15			|	955.86
Poland			|	7			 |	1					|	3531.95			|	504.56
---------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Выводы по 5-заданию:

- Топ-3 страны с наибольшими продажами:
1. США (245,584.61): 122 заказа, 13 уникальных клиентов, средняя стоимость заказа 2,012.99.
2. Германия (230,284.63): 122 заказа, 11 уникальных клиентов, средняя стоимость заказа 1,887.58.
3. Австрия (128,003.84): 40 заказов, 2 уникальных клиента, средняя стоимость заказа 3,200.10.

США и Германия лидируют по общему объему продаж, с высокой активностью клиентов, но Австрия имеет наибольшую среднюю стоимость заказа, что может свидетельствовать о более
дорогих товарах или меньшем, но более эксклюзивном спросе.

Средняя стоимость заказа:
Страны с наибольшими средними значениями Австрия (3,200.10), Ирландия (2,630.52) и США (2,012.99) демонстрируют, что некоторые рынки склонны к более дорогим покупкам.

- Менее активные рынки:
1. Польша (3,531.95): 7 заказов, 1 уникальный клиент, средняя стоимость заказа 504.56.
2. Норвегия (5,735.15): 6 заказов, 1 уникальный клиент, средняя стоимость заказа 955.86.
*/


-- 6. Задача: Определение наиболее и наименее прибыльных товаров. Выявить товары с наивысшей и наименьшей маржинальностью.

SELECT 
    p.product_id,
    p.product_name,
    p.unit_price AS base_price,
    ROUND(AVG(od.unit_price), 2) AS avg_selling_price,
    SUM(od.quantity) AS total_quantity_sold,
    ROUND(SUM(od.quantity * od.unit_price * (1 - od.discount)), 2) AS total_revenue,
    ROUND(
        ((SUM(od.quantity * od.unit_price * (1 - od.discount)) - SUM(od.quantity * p.unit_price)) / 
        SUM(od.quantity * p.unit_price) * 100), 
        2
    ) AS profit_margin_percentage
FROM 
    Products p
    JOIN Order_Details od USING (product_id)
    JOIN Orders o USING (order_id)
WHERE 
    o.shipped_date IS NOT NULL
GROUP BY 
    p.product_id, p.product_name, p.unit_price
ORDER BY 
    profit_margin_percentage DESC;


/*
Результат запроса:
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
product_id  	| product_name				|  base_price		|   avg_selling_price			|  total_quantity_sold				|	total_revenue		|	profit_margin_percentage
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	15	| Genen Shouyu				|	13		|	14.47				|	122					|	1784.82			|		12.54
	22	| Gustaf's Knäckebröd			|	21		|	20.4				|	348					|	7122.36			|		-2.54
	7	| Uncle Bob's Organic Dried Pears	|	30		|	29.11				|	747					|	21588.3			|		-3.67
	6	| Grandma's Boysenberry Spread		|	25		|	24				|	280					|	6737.5			|		-3.75
	27	| Schoggi Schokolade			|	43.9		|	40.97				|	365					|	15099.88		|		-5.76
	12	| Queso Manchego La Pastora		|	38		|	36.83				|	342					|	12185.46		|		-6.24
	3	| Aniseed Syrup				|	10		|	9.45				|	324					|	3004			|		-7.28
	13	| Konbu					|	6		|	5.74				|	847					|	4699.44			|		-7.53
	52	| Filo Mix				|	7		|	6.75				|	498					|	3218.95			|		-7.66
	67	| Laughing Lumberjack Lager		|	14		|	13.69				|	164					|	2116.8			|		-7.8
	75	| Rhönbräu Klosterbier			|	7.75		|	7.37				|	1151					|	8146.49			|		-8.67
	41	| Jack's New England Clam Chowder	|	9.65		|	9.17				|	938					|	8265.39			|		-8.69
	73	| Röd Kaviar				|	15		|	14.31				|	291					|	3967.5			|		-9.11
	10	| Ikura					|	31		|	29.64				|	741					|	20836.34		|		-9.29
	45	| Rogede sild				|	9.5		|	9.23				|	508					|	4338.17			|		-10.11
	57	| Ravioli Angelo			|	19.5		|	18.08				|	406					|	7115.55			|		-10.12
	46	| Spegesild				|	12		|	11				|	512					|	5505.72			|		-10.39
	21	| Sir Rodney's Scones			|	10		|	9.35				|	993					|	8874			|		-10.63
	77	| Original Frankfurter grüne Soße	|	13		|	12.06				|	761					|	8836.23			|		-10.68
	76	| Lakkalikööri				|	18		|	16.96				|	979					|	15729.84		|		-10.74
	50	| Valkoinen suklaa			|	16.25		|	14.81				|	213					|	3080.19			|		-11.01
	20	| Sir Rodney's Marmalade		|	81		|	75.6				|	312					|	22485.6			|		-11.03
	24	| Guaraná Fantástica			|	4.5		|	4.22				|	1095					|	4378.36			|		-11.14
	72	| Mozzarella di Giovanni		|	34.8		|	32.04				|	806					|	24900.13		|		-11.23
	51	| Manjimup Dried Apples			|	53		|	50.49				|	862					|	40547.65		|		-11.25
	56	| Gnocchi di nonna Alice		|	38		|	35.42				|	1263					|	42593.06		|		-11.25
	34	| Sasquatch Ale				|	14		|	12.91				|	416					|	5153.4			|		-11.51
	62	| Tarte au sucre			|	49.3		|	46.41				|	1083					|	47234.97		|		-11.53
	65	| Louisiana Fiery Hot Pepper Sauce	|	21.05		|	19.46				|	745					|	13869.89		|		-11.56
	32	| Mascarpone Fabioli			|	32		|	30.63				|	296					|	8372.16			|		-11.61
	43	| Ipoh Coffee				|	46		|	42.93				|	544					|	22119.1			|		-11.61
	19	| Teatime Chocolate Biscuits		|	9.2		|	8.51				|	713					|	5793.62			|		-11.68
	40	| Boston Crab Meat			|	18.4		|	17.23				|	1103					|	17910.63		|		-11.75
	23	| Tunnbröd				|	9		|	8.34				|	578					|	4583.7			|		-11.89
	36	| Inlagd Sill				|	19		|	17.9				|	805					|	13458.46		|		-12.01
	42	| Singaporean Hokkien Fried Mee		|	14		|	13.21				|	697					|	8575			|		-12.12
	49	| Maxilaku				|	20		|	18.32				|	458					|	8004.6			|		-12.61
	68	| Scottish Longbreads			|	12.5		|	11.54				|	799					|	8714			|		-12.75
	70	| Outback Lager				|	15		|	14.13				|	805					|	10528.65		|		-12.81
	29	| Thüringer Rostbratwurst		|	123.79		|	116.04				|	746					|	80368.67		|		-12.97
	53	| Perth Pasties				|	32.8		|	30.07				|	712					|	20311.77		|		-13.03
	64	| Wimmers gute Semmelknödel		|	33.25		|	30.88				|	608					|	17570.96		|		-13.08
	33	| Geitost				|	2.5		|	2.32				|	730					|	1585.62			|		-13.12
	11	| Queso Cabrales			|	21		|	19.56				|	696					|	12691.77		|		-13.17
	28	| Rössle Sauerkraut			|	45.6		|	41.61				|	542					|	21442.16		|		-13.24
	60	| Camembert Pierrot			|	34		|	31.97				|	1504					|	44347.56		|		-13.28
	18	| Carnarvon Tigers			|	62.5		|	59.72				|	539					|	29171.87		|		-13.4
	59	| Raclette Courdavault			|	55		|	51.13				|	1496					|	71155.7			|		-13.52
	38	| Côte de Blaye				|	263.5		|	245.93				|	623					|	141396.74		|		-13.87
	39	| Chartreuse verte			|	18		|	16.63				|	791					|	12260.34		|		-13.89
	4	| Chef Anton's Cajun Seasoning		|	22		|	20.61				|	452					|	8545.9			|		-14.06
	47	| Zaanse koeken				|	9.5		|	9.14				|	485					|	3958.08			|		-14.09
	1	| Chai					|	18		|	17.12				|	788					|	12176.1			|		-14.16
	8	| Northwoods Cranberry Sauce		|	40		|	38.67				|	370					|	12700			|		-14.19
	71	| Flotemysost				|	21.5		|	19.72				|	1036					|	19099.53		|		-14.25
	14	| Tofu					|	23.25		|	21.16				|	383					|	7620.19			|		-14.43
	17	| Alice Mutton				|	39		|	36.4				|	966					|	32230.38		|		-14.45
	63	| Vegie-spread				|	43.9		|	40.79				|	445					|	16701.1			|		-14.51
	35	| Steeleye Stout			|	18		|	16.97				|	859					|	13212			|		-14.55
	69	| Gudbrandsdalsost			|	36		|	33.45				|	714					|	21942.36		|		-14.63
	31	| Gorgonzola Telino			|	12.5		|	11.65				|	1377					|	14670.87		|		-14.77
	16	| Pavlova				|	17.45		|	16.3				|	1112					|	16504.86		|		-14.94
	44	| Gula Malacca				|	19.45		|	18.13				|	601					|	9915.95			|		-15.17
	30	| Nord-Ost Matjeshering			|	25.89		|	24.22				|	608					|	13346.53		|		-15.21
	26	| Gumbär Gummibärchen			|	31.23		|	28.86				|	753					|	19849.14		|		-15.59
	54	| Tourtière				|	7.45		|	6.79				|	735					|	4616.49			|		-15.69
	5	| Chef Anton's Gumbo Mix		|	21.35		|	19.61				|	298					|	5347.2			|		-15.95
	61	| Sirop d'érable			|	28.5		|	27.76				|	599					|	14238.6			|		-16.59
	25	| NuNuCa Nuß-Nougat-Creme		|	14		|	13.07				|	318					|	3704.4			|		-16.79
	66	| Louisiana Hot Spiced Okra		|	17		|	15.06				|	238					|	3366			|		-16.81
	58	| Escargots de Bourgogne		|	13.25		|	12.66				|	534					|	5881.68			|		-16.87
	37	| Gravad lax				|	26		|	23.4				|	125					|	2688.4			|		-17.28
	74	| Longlife Tofu				|	10		|	8.77				|	297					|	2432.5			|		-18.1
	2	| Chang					|	19		|	17.76				|	995					|	15354.66		|		-18.78
	55	| Pâté chinois				|	24		|	22.35				|	901					|	17378.4			|		-19.63
	9	| Mishi Kobe Niku			|	97		|	93.12				|	95					|	7226.5			|		-21.58
	48	| Chocolade				|	12.75		|	11.9				|	138					|	1368.71			|		-22.21
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Выводы по 6-заданию:

Из всех продуктов только Genen Shouyu имеет положительную маржинальность (12.54%), что делает его прибыльным продуктом, несмотря на относительно небольшие объемы продаж.
Остальные же продукты показывают отрицательную маржу. Это может указывать на слишком низкую цену продажи или высокие затраты на производство.
Продукты с негативной маржинальностью (например, наименее прибыльные товары как Chocolade и Mishi Kobe Niku) могут нуждаться в пересмотре своей ценовой политики или стратегии
производства, чтобы избежать убытков.
*/


-- 7. Анализ скорости оборота товаров
-- Задача: Определить товары с высокой и низкой скоростью оборота на складе.

SELECT 
    p.product_name,
    p.units_in_stock,
    SUM(od.quantity) as total_sold,
    COUNT(DISTINCT o.order_id) as number_of_orders,
    ROUND(SUM(od.quantity) / DATEDIFF(MAX(o.order_date), MIN(o.order_date)) * 30, 2) as avg_monthly_sales,
    ROUND(p.units_in_stock / (SUM(od.quantity) / DATEDIFF(MAX(o.order_date), MIN(o.order_date)) * 30), 2) as months_of_stock
FROM Products p
JOIN Order_Details od USING (product_id)
JOIN Orders o USING (order_id)
WHERE p.discontinued = 0
GROUP BY p.product_id, p.product_name, p.units_in_stock
HAVING total_sold > 0
ORDER BY months_of_stock;


/*
Результат запроса:
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
product_name					|  units_in_stock			|	total_sold	|	number_of_orders  		  |  avg_monthly_sales  		|  months_of_stock
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Gorgonzola Telino				|	0				|	1397		|		51			  |  63.12				|	0.00
Sir Rodney's Scones				|	3				|	1016		|		39			  |	46.89				|	0.06
Scottish Longbreads				|	6				|	799		|		34			  |	38.91				|	0.15
Rogede sild					|	5				|	508		|		14			  |	32.02				|	0.16
Camembert Pierrot				|	19				|	1577		|		51			  |	71.04				|	0.27
Longlife Tofu					|	4				|	297		|		13			  |	14.12				|	0.28
Northwoods Cranberry Sauce			|	6				|	372		|		13			  |	20.25				|	0.30
Louisiana Hot Spiced Okra			|	4				|	239		|		8			  |	11.87				|	0.34
Tarte au sucre					|	17				|	1083		|		48			  |	50.53				|	0.34
Nord-Ost Matjeshering				|	10				|	612		|		32			  |	28.38				|	0.35
Gnocchi di nonna Alice				|	21				|	1263		|		50			  |	59.86				|	0.35
Gumbär Gummibärchen				|	15				|	753		|		32			  |	41.37				|	0.36
Mozzarella di Giovanni				|	14				|	806		|		38			  |	37.26				|	0.38
Outback Lager					|	15				|	817		|		39			  |	37.71				|	0.40
Maxilaku					|	10				|	520		|		21			  |	24.00				|	0.42
Uncle Bob's Organic Dried Pears			|	15				|	763		|		29			  |	35.05				|	0.43
Steeleye Stout					|	20				|	883		|		36			  |	41.20				|	0.49
Côte de Blaye					|	17				|	623		|		24			  |	34.04				|	0.50
Manjimup Dried Apples				|	20				|	886		|		39			  |	40.15				|	0.50
Flotemysost					|	26				|	1057		|		42			  |	50.90				|	0.51
Pavlova						|	29				|	1158		|		43			  |	52.40				|	0.55
Konbu						|	24				|	891		|		40			  |	42.03				|	0.57
Tourtière					|	21				|	755		|		36			  |	36.77				|	0.57
Wimmers gute Semmelknödel			|	22				|	740		|		30			  |	35.92				|	0.61
Ipoh Coffee					|	17				|	580		|		28			  |	27.15				|	0.63
Mascarpone Fabioli				|	9				|	297		|		15			  |	13.54				|	0.66
Queso Cabrales					|	22				|	706		|		38			  |	31.61				|	0.70
Gudbrandsdalsost				|	26				|	714		|		31			  |	36.24				|	0.72
Teatime Chocolate Biscuits			|	25				|	723		|		37			  |	34.43				|	0.73
Aniseed Syrup					|	13				|	328		|		12			  |	15.92				|	0.82
Ikura						|	31				|	742		|		33			  |	34.84				|	0.89
Original Frankfurter grüne Soße			|	32				|	791		|		38			  |	35.95				|	0.89
Gula Malacca					|	27				|	601		|		24			  |	29.17				|	0.93
Vegie-spread					|	24				|	445		|		17			  |	21.60				|	1.11
Raclette Courdavault				|	79				|	1496		|		54			  |	69.37				|	1.14
Lakkalikööri					|	57				|	981		|		39			  |	45.56				|	1.25
Zaanse koeken					|	36				|	485		|		21			  |	27.71				|	1.30
Chocolade					|	15				|	138		|		6			  |	11.28				|	1.33
Filo Mix					|	38				|	500		|		29			  |	25.91				|	1.47
Carnarvon Tigers				|	42				|	539		|		27			  |	26.68				|	1.57
Gravad lax					|	11				|	125		|		6			  |	6.15				|	1.79
Ravioli Angelo					|	36				|	434		|		23			  |	19.76				|	1.82
Tofu						|	35				|	404		|		22			  |	18.09				|	1.93
Jack's New England Clam Chowder			|	85				|	981		|		47			  |	44.12				|	1.93
Chartreuse verte				|	69				|	793		|		30			  |	35.77				|	1.93
Tunnbröd					|	61				|	580		|		20			  |	31.13				|	1.96
Escargots de Bourgogne				|	62				|	534		|		18			  |	28.56				|	2.17
Louisiana Fiery Hot Pepper Sauce		|	76				|	745		|		32			  |	34.60				|	2.20
Rhönbräu Klosterbier				|	125				|	1155		|		46			  |	55.00				|	2.27
Chef Anton's Cajun Seasoning			|	53				|	453		|		20			  |	22.88				|	2.32
Boston Crab Meat				|	123				|	1103		|		41			  |	51.70				|	2.38
Schoggi Schokolade				|	49				|	365		|		9			  |	17.72				|	2.77
Pâté chinois					|	115				|	903		|		33			  |	40.80				|	2.82
Sir Rodney's Marmalade				|	40				|	313		|		16			  |	14.10				|	2.84
Sirop d'érable					|	113				|	603		|		24			  |	38.74				|	2.92
Inlagd Sill					|	112				|	805		|		31			  |	37.50				|	2.99
Geitost						|	112				|	755		|		32			  |	34.42				|	3.25
Spegesild					|	95				|	548		|		27			  |	26.43				|	3.59
Genen Shouyu					|	39				|	122		|		6			  |	9.53				|	4.09
Sasquatch Ale					|	111				|	506		|		19			  |	24.60				|	4.51
NuNuCa Nuß-Nougat-Creme				|	76				|	318		|		18			  |	16.80				|	4.52
Valkoinen suklaa				|	65				|	235		|		10			  |	13.06				|	4.98
Queso Manchego La Pastora			|	86				|	344		|		14			  |	15.90				|	5.41
Laughing Lumberjack Lager			|	52				|	184		|		10			  |	8.95				|	5.81
Gustaf's Knäckebröd				|	104				|	348		|		14			  |	16.39				|	6.35
Röd Kaviar					|	101				|	293		|		14			  |	13.91				|	7.26
Grandma's Boysenberry Spread			|	120				|	301		|		12			  |	15.20				|	7.89
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Выводы по 7-заданию:

- Топ 3 товаров с высокой скоростью оборота (быстрые продажи):
1. Gorgonzola Telino
   Количество на складе: 0 (товар распродан). Общий объем продаж: 1397. Средняя месячная продажа: 63.12. Месяцев на складе: 0.00
2. Sir Rodney's Scones
   Количество на складе: 3. Общий объем продаж: 1016. Средняя месячная продажа: 46.89. Месяцев на складе: 0.06
3. Scottish Longbreads
   Количество на складе: 6. Общий объем продаж: 799. Средняя месячная продажа: 38.91. Месяцев на складе: 0.15

Товары с низкой скоростью оборота (медленные продажи):
1. Gustaf's Knäckebröd
   Количество на складе: 104. Общий объем продаж: 348. Средняя месячная продажа: 16.39. Месяцев на складе: 6.35
2. Röd Kaviar
   Количество на складе: 101. Общий объем продаж: 293. Средняя месячная продажа: 13.91. Месяцев на складе: 7.26.
3. Grandma's Boysenberry Spread
   Количество на складе: 120. Общий объем продаж: 301. Средняя месячная продажа: 15.20. Месяцев на складе: 7.89
   
Товары с низкой скоростью оборота требуют внимательного подхода к планированию запасов, поскольку они занимают место на складе и не приносят быстрой отдачи.

Товары с высокой скоростью оборота (например, Gorgonzola Telino) требуют более частых поставок и, возможно, более активного производства, чтобы удовлетворить спрос.
Медленно продающиеся товары (например, Gustaf's Knäckebröd) могут нуждаться в пересмотре стратегии маркетинга, скидок или даже в исключении из ассортимента для оптимизации
пространства на складе.
*/


-- 8. Динамика цен на товары
-- Задача: Анализировать изменения цен на товары, используя подзапросы для сравнения текущих и прошлых цен.

WITH PriceHistory AS (
    SELECT 
        p.product_id,
        p.product_name,
        o.order_date,
        od.unit_price as selling_price,
        p.unit_price as current_list_price,
        LAG(od.unit_price) OVER (PARTITION BY p.product_id ORDER BY o.order_date) as previous_price
    FROM Products p
    JOIN Order_Details od USING (product_id)
    JOIN Orders o USING (order_id)
)
SELECT 
    product_name,
    MIN(selling_price) as min_price,
    MAX(selling_price) as max_price,
    ROUND(AVG(selling_price), 2) as avg_price,
    current_list_price,
    ROUND(((current_list_price - MIN(selling_price)) / MIN(selling_price) * 100), 2) as price_growth_percent
FROM PriceHistory
GROUP BY product_id, product_name, current_list_price
HAVING MIN(selling_price) != MAX(selling_price)
ORDER BY price_growth_percent DESC;

/*
Результат запроса:
--------------------------------------------------------------------------------------------------------------------------
| product_name                           | min_price | max_price | avg_price | current_list_price | price_growth_percent |
|----------------------------------------|-----------|-----------|-----------|--------------------|----------------------|
| Queso Cabrales                         | 14        | 21        | 19.6      | 21                 | 50                   |
| Singaporean Hokkien Fried Mee          | 9.8       | 14        | 13.21     | 14                 | 42.86                |
| Tourtière                              | 5.9       | 7.45      | 6.8       | 7.45               | 26.27                |
| Teatime Chocolate Biscuits             | 7.3       | 9.2       | 8.53      | 9.2                | 26.03                |
| Chef Anton's Gumbo Mix                 | 17        | 21.35     | 19.61     | 21.35              | 25.59                |
| Pavlova                                | 13.9      | 17.45     | 16.38     | 17.45              | 25.54                |
| Gula Malacca                           | 15.5      | 19.45     | 18.13     | 19.45              | 25.48                |
| Gumbär Gummibärchen                    | 24.9      | 31.23     | 28.86     | 31.23              | 25.42                |
| Jack's New England Clam Chowder        | 7.7       | 9.65      | 9.19      | 9.65               | 25.32                |
| Louisiana Fiery Hot Pepper Sauce       | 16.8      | 21.05     | 19.46     | 21.05              | 25.3                 |
| Rössle Sauerkraut                      | 36.4      | 45.6      | 41.98     | 45.6               | 25.27                |
| Perth Pasties                          | 26.2      | 32.8      | 30.16     | 32.8               | 25.19                |
| Mozzarella di Giovanni                 | 27.8      | 34.8      | 32.04     | 34.8               | 25.18                |
| Boston Crab Meat                       | 14.7      | 18.4      | 17.23     | 18.4               | 25.17                |
| Tarte au sucre                         | 39.4      | 49.3      | 46.41     | 49.3               | 25.13                |
| Nord-Ost Matjeshering                  | 20.7      | 25.89     | 24.27     | 25.89              | 25.07                |
| Schoggi Schokolade                     | 35.1      | 43.9      | 40.97     | 43.9               | 25.07                |
| Vegie-spread                           | 35.1      | 43.9      | 40.79     | 43.9               | 25.07                |
| Thüringer Rostbratwurst                | 99        | 123.79    | 116.04    | 123.79             | 25.04                |
| Konbu                                  | 4.8       | 6         | 5.76      | 6                  | 25                   |
| Tofu                                   | 18.6      | 23.25     | 21.35     | 23.25              | 25                   |
| Alice Mutton                           | 31.2      | 39        | 36.47     | 39                 | 25                   |
| Carnarvon Tigers                       | 50        | 62.5      | 59.72     | 62.5               | 25                   |
| Ikura                                  | 24.8      | 31        | 29.68     | 31                 | 25                   |
| Sir Rodney's Marmalade                 | 64.8      | 81        | 75.94     | 81                 | 25                   |
| Sir Rodney's Scones                    | 8         | 10        | 9.38      | 10                 | 25                   |
| Gustaf's Knäckebröd                    | 16.8      | 21        | 20.4      | 21                 | 25                   |
| Tunnbröd                               | 7.2       | 9         | 8.37      | 9                  | 25                   |
| Guaraná Fantástica                     | 3.6       | 4.5       | 4.24      | 4.5                | 25                   |
| NuNuCa Nuß-Nougat-Creme                | 11.2      | 14        | 13.07     | 14                 | 25                   |
| Gorgonzola Telino                      | 10        | 12.5      | 11.67     | 12.5               | 25                   |
| Mascarpone Fabioli                     | 25.6      | 32        | 30.72     | 32                 | 25                   |
| Geitost                                | 2         | 2.5       | 2.33      | 2.5                | 25                   |
| Sasquatch Ale                          | 11.2      | 14        | 12.97     | 14                 | 25                   |
| Steeleye Stout                         | 14.4      | 18        | 17        | 18                 | 25                   |
| Inlagd Sill                            | 15.2      | 19        | 17.9      | 19                 | 25                   |
| Gravad lax                             | 20.8      | 26        | 23.4      | 26                 | 25                   |
| Côte de Blaye                          | 210.8     | 263.5     | 245.93    | 263.5              | 25                   |
| Chartreuse verte                       | 14.4      | 18        | 16.68     | 18                 | 25                   |
| Chang                                  | 15.2      | 19        | 17.88     | 19                 | 25                   |
| Aniseed Syrup                          | 8         | 10        | 9.5       | 10                 | 25                   |
| Ipoh Coffee                            | 36.8      | 46        | 43.04     | 46                 | 25                   |
| Chef Anton's Cajun Seasoning           | 17.6      | 22        | 20.68     | 22                 | 25                   |
| Rogede sild                            | 7.6       | 9.5       | 9.23      | 9.5                | 25                   |
| Spegesild                              | 9.6       | 12        | 11.11     | 12                 | 25                   |
| Zaanse koeken                          | 7.6       | 9.5       | 9.14      | 9.5                | 25                   |
| Chocolade                              | 10.2      | 12.75     | 11.9      | 12.75              | 25                   |
| Maxilaku                               | 16        | 20        | 18.48     | 20                 | 25                   |
| Valkoinen suklaa                       | 13        | 16.25     | 14.95     | 16.25              | 25                   |
| Manjimup Dried Apples                  | 42.4      | 53        | 50.55     | 53                 | 25                   |
| Filo Mix                               | 5.6       | 7         | 6.76      | 7                  | 25                   |
| Grandma's Boysenberry Spread           | 20        | 25        | 24.17     | 25                 | 25                   |
| Uncle Bob's Organic Dried Pears        | 24        | 30        | 29.17     | 30                 | 25                   |
| Pâté chinois                           | 19.2      | 24        | 22.4      | 24                 | 25                   |
| Gnocchi di nonna Alice                 | 30.4      | 38        | 35.42     | 38                 | 25                   |
| Ravioli Angelo                         | 15.6      | 19.5      | 18.14     | 19.5               | 25                   |
| Escargots de Bourgogne                 | 10.6      | 13.25     | 12.66     | 13.25              | 25                   |
| Raclette Courdavault                   | 44        | 55        | 51.13     | 55                 | 25                   |
| Camembert Pierrot                      | 27.2      | 34        | 32.13     | 34                 | 25                   |
| Sirop d'érable                         | 22.8      | 28.5      | 27.79     | 28.5               | 25                   |
| Northwoods Cranberry Sauce             | 32        | 40        | 38.77     | 40                 | 25                   |
| Mishi Kobe Niku                        | 77.6      | 97        | 93.12     | 97                 | 25                   |
| Wimmers gute Semmelknödel              | 26.6      | 33.25     | 31.03     | 33.25              | 25                   |
| Chai                                   | 14.4      | 18        | 17.15     | 18                 | 25                   |
| Louisiana Hot Spiced Okra              | 13.6      | 17        | 15.3      | 17                 | 25                   |
| Laughing Lumberjack Lager              | 11.2      | 14        | 13.72     | 14                 | 25                   |
| Scottish Longbreads                    | 10        | 12.5      | 11.54     | 12.5               | 25                   |
| Gudbrandsdalsost                       | 28.8      | 36        | 33.45     | 36                 | 25                   |
| Outback Lager                          | 12        | 15        | 14.15     | 15                 | 25                   |
| Flotemysost                            | 17.2      | 21.5      | 19.76     | 21.5               | 25                   |
| Queso Manchego La Pastora              | 30.4      | 38        | 36.91     | 38                 | 25                   |
| Röd Kaviar                             | 12        | 15        | 14.36     | 15                 | 25                   |
| Longlife Tofu                          | 8         | 10        | 8.77      | 10                 | 25                   |
| Rhönbräu Klosterbier                   | 6.2       | 7.75      | 7.38      | 7.75               | 25                   |
| Lakkalikööri                           | 14.4      | 18        | 16.98     | 18                 | 25                   |
| Original Frankfurter grüne Soße        | 10.4      | 13        | 12.11     | 13                 | 25                   |
| Genen Shouyu                           | 12.4      | 15.5      | 14.47     | 13                 | 4.84                 |
--------------------------------------------------------------------------------------------------------------------------


-- Выводы по 8-заданию:

Наибольший процент роста в цене показали товары:
1. Queso Cabrales
   Мин. цена: 14, Макс. цена: 21, Средняя цена: 19.6, Текущая цена: 21, Процент роста цен: 50%
2. Singaporean Hokkien Fried Mee
   Мин. цена: 9.8, Макс. цена: 14, Средняя цена: 13.21, Текущая цена: 14, Процент роста цен: 42.86%

Товары с самым высоким процентом роста цен могут указывать на увеличение цен в ответ на изменения в спросе или себестоимости.
Многие товары имеют рост цен около 25%, что может свидетельствовать о регулярном повышении цен в результате инфляции или корректировок рынка.
Товар Genen Shouyu, показывает наименьший процент роста цены (4.84%), что может означать стабилизацию цены или небольшие корректировки.


Товары с высоким ростом цен (например, Queso Cabrales) могут требовать внимательного мониторинга, чтобы избежать негативного влияния на спрос из-за слишком высоких цен.
Стоит обратить внимание на товары с стабильным ростом цен, таких как Chef Anton's Gumbo Mix и Pavlova, для анализа их позиции на рынке и выявления возможных факторов,
влияющих на увеличение цен.
*/


-- 9. Анализ наименее продаваемых товаров
-- Задача: Идентифицировать товары с низкой ротацией на складе, используя подзапросы для анализа минимальных продаж.

SELECT 
    p.product_name,
    p.units_in_stock,
    p.discontinued,
    COALESCE(sales.total_quantity, 0) as total_sold,
    COALESCE(sales.total_orders, 0) as number_of_orders,
    p.unit_price
FROM Products p
LEFT JOIN (
    SELECT 
        product_id,
        SUM(quantity) as total_quantity,
        COUNT(DISTINCT order_id) as total_orders
    FROM Order_Details
    GROUP BY product_id
) sales USING (product_id)
WHERE p.discontinued = 0
ORDER BY total_sold ASC, number_of_orders ASC;

/*
Результат запроса:
---------------------------------------------------------------------------------------------------------------------
| product_name                         | units_in_stock | discontinued | total_sold | number_of_orders | unit_price |
|--------------------------------------|----------------|--------------|------------|------------------|------------|
| Genen Shouyu                         | 39             | 0            | 122        | 6                | 13         |
| Gravad lax                           | 11             | 0            | 125        | 6                | 26         |
| Chocolade                            | 15             | 0            | 138        | 6                | 12.75      |
| Laughing Lumberjack Lager            | 52             | 0            | 184        | 10               | 14         |
| Valkoinen suklaa                     | 65             | 0            | 235        | 10               | 16.25      |
| Louisiana Hot Spiced Okra            | 4              | 0            | 239        | 8                | 17         |
| Röd Kaviar                           | 101            | 0            | 293        | 14               | 15         |
| Longlife Tofu                        | 4              | 0            | 297        | 13               | 10         |
| Mascarpone Fabioli                   | 9              | 0            | 297        | 15               | 32         |
| Grandma's Boysenberry Spread         | 120            | 0            | 301        | 12               | 25         |
| Sir Rodney's Marmalade               | 40             | 0            | 313        | 16               | 81         |
| NuNuCa Nuß-Nougat-Creme              | 76             | 0            | 318        | 18               | 14         |
| Aniseed Syrup                        | 13             | 0            | 328        | 12               | 10         |
| Queso Manchego La Pastora            | 86             | 0            | 344        | 14               | 38         |
| Gustaf's Knäckebröd                  | 104            | 0            | 348        | 14               | 21         |
| Schoggi Schokolade                   | 49             | 0            | 365        | 9                | 43.9       |
| Northwoods Cranberry Sauce           | 6              | 0            | 372        | 13               | 40         |
| Tofu                                 | 35             | 0            | 404        | 22               | 23.25      |
| Ravioli Angelo                       | 36             | 0            | 434        | 23               | 19.5       |
| Vegie-spread                         | 24             | 0            | 445        | 17               | 43.9       |
| Chef Anton's Cajun Seasoning         | 53             | 0            | 453        | 20               | 22         |
| Zaanse koeken                        | 36             | 0            | 485        | 21               | 9.5        |
| Filo Mix                             | 38             | 0            | 500        | 29               | 7          |
| Sasquatch Ale                        | 111            | 0            | 506        | 19               | 14         |
| Rogede sild                          | 5              | 0            | 508        | 14               | 9.5        |
| Maxilaku                             | 10             | 0            | 520        | 21               | 20         |
| Escargots de Bourgogne               | 62             | 0            | 534        | 18               | 13.25      |
| Carnarvon Tigers                     | 42             | 0            | 539        | 27               | 62.5       |
| Spegesild                            | 95             | 0            | 548        | 27               | 12         |
| Tunnbröd                             | 61             | 0            | 580        | 20               | 9          |
| Ipoh Coffee                          | 17             | 0            | 580        | 28               | 46         |
| Gula Malacca                         | 27             | 0            | 601        | 24               | 19.45      |
| Sirop d'érable                       | 113            | 0            | 603        | 24               | 28.5       |
| Nord-Ost Matjeshering                | 10             | 0            | 612        | 32               | 25.89      |
| Côte de Blaye                        | 17             | 0            | 623        | 24               | 263.5      |
| Queso Cabrales                       | 22             | 0            | 706        | 38               | 21         |
| Gudbrandsdalsost                     | 26             | 0            | 714        | 31               | 36         |
| Teatime Chocolate Biscuits           | 25             | 0            | 723        | 37               | 9.2        |
| Wimmers gute Semmelknödel            | 22             | 0            | 740        | 30               | 33.25      |
| Ikura                                | 31             | 0            | 742        | 33               | 31         |
| Louisiana Fiery Hot Pepper Sauce     | 76             | 0            | 745        | 32               | 21.05      |
| Gumbär Gummibärchen                  | 15             | 0            | 753        | 32               | 31.23      |
| Geitost                              | 112            | 0            | 755        | 32               | 2.5        |
| Tourtière                            | 21             | 0            | 755        | 36               | 7.45       |
| Uncle Bob's Organic Dried Pears      | 15             | 0            | 763        | 29               | 30         |
| Original Frankfurter grüne Soße      | 32             | 0            | 791        | 38               | 13         |
| Chartreuse verte                     | 69             | 0            | 793        | 30               | 18         |
| Scottish Longbreads                  | 6              | 0            | 799        | 34               | 12.5       |
| Inlagd Sill                          | 112            | 0            | 805        | 31               | 19         |
| Mozzarella di Giovanni               | 14             | 0            | 806        | 38               | 34.8       |
| Outback Lager                        | 15             | 0            | 817        | 39               | 15         |
| Steeleye Stout                       | 20             | 0            | 883        | 36               | 18         |
| Manjimup Dried Apples                | 20             | 0            | 886        | 39               | 53         |
| Konbu                                | 24             | 0            | 891        | 40               | 6          |
| Pâté chinois                         | 115            | 0            | 903        | 33               | 24         |
| Lakkalikööri                         | 57             | 0            | 981        | 39               | 18         |
| Jack's New England Clam Chowder      | 85             | 0            | 981        | 47               | 9.65       |
| Sir Rodney's Scones                  | 3              | 0            | 1016       | 39               | 10         |
| Flotemysost                          | 26             | 0            | 1057       | 42               | 21.5       |
| Tarte au sucre                       | 17             | 0            | 1083       | 48               | 49.3       |
| Boston Crab Meat                     | 123            | 0            | 1103       | 41               | 18.4       |
| Rhönbräu Klosterbier                 | 125            | 0            | 1155       | 46               | 7.75       |
| Pavlova                              | 29             | 0            | 1158       | 43               | 17.45      |
| Gnocchi di nonna Alice               | 21             | 0            | 1263       | 50               | 38         |
| Gorgonzola Telino                    | 0              | 0            | 1397       | 51               | 12.5       |
| Raclette Courdavault                 | 79             | 0            | 1496       | 54               | 55         |
| Camembert Pierrot                    | 19             | 0            | 1577       | 51               | 34         |
---------------------------------------------------------------------------------------------------------------------

-- Выводы по 9-заданию:

- Топ 3 товаров с наименьшими продажами:
1. Genen Shouyu с 122 единицами, 6 заказами.
2. Gravad lax с 125 единицами, 6 заказами.
3. Chocolade с 138 единицами, 6 заказами.

Эти товары имеют относительно низкий объем проданных единиц и количество заказов, что может указывать на их низкую популярность на рынке.

Статус продукта (discontinued): Все товары в результатах запроса находятся в активном статусе, то есть они не являются снятыми с производства. Это означает,
что компании следует пересмотреть стратегию маркетинга и продаж для этих товаров, поскольку они не имеют высокой ротации.

Цена и единицы на складе: Интересным является то, что товары с низким объемом продаж могут иметь разнообразные цены. Например:

Genen Shouyu с ценой 13.
Côte de Blaye с ценой 263.5.
Это говорит о том, что цена не всегда является ключевым фактором для продаж, и возможно, товары просто не привлекают достаточно внимания или не удовлетворяют потребности
целевой аудитории.
*/


-- 10. Влияние скидок на продажи
-- Задача: Проанализировать влияние скидок на общий объем продаж с использованием подзапросов для группировки данных по скидкам.

WITH DiscountAnalysis AS (
    SELECT 
        p.product_id,
        p.product_name,
        CASE 
            WHEN od.discount = 0 THEN 'Без скидки'
            WHEN od.discount <= 0.1 THEN 'Скидка ≤10%'
            WHEN od.discount <= 0.2 THEN 'Скидка 11-20%'
            ELSE 'Скидка >20%'
        END as discount_category,
        SUM(od.quantity) as total_quantity,
        COUNT(DISTINCT o.order_id) as number_of_orders,
        ROUND(AVG(od.quantity), 2) as avg_quantity_per_order,
        ROUND(SUM(od.quantity * od.unit_price * (1 - od.discount)), 2) as total_revenue
    FROM Products p
    JOIN Order_Details od USING (product_id)
    JOIN Orders o USING (order_id)
    GROUP BY 
        p.product_id, 
        p.product_name,
        discount_category
)

SELECT 
    discount_category,
    COUNT(DISTINCT product_name) as number_of_products,
    SUM(total_quantity) as total_quantity_sold,
    SUM(number_of_orders) as total_orders,
    ROUND(AVG(avg_quantity_per_order), 2) as avg_quantity_per_order,
    ROUND(SUM(total_revenue), 2) as total_revenue
FROM DiscountAnalysis
GROUP BY discount_category
ORDER BY 
    CASE discount_category
        WHEN 'Без скидки' THEN 1
        WHEN 'Скидка ≤10%' THEN 2
        WHEN 'Скидка 11-20%' THEN 3
        WHEN 'Скидка >20%' THEN 4
    END;
    
    
/*
Результат запроса:
-------------------------------------------------------------------------------------------------------------------------
| discount_category | number_of_products | total_quantity_sold  | total_orders | avg_quantity_per_order | total_revenue |
|-------------------|--------------------|----------------------|--------------|------------------------|---------------|
| Без скидки        | 77                 | 28599                | 1317         | 21.81                  | 750698.61     |
| Скидка ≤10%       | 64                 | 5196                 | 193          | 25.81                  | 147969.42     |
| Скидка 11-20%     | 73                 | 8822                 | 330          | 26.01                  | 179005.3      |
| Скидка >20%       | 71                 | 8700                 | 315          | 26.93                  | 188119.67     |
-------------------------------------------------------------------------------------------------------------------------

-- Выводы по 10-заданию:

Товары без скидки приносят наибольший доход и имеют высокие объемы продаж (28,599 единиц и доход 750,698.61).
Товары со скидками ≤10% продаются меньше, но среднее количество единиц на заказ остается высоким (25.81).
Товары со скидками 11-20% показывают хороший баланс между количеством продаж и доходом (8,822 единиц и 179,005.30 дохода).
Товары со скидками >20% стимулируют спрос, но результат по доходу (188,119.67) все еще ниже, чем без скидок.


Наибольший доход и объем продаж были получены от товаров без скидок, что может свидетельствовать о высокой лояльности клиентов к продуктам с установленной ценой. Тем не менее,
товары с высокими скидками (>20%) также показали хорошие результаты в продажах и доходе, что подтверждает значимость скидочной политики для стимулирования спроса. Важно отметить,
что скидки в диапазоне от 11% до 20% также демонстрируют положительное влияние на объем продаж, и это может быть оптимальным вариантом для привлечения покупателей без слишком большого
ущерба для маржи.
*/


-- 11. Анализ удовлетворенности клиентов
-- Задача: Оценить уровень удовлетворенности клиентов на основе частоты заказов и возвратов.

SELECT 
    c.customer_id,
    c.company_name,
    COUNT(o.order_id) AS total_orders,
    SUM(CASE WHEN o.shipped_date IS NULL THEN 1 ELSE 0 END) AS returns,
    ROUND((SUM(CASE WHEN o.shipped_date IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(o.order_id)), 2) AS return_rate,
    ROUND(AVG(DATEDIFF(o.required_date, o.order_date)), 2) AS avg_delivery_time
FROM 
    Customers c
    LEFT JOIN Orders o USING (customer_id)
GROUP BY 
    c.customer_id, c.company_name
HAVING 
    COUNT(o.order_id) > 5
ORDER BY 
    return_rate DESC;

/*
Результат запроса:
---------------------------------------------------------------------------------------------------------------
| customer_id | company_name                       | total_orders | returns | return_rate | avg_delivery_time |
|-------------|------------------------------------|--------------|---------|-------------|-------------------|
| GREAL       | Great Lakes Food Market            | 11           | 2       | 18.18       | 28.00             |
| CACTU       | Cactus Comidas para llevar         | 6            | 1       | 16.67       | 25.67             |
| PERIC       | Pericles Comidas clásicas          | 6            | 1       | 16.67       | 28.00             |
| BLAUS       | Blauer See Delikatessen            | 7            | 1       | 14.29       | 30.00             |
| LILAS       | LILA-Supermercado                  | 14           | 2       | 14.29       | 28.00             |
| SIMOB       | Simons bistro                      | 7            | 1       | 14.29       | 30.00             |
| RICSU       | Richter Supermarkt                 | 10           | 1       | 10.00       | 26.60             |
| RICAR       | Ricardo Adocicados                 | 11           | 1       | 9.09        | 31.82             |
| LINOD       | LINO-Delicateses                   | 12           | 1       | 8.33        | 30.33             |
| REGGC       | Reggiani Caseifici                 | 12           | 1       | 8.33        | 28.00             |
| QUEEN       | Queen Cozinha                      | 13           | 1       | 7.69        | 29.08             |
| BOTTM       | Bottom-Dollar Markets              | 14           | 1       | 7.14        | 26.00             |
| LAMAI       | La maison d'Asie                   | 14           | 1       | 7.14        | 28.00             |
| ERNSH       | Ernst Handel                       | 30           | 2       | 6.67        | 28.93             |
| LEHMS       | Lehmanns Marktstand                | 15           | 1       | 6.67        | 28.00             |
| BONAP       | Bon app'                           | 17           | 1       | 5.88        | 26.35             |
| RATTC       | Rattlesnake Canyon Grocery         | 18           | 1       | 5.56        | 28.00             |
| DRACD       | Drachenblut Delikatessen           | 6            | 0       | 0.00        | 25.67             |
| EASTC       | Eastern Connection                 | 8            | 0       | 0.00        | 26.25             |
| FAMIA       | Familia Arquibaldo                 | 7            | 0       | 0.00        | 26.00             |
| FOLKO       | Folk och fä HB                     | 19           | 0       | 0.00        | 28.74             |
| FRANK       | Frankenversand                     | 15           | 0       | 0.00        | 25.20             |
| FRANS       | Franchi S.p.A.                     | 6            | 0       | 0.00        | 28.00             |
| FURIB       | Furia Bacalhau e Frutos do Mar     | 8            | 0       | 0.00        | 28.00             |
| GODOS       | Godos Cocina Típica                | 10           | 0       | 0.00        | 28.00             |
| GOURL       | Gourmet Lanchonetes                | 9            | 0       | 0.00        | 24.89             |
| HANAR       | Hanari Carnes                      | 14           | 0       | 0.00        | 27.00             |
| HILAA       | HILARION-Abastos                   | 18           | 0       | 0.00        | 28.78             |
| HUNGO       | Hungry Owl All-Night Grocers       | 19           | 0       | 0.00        | 28.74             |
| ISLAT       | Island Trading                     | 10           | 0       | 0.00        | 26.60             |
| KOENE       | Königlich Essen                    | 14           | 0       | 0.00        | 28.00             |
| LONEP       | Lonesome Pine Restaurant           | 8            | 0       | 0.00        | 29.75             |
| MAGAA       | Magazzini Alimentari Riuniti       | 10           | 0       | 0.00        | 28.00             |
| MAISD       | Maison Dewey                       | 7            | 0       | 0.00        | 28.00             |
| MEREP       | Mère Paillarde                     | 13           | 0       | 0.00        | 31.23             |
| OLDWO       | Old World Delicatessen             | 10           | 0       | 0.00        | 30.80             |
| OTTIK       | Ottilies Käseladen                 | 10           | 0       | 0.00        | 28.00             |
| ANTON       | Antonio Moreno Taquería            | 7            | 0       | 0.00        | 28.00             |
| PICCO       | Piccolo und mehr                   | 10           | 0       | 0.00        | 28.00             |
| QUEDE       | Que Delícia                        | 9            | 0       | 0.00        | 26.44             |
| AROUT       | Around the Horn                    | 13           | 0       | 0.00        | 24.77             |
| QUICK       | QUICK-Stop                         | 28           | 0       | 0.00        | 26.00             |
| BERGS       | Berglunds snabbköp                 | 18           | 0       | 0.00        | 27.22             |
| BLONP       | Blondesddsl père et fils           | 11           | 0       | 0.00        | 29.27             |
| ALFKI       | Alfreds Futterkiste                | 6            | 0       | 0.00        | 32.67             |
| BSBEV       | B's Beverages                      | 10           | 0       | 0.00        | 28.00             |
| SANTG       | Santé Gourmet                      | 6            | 0       | 0.00        | 25.67             |
| SAVEA       | Save-a-lot Markets                 | 31           | 0       | 0.00        | 28.90             |
| SEVES       | Seven Seas Imports                 | 9            | 0       | 0.00        | 28.00             |
| CHOPS       | Chop-suey Chinese                  | 8            | 0       | 0.00        | 28.00             |
| SPLIR       | Split Rail Beer & Ale              | 9            | 0       | 0.00        | 26.44             |
| SUPRD       | Suprêmes délices                   | 12           | 0       | 0.00        | 30.33             |
| TOMSP       | Toms Spezialitäten                 | 6            | 0       | 0.00        | 30.33             |
| TORTU       | Tortuga Restaurante                | 10           | 0       | 0.00        | 23.80             |
| TRADH       | Tradição Hipermercados             | 6            | 0       | 0.00        | 30.33             |
| VAFFE       | Vaffeljernet                       | 11           | 0       | 0.00        | 24.18             |
| VICTE       | Victuailles en stock               | 10           | 0       | 0.00        | 28.00             |
| WANDK       | Die Wandernde Kuh                  | 10           | 0       | 0.00        | 29.40             |
| WARTH       | Wartian Herkku                     | 15           | 0       | 0.00        | 28.93             |
| WELLI       | Wellington Importadora             | 9            | 0       | 0.00        | 28.00             |
| WHITC       | White Clover Markets               | 14           | 0       | 0.00        | 27.00             |
| WILMK       | Wilman Kala                        | 7            | 0       | 0.00        | 30.00             |
| WOLZA       | Wolski  Zajazd                     | 7            | 0       | 0.00        | 24.00             |
---------------------------------------------------------------------------------------------------------------

-- Выводы по 11-заданию:

Большинство клиентов, делающих регулярные заказы (6 и более заказов), демонстрируют низкий уровень возвратов (0-18%), что свидетельствует о высокой удовлетворенности.
Клиенты, у которых отсутствуют возвраты, имеют высокий уровень удовлетворенности, несмотря на различное количество заказов.
В то же время, те, кто имеет более высокие проценты возвратов (например, GREAL с 18.18% возвратов), указывают на возможные проблемы с продуктами или услугами,
которые могут снижать удовлетворенность.

Среднее время доставки варьируется от 23.8 до 32.67 дней, что также может оказывать влияние на восприятие клиентами качества обслуживания. Улучшение этого показателя
может дополнительно повысить уровень удовлетворенности клиентов, особенно если снизить процент возвратов.
*/


-- 12. Разработка стратегии управления запасами
-- Задача: Разработать рекомендации для оптимизации управления запасами на основе анализа данных.

SELECT 
    p.product_id,
    p.product_name,
    p.units_in_stock,
    p.units_on_order,
    p.reorder_level,
    ROUND(AVG(od.quantity), 2) AS avg_order_quantity,
    COUNT(DISTINCT o.order_id) AS number_of_orders,
    ROUND(SUM(od.quantity) / COUNT(DISTINCT EXTRACT(MONTH FROM o.order_date)), 2) AS monthly_demand
FROM 
    Products p
    LEFT JOIN Order_Details od USING (product_id)
    LEFT JOIN Orders o USING (order_id)
GROUP BY 
    p.product_id, p.product_name, p.units_in_stock, p.units_on_order, p.reorder_level
HAVING 
    monthly_demand > 0
ORDER BY 
    (p.units_in_stock / monthly_demand) ASC;

/*
Результат запроса:
--------------------------------------------------------------------------------------------------------------------------------------------------------------
| product_id | product_name                       | units_in_stock | units_on_order | reorder_level | avg_order_quantity | number_of_orders | monthly_demand |
|------------|------------------------------------|----------------|----------------|---------------|--------------------|------------------|----------------|
| 29         | Thüringer Rostbratwurst            | 0              | 0              | 0             | 23.31              | 32               | 67.82          |
| 5          | Chef Anton's Gumbo Mix             | 0              | 0              | 0             | 29.80              | 10               | 42.57          |
| 53         | Perth Pasties                      | 0              | 0              | 0             | 24.07              | 30               | 65.64          |
| 17         | Alice Mutton                       | 0              | 0              | 0             | 26.43              | 37               | 81.50          |
| 31         | Gorgonzola Telino                  | 0              | 70             | 20            | 27.39              | 51               | 116.42         |
| 21         | Sir Rodney's Scones                | 3              | 40             | 5             | 26.05              | 39               | 92.36          |
| 68         | Scottish Longbreads                | 6              | 10             | 15            | 23.50              | 34               | 79.90          |
| 45         | Rogede sild                        | 5              | 70             | 15            | 36.29              | 14               | 56.44          |
| 74         | Longlife Tofu                      | 4              | 20             | 5             | 22.85              | 13               | 42.43          |
| 66         | Louisiana Hot Spiced Okra          | 4              | 100            | 20            | 29.88              | 8                | 39.83          |
| 8          | Northwoods Cranberry Sauce         | 6              | 0              | 0             | 28.62              | 13               | 46.50          |
| 60         | Camembert Pierrot                  | 19             | 0              | 0             | 30.92              | 51               | 131.42         |
| 2          | Chang                              | 17             | 40             | 25            | 24.02              | 44               | 96.09          |
| 7          | Uncle Bob's Organic Dried Pears    | 15             | 0              | 10            | 26.31              | 29               | 84.78          |
| 62         | Tarte au sucre                     | 17             | 0              | 0             | 22.56              | 48               | 90.25          |
| 49         | Maxilaku                           | 10             | 60             | 15            | 24.76              | 21               | 52.00          |
| 24         | Guaraná Fantástica                 | 20             | 0              | 0             | 22.06              | 51               | 102.27         |
| 30         | Nord-Ost Matjeshering              | 10             | 0              | 15            | 19.13              | 32               | 51.00          |
| 56         | Gnocchi di nonna Alice             | 21             | 10             | 30            | 25.26              | 50               | 105.25         |
| 70         | Outback Lager                      | 15             | 10             | 30            | 20.95              | 39               | 74.27          |
| 72         | Mozzarella di Giovanni             | 14             | 0              | 0             | 21.21              | 38               | 67.17          |
| 26         | Gumbär Gummibärchen                | 15             | 0              | 0             | 23.53              | 32               | 68.45          |
| 35         | Steeleye Stout                     | 20             | 0              | 15            | 24.53              | 36               | 80.27          |
| 43         | Ipoh Coffee                        | 17             | 10             | 25            | 20.71              | 28               | 64.44          |
| 13         | Konbu                              | 24             | 0              | 5             | 22.28              | 40               | 89.10          |
| 71         | Flotemysost                        | 26             | 0              | 0             | 25.17              | 42               | 96.09          |
| 51         | Manjimup Dried Apples              | 20             | 0              | 10            | 22.72              | 39               | 73.83          |
| 38         | Côte de Blaye                      | 17             | 0              | 15            | 25.96              | 24               | 62.30          |
| 16         | Pavlova                            | 29             | 0              | 10            | 26.93              | 43               | 96.50          |
| 32         | Mascarpone Fabioli                 | 9              | 40             | 25            | 19.80              | 15               | 29.70          |
| 54         | Tourtière                          | 21             | 0              | 10            | 20.97              | 36               | 68.64          |
| 64         | Wimmers gute Semmelknödel          | 22             | 80             | 30            | 24.67              | 30               | 67.27          |
| 3          | Aniseed Syrup                      | 13             | 70             | 25            | 27.33              | 12               | 36.44          |
| 11         | Queso Cabrales                     | 22             | 30             | 30            | 18.58              | 38               | 58.83          |
| 19         | Teatime Chocolate Biscuits         | 25             | 0              | 5             | 19.54              | 37               | 65.73          |
| 28         | Rössle Sauerkraut                  | 26             | 0              | 0             | 19.39              | 33               | 64.00          |
| 42         | Singaporean Hokkien Fried Mee      | 26             | 0              | 0             | 23.23              | 30               | 63.36          |
| 69         | Gudbrandsdalsost                   | 26             | 0              | 15            | 23.03              | 31               | 59.50          |
| 37         | Gravad lax                         | 11             | 50             | 25            | 20.83              | 6                | 25.00          |
| 63         | Vegie-spread                       | 24             | 0              | 5             | 26.18              | 17               | 49.44          |
| 77         | Original Frankfurter grüne Soße    | 32             | 0              | 15            | 20.82              | 38               | 65.92          |
| 44         | Gula Malacca                       | 27             | 0              | 15            | 25.04              | 24               | 54.64          |
| 10         | Ikura                              | 31             | 0              | 0             | 22.48              | 33               | 61.83          |
| 48         | Chocolade                          | 15             | 70             | 25            | 23.00              | 6                | 27.60          |
| 1          | Chai                               | 39             | 0              | 10            | 21.79              | 38               | 69.00          |
| 59         | Raclette Courdavault               | 79             | 0              | 0             | 27.70              | 54               | 124.67         |
| 76         | Lakkalikööri                       | 57             | 0              | 20            | 25.15              | 39               | 81.75          |
| 47         | Zaanse koeken                      | 36             | 0              | 0             | 23.10              | 21               | 48.50          |
| 57         | Ravioli Angelo                     | 36             | 0              | 20            | 18.87              | 23               | 43.40          |
| 18         | Carnarvon Tigers                   | 42             | 0              | 0             | 19.96              | 27               | 49.00          |
| 52         | Filo Mix                           | 38             | 0              | 25            | 17.24              | 29               | 41.67          |
| 27         | Schoggi Schokolade                 | 49             | 0              | 30            | 40.56              | 9                | 52.14          |
| 14         | Tofu                               | 35             | 0              | 0             | 18.36              | 22               | 36.73          |
| 41         | Jack's New England Clam Chowder    | 85             | 0              | 10            | 20.87              | 47               | 89.18          |
| 39         | Chartreuse verte                   | 69             | 0              | 5             | 26.43              | 30               | 66.08          |
| 23         | Tunnbröd                           | 61             | 0              | 25            | 29.00              | 20               | 58.00          |
| 65         | Louisiana Fiery Hot Pepper Sauce   | 76             | 0              | 0             | 23.28              | 32               | 67.73          |
| 20         | Sir Rodney's Marmalade             | 40             | 0              | 0             | 19.56              | 16               | 34.78          |
| 58         | Escargots de Bourgogne             | 62             | 0              | 20            | 29.67              | 18               | 53.40          |
| 4          | Chef Anton's Cajun Seasoning       | 53             | 0              | 0             | 22.65              | 20               | 45.30          |
| 9          | Mishi Kobe Niku                    | 29             | 0              | 0             | 19.00              | 5                | 23.75          |
| 40         | Boston Crab Meat                   | 123            | 0              | 30            | 26.90              | 41               | 100.27         |
| 75         | Rhönbräu Klosterbier               | 125            | 0              | 25            | 25.11              | 46               | 96.25          |
| 55         | Pâté chinois                       | 115            | 0              | 20            | 27.36              | 33               | 75.25          |
| 33         | Geitost                            | 112            | 0              | 20            | 23.59              | 32               | 68.64          |
| 50         | Valkoinen suklaa                   | 65             | 0              | 30            | 23.50              | 10               | 39.17          |
| 36         | Inlagd Sill                        | 112            | 0              | 20            | 25.97              | 31               | 67.08          |
| 25         | NuNuCa Nuß-Nougat-Creme            | 76             | 0              | 30            | 17.67              | 18               | 45.43          |
| 46         | Spegesild                          | 95             | 0              | 0             | 20.30              | 27               | 54.80          |
| 61         | Sirop d'érable                     | 113            | 0              | 25            | 25.13              | 24               | 60.30          |
| 15         | Genen Shouyu                       | 39             | 0              | 5             | 20.33              | 6                | 20.33          |
| 67         | Laughing Lumberjack Lager          | 52             | 0              | 10            | 18.40              | 10               | 26.29          |
| 12         | Queso Manchego La Pastora          | 86             | 0              | 0             | 24.57              | 14               | 43.00          |
| 34         | Sasquatch Ale                      | 111            | 0              | 15            | 26.63              | 19               | 50.60          |
| 22         | Gustaf's Knäckebröd                | 104            | 0              | 25            | 24.86              | 14               | 38.67          |
| 6          | Grandma's Boysenberry Spread       | 120            | 0              | 25            | 25.08              | 12               | 37.63          |
| 73         | Röd Kaviar                         | 101            | 0              | 5             | 20.93              | 14               | 29.30          |
--------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Выводы по 12-заданию:

Пересмотр уровней повторного заказа (Reorder Level): Продукты с низким запасом и высокой месячной потребностью, такие как "Thüringer Rostbratwurst" и "Chef Anton's Gumbo Mix",
требуют повышенной частоты заказов или коррекции уровней повторного заказа. Например, для товаров с нулевыми запасами (0 единиц на складе) и высокой потребностью в заказах,
необходимо установить более низкие уровни повторного заказа, чтобы избежать дефицита.

Обновление запасов на основе спроса: Продукты, такие как "Gorgonzola Telino" (с текущими запасами 0, но с высокой месячной потребностью 116.42), должны иметь более высокие показатели
на складе или быть на заказ в системе, чтобы удовлетворить спрос. А для товаров, таких как "Chef Anton's Cajun Seasoning" с низким спросом (45.30), можно снизить объемы запасов.

Продуктивность товара: Для товаров с низким спросом, таких как "Mishi Kobe Niku" (с 23.75 месячным спросом), следует уменьшить объемы заказов или рассмотреть возможность
оптимизации ассортимента, что поможет снизить излишки и улучшить оборот запасов.

Оптимизация сроков пополнения: Продукты с высокими запасами и частыми заказами, такие как "Jack's New England Clam Chowder" (с 89.18 месячным спросом), требуют быстрого пополнения
запасов для поддержания постоянного наличия на складе, что позволит избежать дефицита и повысить уровень удовлетворенности клиентов.

Диверсификация поставок: Для товаров с низким уровнем запаса и высокой потребностью рекомендуется установить контракты с несколькими поставщиками, чтобы уменьшить риск дефицита.
Примером таких товаров являются "Chef Anton's Gumbo Mix" и "Perth Pasties", где дефицит запасов может привести к пропущенным продажам.
*/


-- 13. Анализ возвратов
-- Задача: Проанализируйте, какие продукты и в каком количестве чаще всего возвращают и почему.

SELECT 
    p.product_id,
    p.product_name,
    c.category_name,
    COUNT(o.order_id) AS total_orders,
    SUM(CASE WHEN o.shipped_date IS NULL THEN 1 ELSE 0 END) AS returns,
    ROUND((SUM(CASE WHEN o.shipped_date IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(o.order_id)), 2) AS return_rate,
    ROUND(AVG(od.unit_price), 2) AS avg_price,
    ROUND(AVG(od.quantity), 2) AS avg_quantity
FROM 
    Products p
    JOIN Categories c USING (category_id)
    JOIN Order_Details od USING (product_id)
    JOIN Orders o USING (order_id)
GROUP BY 
    p.product_id, p.product_name, c.category_name
HAVING 
    returns > 0
ORDER BY 
    return_rate DESC;

/*
Результат запроса:
----------------------------------------------------------------------------------------------------------------------------------------
| product_id | product_name                        | category_name   | total_orders | returns | return_rate | avg_price | avg_quantity |
|------------|-------------------------------------|-----------------|--------------|---------|-------------|-----------|--------------|
| 6          | Grandma's Boysenberry Spread        | Condiments      | 12           | 2       | 16.67       | 24.17     | 25.08        |
| 66         | Louisiana Hot Spiced Okra           | Condiments      | 8            | 1       | 12.50       | 15.30     | 29.88        |
| 46         | Spegesild                           | Seafood         | 27           | 3       | 11.11       | 11.11     | 20.30        |
| 50         | Valkoinen suklaa                    | Confections     | 10           | 1       | 10.00       | 14.95     | 23.50        |
| 67         | Laughing Lumberjack Lager           | Beverages       | 10           | 1       | 10.00       | 13.72     | 18.40        |
| 49         | Maxilaku                            | Confections     | 21           | 2       | 9.52        | 18.48     | 24.76        |
| 2          | Chang                               | Beverages       | 44           | 4       | 9.09        | 17.88     | 24.02        |
| 14         | Tofu                                | Produce         | 22           | 2       | 9.09        | 21.35     | 18.36        |
| 28         | Rössle Sauerkraut                   | Produce         | 33           | 3       | 9.09        | 41.98     | 19.39        |
| 3          | Aniseed Syrup                       | Condiments      | 12           | 1       | 8.33        | 9.50      | 27.33        |
| 60         | Camembert Pierrot                   | Dairy Products  | 51           | 4       | 7.84        | 32.13     | 30.92        |
| 8          | Northwoods Cranberry Sauce          | Condiments      | 13           | 1       | 7.69        | 38.77     | 28.62        |
| 13         | Konbu                               | Seafood         | 40           | 3       | 7.50        | 5.76      | 22.28        |
| 12         | Queso Manchego La Pastora           | Dairy Products  | 14           | 1       | 7.14        | 36.91     | 24.57        |
| 73         | Röd Kaviar                          | Seafood         | 14           | 1       | 7.14        | 14.36     | 20.93        |
| 16         | Pavlova                             | Confections     | 43           | 3       | 6.98        | 16.38     | 26.93        |
| 7          | Uncle Bob's Organic Dried Pears     | Produce         | 29           | 2       | 6.90        | 29.17     | 26.31        |
| 32         | Mascarpone Fabioli                  | Dairy Products  | 15           | 1       | 6.67        | 30.72     | 19.80        |
| 64         | Wimmers gute Semmelknödel           | Grains/Cereals  | 30           | 2       | 6.67        | 31.03     | 24.67        |
| 33         | Geitost                             | Dairy Products  | 32           | 2       | 6.25        | 2.33      | 23.59        |
| 20         | Sir Rodney's Marmalade              | Confections     | 16           | 1       | 6.25        | 75.94     | 19.56        |
| 34         | Sasquatch Ale                       | Beverages       | 19           | 1       | 5.26        | 12.97     | 26.63        |
| 77         | Original Frankfurter grüne Soße     | Condiments      | 38           | 2       | 5.26        | 12.11     | 20.82        |
| 21         | Sir Rodney's Scones                 | Confections     | 39           | 2       | 5.13        | 9.38      | 26.05        |
| 4          | Chef Anton's Cajun Seasoning        | Condiments      | 20           | 1       | 5.00        | 20.68     | 22.65        |
| 23         | Tunnbröd                            | Grains/Cereals  | 20           | 1       | 5.00        | 8.37      | 29.00        |
| 57         | Ravioli Angelo                      | Grains/Cereals  | 23           | 1       | 4.35        | 18.14     | 18.87        |
| 41         | Jack's New England Clam Chowder     | Seafood         | 47           | 2       | 4.26        | 9.19      | 20.87        |
| 61         | Sirop d'érable                      | Condiments      | 24           | 1       | 4.17        | 27.79     | 25.13        |
| 24         | Guaraná Fantástica                  | Beverages       | 51           | 2       | 3.92        | 4.24      | 22.06        |
| 43         | Ipoh Coffee                         | Beverages       | 28           | 1       | 3.57        | 43.04     | 20.71        |
| 52         | Filo Mix                            | Grains/Cereals  | 29           | 1       | 3.45        | 6.76      | 17.24        |
| 53         | Perth Pasties                       | Meat/Poultry    | 30           | 1       | 3.33        | 30.16     | 24.07        |
| 39         | Chartreuse verte                    | Beverages       | 30           | 1       | 3.33        | 16.68     | 26.43        |
| 30         | Nord-Ost Matjeshering               | Seafood         | 32           | 1       | 3.13        | 24.27     | 19.13        |
| 55         | Pâté chinois                        | Meat/Poultry    | 33           | 1       | 3.03        | 22.40     | 27.36        |
| 10         | Ikura                               | Seafood         | 33           | 1       | 3.03        | 29.68     | 22.48        |
| 54         | Tourtière                           | Meat/Poultry    | 36           | 1       | 2.78        | 6.80      | 20.97        |
| 35         | Steeleye Stout                      | Beverages       | 36           | 1       | 2.78        | 17.00     | 24.53        |
| 17         | Alice Mutton                        | Meat/Poultry    | 37           | 1       | 2.70        | 36.47     | 26.43        |
| 19         | Teatime Chocolate Biscuits          | Confections     | 37           | 1       | 2.70        | 8.53      | 19.54        |
| 1          | Chai                                | Beverages       | 38           | 1       | 2.63        | 17.15     | 21.79        |
| 11         | Queso Cabrales                      | Dairy Products  | 38           | 1       | 2.63        | 19.60     | 18.58        |
| 76         | Lakkalikööri                        | Beverages       | 39           | 1       | 2.56        | 16.98     | 25.15        |
| 70         | Outback Lager                       | Beverages       | 39           | 1       | 2.56        | 14.15     | 20.95        |
| 51         | Manjimup Dried Apples               | Produce         | 39           | 1       | 2.56        | 50.55     | 22.72        |
| 71         | Flotemysost                         | Dairy Products  | 42           | 1       | 2.38        | 19.76     | 25.17        |
| 75         | Rhönbräu Klosterbier                | Beverages       | 46           | 1       | 2.17        | 7.38      | 25.11        |
| 31         | Gorgonzola Telino                   | Dairy Products  | 51           | 1       | 1.96        | 11.67     | 27.39        |
----------------------------------------------------------------------------------------------------------------------------------------

-- Выводы по 13-заданию:

-- Продукты с самым высоким уровнем возврата:
1. Grandma's Boysenberry Spread (16.67% возвратов)
   - Это продукт в категории Condiments (Приправы), с 12 заказами и 2 возвратами.
   - Высокий процент возврата может свидетельствовать о проблемах с качеством или несоответствием вкусовым ожиданиям.
2. Louisiana Hot Spiced Okra (12.50% возвратов)
   - Также относится к категории Condiments (Приправы).
   - Продукт с 8 заказами и 1 возвратом. Причины возврата могут быть связаны с особенностями вкуса или упаковки.
3. Spegesild (11.11% возвратов)
   - Это Seafood (Морепродукты) продукт с 27 заказами и 3 возвратами.
   - Высокий уровень возвратов может быть связан с плохим качеством или непредсказуемостью свежести морепродуктов при доставке.
4. Valkoinen suklaa (10.00% возвратов)
   - Confections (Кондитерские изделия), 10 заказов, 1 возврат.
   - Могут быть проблемы с упаковкой или консистенцией продукта.
5. Laughing Lumberjack Lager (10.00% возвратов)
   - Это Beverages (Напитки) с 10 заказами и 1 возвратом.
   - Высокий уровень возврата может указывать на несоответствие вкусовым предпочтениям.

*/


-- 14.Анализ географии
-- Задача: Оцените эффективность продаж по географическим регионам и влияния территорий на производительность сотрудников.

SELECT 
    r.region_description,
    COUNT(DISTINCT e.employee_id) AS num_employees,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(od.quantity * od.unit_price * (1 - od.discount)), 2) AS total_sales,
    ROUND(SUM(od.quantity * od.unit_price * (1 - od.discount)) / COUNT(DISTINCT e.employee_id), 2) AS sales_per_employee
FROM 
    Region r
    JOIN Territories t USING (region_id)
    JOIN Employee_Territories et USING (territory_id)
    JOIN Employees e USING (employee_id)
    LEFT JOIN Orders o USING (employee_id)
    LEFT JOIN Order_Details od USING (order_id)
GROUP BY 
    r.region_description
ORDER BY 
    total_sales DESC;



/*
Результат запроса:
----------------------------------------------------------------------------------------
| region_description | num_employees | total_orders | total_sales | sales_per_employee |
|--------------------|---------------|--------------|-------------|--------------------|
| Eastern            | 4             | 417          | 2730198.01  | 682549.5           |
| Western            | 2             | 139          | 1615248     | 807624             |
| Northern           | 2             | 147          | 1048605.57  | 524302.79          |
| Southern           | 1             | 127          | 811251.37   | 811251.37          |
----------------------------------------------------------------------------------------

-- Выводы по 14-заданию:

1. Западный регион оказался наиболее продуктивным с точки зрения продаж на одного сотрудника. Это указывает на высокую эффективность работы сотрудников,
несмотря на небольшое их количество. Возможно, стоит обратить внимание на то, как организована работа в этом регионе, чтобы перенести успешные практики на другие регионы.

2. Южный регион также демонстрирует высокие результаты на сотрудника, однако здесь стоит отметить, что количество сотрудников очень маленькое, и такой результат может быть
обусловлен меньшим числом заказов.

3. Восточный регион имеет наибольшие общие продажи, но на одного сотрудника результат ниже, чем у других регионов. Это может свидетельствовать о том, что хотя в этом регионе
много заказов, сотрудники могут быть менее продуктивными, чем в других регионах, что стоит проанализировать и улучшить.

4. Северный регион демонстрирует низкие продажи на одного сотрудника, что может указывать на проблемы с продуктивностью или другие факторы, влияющие на эффективность работы
сотрудников в этом регионе. Возможно, здесь нужно сосредоточиться на оптимизации работы персонала.
*/


-- 15. Анализ поставщиков
-- Задача: Исследуйте, как разные поставщики влияют на стоимость и доступность продуктов. Это может помочь в оптимизации закупок и возможно в переговорах о лучших условиях сотрудничества.

SELECT 
    s.supplier_id,
    s.company_name,
    COUNT(DISTINCT p.product_id) AS num_products,
    ROUND(AVG(p.unit_price), 2) AS avg_product_price,
    ROUND(AVG(p.units_in_stock), 2) AS avg_stock_level,
    ROUND(AVG(DATEDIFF(o.shipped_date, o.order_date)), 2) AS avg_delivery_time,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(od.quantity * od.unit_price * (1 - od.discount)), 2) AS total_sales,
    ROUND((SUM(CASE WHEN o.shipped_date IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(o.order_id)), 2) AS return_rate
FROM 
    Suppliers s
    JOIN Products p USING (supplier_id)
    LEFT JOIN Order_Details od USING (product_id)
    LEFT JOIN Orders o USING (order_id)
GROUP BY 
    s.supplier_id, s.company_name
ORDER BY 
    total_sales DESC;

/*
Результат запроса:
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| supplier_id | company_name                            | num_products | avg_product_price | avg_stock_level | avg_delivery_time | total_orders | total_sales | return_rate |
|-------------|-----------------------------------------|--------------|-------------------|-----------------|-------------------|--------------|-------------|-------------|
| 18          | Aux joyeux ecclésiastiques              | 2            | 127.11            | 45.89           | 9.51              | 53           | 153691.28   | 1.85        |
| 12          | Plutzer Lebensmittelgroßmärkte AG       | 5            | 40.86             | 47.40           | 9.07              | 161          | 145372.40   | 4.47        |
| 28          | Gai pâturage                            | 2            | 44.80             | 49.86           | 7.95              | 104          | 117981.18   | 3.81        |
| 7           | Pavlova, Ltd.                           | 5            | 31.98             | 20.70           | 8.27              | 153          | 106459.78   | 3.07        |
| 24          | G'day, Mate                             | 3            | 33.20             | 19.20           | 7.88              | 95           | 65626.77    | 3.06        |
| 29          | Forêts d'érables                        | 2            | 42.37             | 49.00           | 8.31              | 71           | 61587.57    | 1.39        |
| 8           | Specialty Biscuits, Ltd.                | 5            | 19.12             | 20.54           | 8.41              | 154          | 59032.08    | 3.05        |
| 26          | Pasta Buttini s.r.l.                    | 2            | 32.17             | 25.73           | 8.94              | 72           | 50254.61    | 1.37        |
| 14          | Formaggi Fortini s.r.l.                 | 3            | 23.46             | 6.41            | 7.65              | 96           | 48225.16    | 1.92        |
| 15          | Norske Meierier                         | 3            | 19.99             | 52.21           | 8.94              | 100          | 43141.51    | 2.86        |
| 20          | Leka Trading                            | 3            | 26.52             | 23.22           | 9.14              | 78           | 42017.65    | 1.22        |
| 3           | Grandma Kelly's Homestead               | 3            | 31.30             | 36.17           | 7.55              | 51           | 41953.30    | 9.26        |
| 11          | Heli Süßwaren GmbH & Co. KG             | 3            | 27.91             | 38.80           | 9.05              | 57           | 38653.42    | 0.00        |
| 2           | New Orleans Cajun Delights              | 4            | 20.90             | 50.34           | 8.69              | 67           | 31167.99    | 2.86        |
| 4           | Tokyo Traders                           | 3            | 32.12             | 23.92           | 9.30              | 51           | 30526.34    | 1.96        |
| 23          | Karkki Oy                               | 3            | 18.35             | 44.04           | 10.09             | 69           | 28442.73    | 5.71        |
| 19          | New England Seafood Cannery             | 2            | 13.73             | 102.70          | 8.59              | 87           | 26590.97    | 2.27        |
| 5           | Cooperativa de Quesos 'Las Cabras'      | 2            | 25.58             | 39.23           | 8.68              | 52           | 25159.43    | 3.85        |
| 16          | Bigfoot Breweries                       | 3            | 16.22             | 51.52           | 8.11              | 64           | 22391.20    | 4.62        |
| 25          | Ma Maison                               | 2            | 15.37             | 65.96           | 7.58              | 69           | 22154.64    | 2.90        |
| 17          | Svensk Sjöföda AB                       | 3            | 18.73             | 97.10           | 8.20              | 50           | 20144.06    | 1.96        |
| 1           | Exotic Liquids                          | 2            | 17.07             | 16.14           | 7.35              | 54           | 19399.96    | 8.93        |
| 6           | Mayumi's                                | 3            | 12.20             | 28.88           | 7.67              | 66           | 14736.76    | 7.35        |
| 13          | Nord-Ost-Fisch Handelsgesellschaft mbH  | 1            | 25.89             | 10.00           | 6.81              | 32           | 13424.20    | 3.13        |
| 9           | PB Knäckebröd AB                        | 2            | 13.94             | 78.71           | 7.03              | 34           | 11724.06    | 2.94        |
| 21          | Lyngbysild                              | 2            | 11.15             | 64.27           | 6.21              | 40           | 10221.18    | 7.32        |
| 27          | Escargots Nouveaux                      | 1            | 13.25             | 62.00           | 6.33              | 18           | 5881.68     | 0.00        |
| 22          | Zaanse Snoepfabriek                     | 2            | 10.22             | 31.33           | 7.85              | 27           | 5326.79     | 0.00        |
| 10          | Refrescos Americanas LTDA               | 1            | 4.50              | 20.00           | 7.67              | 51           | 4504.36     | 3.92        |
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Выводы по 15-заданию:

1. Поставщики с высоким объемом продаж:
-- Aux joyeux ecclésiastiques — несмотря на небольшое количество продуктов (2), этот поставщик демонстрирует высокий общий объем продаж (153 691.28).
Однако, у него довольно высокие средние цены на продукты (127.11), что может ограничивать покупательский спрос. Уровень возвратов у него низкий (1.85%),
что может свидетельствовать о хорошем качестве продукции.
-- Plutzer Lebensmittelgroßmärkte AG также показывает высокий объем продаж (145 372.4), несмотря на более низкие цены на продукты (40.86). Однако их уровень
возвратов несколько выше (4.47%), что требует внимания к качеству продуктов.

2. Зависимость между количеством продуктов и объемом продаж:
Поставщики с большим количеством продуктов, например, Plutzer Lebensmittelgroßmärkte AG (5 продуктов) и Pavlova, Ltd. (5 продуктов), часто имеют высокие объемы
продаж (145 372.4 и 106 459.78 соответственно). Это может свидетельствовать о том, что разнообразие ассортимента помогает увеличить продажи, хотя в некоторых случаях
это сопровождается повышением уровня возвратов (например, у Plutzer Lebensmittelgroßmärkte AG — 4.47%).

3. Средняя цена продукта и влияние на объем продаж:
-- В то время как Aux joyeux ecclésiastiques имеет самые высокие цены на продукты, его общий объем продаж также высок, что указывает на возможное присутствие в премиум-сегменте.
Поставщики с более доступными ценами, такие как Pavlova, Ltd. и G'day, Mate, показывают более умеренные продажи, но также имеют приемлемый уровень возвратов.
-- New Orleans Cajun Delights и Bigfoot Breweries предлагают продукты по низким ценам, но имеют ограниченные объемы продаж. Это может указывать на сложность спроса на более дешевые
товары или на небольшие объемы заказов.

4. Средний уровень запасов:

-- Поставщики, такие как Gai pâturage и Plutzer Lebensmittelgroßmärkte AG, с хорошим средним уровнем запасов (более 45 единиц), демонстрируют достаточно высокие объемы продаж и
количество заказов. Это может свидетельствовать о хорошем уровне обслуживания и способности удовлетворять спрос на товары.
-- В то же время поставщики с меньшими уровнями запасов, например, Escargots Nouveaux, имеют очень низкий общий объем продаж и меньший уровень возвратов (0%).

5. Среднее время доставки:
Среднее время доставки большинства поставщиков составляет около 8-9 дней, что является стандартом для большинства. Однако поставщики с коротким временем доставки (например,
Gai pâturage — 7.95 дней) могут быть более привлекательными для клиентов, стремящихся к быстрой поставке.

6. Уровень возвратов:
-- Некоторые поставщики имеют низкий уровень возвратов, например, Aux joyeux ecclésiastiques (1.85%) и Heli Süßwaren GmbH & Co. KG (0%), что свидетельствует о высоком качестве
продукции и удовлетворенности клиентов.
-- В то же время Plutzer Lebensmittelgroßmärkte AG и Karkki Oy имеют относительно высокий уровень возвратов (4.47% и 5.71%), что может быть индикатором проблем с качеством или
несоответствием ожиданий потребителей.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
*/


/*
-- ГЛАВНЫЕ ВЫВОДЫ И РЕКОМЕНДАЦИИ:
1. Объем продаж по категориям: Лидирующие категории по выручке — напитки, молочные продукты и кондитерские изделия — показывают, что разнообразие в ассортименте и маржинальность
товаров способствуют высокому доходу. Однако, для категорий с высоким средним чеком (например, мясо/птица) следует продолжать работать над повышением числа заказов для еще
большего роста.

Рекомендации:
- Фокусироваться на продвижении высокомаржинальных товаров, таких как напитки и мясо/птица.
- Внимательно следить за стабильностью поставок молочных продуктов, чтобы поддерживать их высокий спрос.

2. Сезонность продаж: Пиковые продажи приходятся на январь, март и апрель, в то время как лето традиционно отмечается снижением спроса.

Рекомендации:
- Увеличить маркетинговую активность в период пиковых месяцев, например, январь-апрель.
- Работать над стимулированием спроса в летний период через акции и скидки.

3. Эффективность работы сотрудников: Сотрудники, такие как Margaret Peacock и Janet Leverling, показывают высокую продуктивность, что связано с высоким средним чеком и количеством обслуженных клиентов.

Рекомендации:
- Применить лучшие практики эффективных сотрудников в других отделах или регионах.
- Проанализировать, как улучшить работу сотрудников с низкой продуктивностью, например, предложить дополнительные тренинги или изменить рабочие процессы.

4. Повторные заказы: Клиенты с высоким количеством заказов, такие как Save-a-lot Markets и Ernst Handel, показывают значительные объемы продаж.

Рекомендации:
- Сосредоточить внимание на удержании крупных клиентов, улучшая условия для их повторных покупок.
- Рассмотреть возможность предоставления эксклюзивных предложений или скидок для крупных клиентов.
5. Географическое распределение продаж: США и Германия являются лидерами по продажам, но Австрия демонстрирует высокие показатели по средней стоимости заказа.

Рекомендации:
- Поддерживать активность в ключевых странах и развивать новые рынки с высокой покупательной способностью, такие как Австрия.
- Важно усилить присутствие на менее активных рынках, таких как Польша и Норвегия.

6. Маржинальность товаров: Товары с отрицательной маржой требуют пересмотра ценовой политики, в то время как продукт Genen Shouyu показывает положительную маржинальность.

Рекомендации:
- Пересмотреть ценообразование на продукты с низкой маржинальностью и проанализировать возможность сокращения затрат на производство.
- Уделить внимание товарам с положительной маржой и искать способы увеличения их объемов продаж.

7. Скорость оборота товаров: Товары с высокой скоростью оборота требуют регулярных поставок, в то время как медленно продающиеся товары могут занять излишки на складе.

Рекомендации:
- Активно пополнять товары с высокой скоростью оборота.
- Пересмотреть стратегию для товаров с низкой скоростью оборота — возможно, их стоит исключить или сделать более доступными.

8. Влияние скидок на продажи: Товары без скидок приносят наибольший доход, но товары со скидками >20% также показывают хорошие результаты в продажах.

Рекомендации:
- Продолжать использовать скидки для стимулирования спроса, особенно в сезонные пики.
- Исследовать оптимальные уровни скидок для повышения маржи.

9. Возвраты товаров: Некоторые продукты, такие как Grandma's Boysenberry Spread, имеют высокий процент возвратов, что может сигнализировать о проблемах с качеством.

Рекомендации:
- Усилить контроль качества для товаров с высоким процентом возвратов.
- Проанализировать причины возвратов и внести необходимые изменения в продукт или упаковку.

10. Запасы и управление ими: Для товаров с высоким спросом и низкими запасами важно обеспечить их своевременное пополнение.

Рекомендации:
- Установить более низкие уровни повторного заказа для товаров с высокой потребностью, чтобы избежать дефицита.
- Снизить объемы заказов для товаров с низким спросом, чтобы избежать излишков на складе.

11. Анализ поставщиков: Поставщики с высоким объемом продаж, такие как Aux joyeux ecclésiastiques, показывают высокую цену, что может ограничивать спрос.

Рекомендации:
- Переговорить с поставщиками для получения более выгодных условий.
- Рассмотреть возможность диверсификации поставок для снижения цен и повышения конкурентоспособности товаров.
*/
