CREATE TABLE IF NOT EXISTS ecommerce.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
);


CREATE TABLE IF NOT EXISTS ecommerce.discount
(
    id character varying(255) NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS ecommerce.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) ,
    category_type integer,
    create_time timestamp ,
    update_time timestamp ,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
);

ALTER TABLE `ecommerce`.`product_category` 
CHANGE COLUMN `category_id` `category_id` INT NOT NULL AUTO_INCREMENT ;


CREATE TABLE IF NOT EXISTS ecommerce.product_info
(
    product_id character varying(255)  NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp ,
    product_description character varying(255) ,
    product_icon character varying(255) ,
    product_name character varying(255)  NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp ,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
);

CREATE TABLE IF NOT EXISTS ecommerce.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) ,
    email character varying(255) ,
    name character varying(255) ,
    password character varying(255) ,
    phone character varying(255) ,
    role character varying(255) ,
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
);

ALTER TABLE `ecommerce`.`users` 
CHANGE COLUMN `id` `id` BIGINT NOT NULL AUTO_INCREMENT ;



CREATE TABLE IF NOT EXISTS ecommerce.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) ,
    buyer_email character varying(255) ,
    buyer_name character varying(255) ,
    buyer_phone character varying(255) ,
    create_time timestamp,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
);

ALTER TABLE `ecommerce`.`order_main` 
CHANGE COLUMN `order_id` `order_id` BIGINT NOT NULL AUTO_INCREMENT ;



CREATE TABLE IF NOT EXISTS ecommerce.product_in_order
(
    id bigint NOT NULL AUTO_INCREMENT,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255)  NOT NULL,
    product_icon character varying(255) ,
    product_id character varying(255) ,
    product_name character varying(255) ,
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES ecommerce.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES ecommerce.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        ,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
);



CREATE TABLE IF NOT EXISTS ecommerce.wishlist
(
    id bigint NOT NULL AUTO_INCREMENT,
    created_date timestamp ,
    user_id bigint,
    product_id character varying(255),
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES ecommerce.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT user_wish_Fkey FOREIGN KEY (user_id)
        REFERENCES ecommerce.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

ALTER TABLE `ecommerce`.`discount`
ADD COLUMN user_email VARCHAR(255);

ALTER TABLE `ecommerce`.`discount` 
ADD INDEX `user_email_fkey_idx` (`user_email` ASC) VISIBLE;
;
ALTER TABLE `ecommerce`.`discount` 
ADD CONSTRAINT `user_email_fkey`
  FOREIGN KEY (`user_email`)
  REFERENCES `ecommerce`.`users` (`email`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `ecommerce`.`discount` 
DROP PRIMARY KEY;
;

ALTER TABLE `ecommerce`.`discount` 
ADD COLUMN `coupon` VARCHAR(255) NULL AFTER `user_email`,
CHANGE COLUMN `id` `id` BIGINT NOT NULL ,
ADD PRIMARY KEY (`id`);
;

ALTER TABLE `ecommerce`.`discount` 
CHANGE COLUMN `id` `id` BIGINT NOT NULL AUTO_INCREMENT ;



INSERT INTO ecommerce.product_category VALUES (2147483641, 'Idols & Figurines', 0, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_category VALUES (2147483642, 'Wall Sculptures', 1, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_category VALUES (2147483643, 'Paintings', 2, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_category VALUES (2147483644, 'Artificial Flora', 3, '2022-06-23 23:03:26', '2022-06-23 23:03:26');


INSERT INTO ecommerce.product_info VALUES ('IF01',0 , '2022-06-23 23:03:26', 'Showpieces Metal Table Top Gold Ornament for Showcase ', '/assets/images/IF01.jpg', 'Brass lord ganesh idol',800 ,0 ,60, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('IF02', 0, '2022-06-23 23:03:26', 'Showpieces Metal Table Top Gold Ornament for Showcase ', '/assets/images/IF02.jpg', 'statue of buddha',800 , 0,80, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('IF03',0 , '2022-06-23 23:03:26', ' Feng Shui Items for Positive Energy', '/assets/images/IF03.jpg', 'Showpieces Metal Table Top Gold Ornament for Showcase ', 900,0 ,7, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('IF04', 0, '2022-06-23 23:03:26', ' Statue Showpiece for Home Decor Diwali Decoration', '/assets/images/IF04.jpg', 'Showpieces Metal Table Top Gold Ornament for Showcase ',800 ,0 ,67, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('IF001', 0, '2022-06-23 23:03:26', 'Showpieces Metal Table Top Gold Ornament for Showcase', '/assets/images/IF001.jpg', 'petty peacock', 50.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('IF002', 0, '2022-06-23 23:03:26', 'Feng Shui Items for Positive Energy', '/assets/images/IF002.jpg', 'the royal elephent idol', 65.00, 0, 60, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('IF003', 0, '2022-06-23 23:03:26', 'Statue Showpiece for Home Decor Diwali Decoration and Gifting', '/assets/images/IF003.jpg', 'Polyresin Sitting Buddha Idol', 45.00, 0, 4, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('IF004', 0, '2022-06-23 23:03:26', 'Feng Shui Items for Positive Energy', '/assets/images/IF004.jpg', '3 laughing buddha idols', 65.00, 0, 60, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('IF005', 0, '2022-06-23 23:03:26', 'Statue Showpiece for Home Decor Diwali Decoration and Gifting', '/assets/images/IF005.jpg', 'gold platted horse idol', 45.00, 0, 40, '2022-06-23 23:03:26');






INSERT INTO ecommerce.product_info VALUES ('WS01',1 , '2022-06-23 23:03:26', ' Metal Lord Ganesha in Red Dhoti on Green', '/assets/images/WS01.jpg', 'woodeen framed wall sculpture', 450,0 ,80, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('WS02', 1, '2022-06-23 23:03:26', 'Handmade Hand-Painted Wall Hanging', '/assets/images/WS02.jpg', 'lady musucian wall sculpture', 53.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('WS03', 1, '2022-06-23 23:03:26', 'Multi Color Wall Arts for Home', '/assets/images/WS03.jpg', 'rays of sun metal wall sculpture', 85.00, 0, 10, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('WS04', 1, '2022-06-23 23:03:26', 'Metal Lord Ganesha in Red Dhoti on Green Leaf Wall Hanging', '/assets/images/WS04.jpg', 'horse metal wall sculpture', 45.00, 0, 50, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('WS05', 1, '2022-06-23 23:03:26', 'Handmade Hand-Painted Wall Hanging', '/assets/images/WS05.jpg', 'Designer peepeal tree led wall sculpture ', 53.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('WS06', 1, '2022-06-23 23:03:26', 'Multi Color Wall Arts for Home', '/assets/images/WS06.jpg', 'Beautiful pai of peacock canvas wall sculpture', 85.00, 0, 10, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('WS07', 1, '2022-06-23 23:03:26', 'Metal Lord Ganesha in Red Dhoti on Green Leaf Wall Hanging', '/assets/images/WS07.jpg', 'tropical age flemingo art led wall sculpture', 45.00, 0, 50, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('WS08', 1, '2022-06-23 23:03:26', 'Handmade Hand-Painted Wall Hanging', '/assets/images/WS08.jpg', 'resting ganesha royal wall sculpture', 53.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('WS09', 1, '2022-06-23 23:03:26', 'Multi Color Wall Arts for Home', '/assets/images/WS09.jpg', 'classic blue end golden metal sculpture', 85.00, 0, 10, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('WS10', 1, '2022-06-23 23:03:26', 'Metal Lord Ganesha in Red Dhoti on Green Leaf Wall Hanging', '/assets/images/WS10.jpg', 'home decore designer wall sculpture', 45.00, 0, 50, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('WS11', 1, '2022-06-23 23:03:26', 'Multi Color Wall Arts for Home', '/assets/images/WS11.jpg', 'Guitar and melodies artistic metal sculpture', 85.00, 0, 10, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('WS12', 1, '2022-06-23 23:03:26', 'Metal Lord Ganesha in Red Dhoti on Green Leaf Wall Hanging', '/assets/images/WS12.jpg', 'The iconic radha krishna led metal wall sculpture', 45.00, 0, 50, '2022-06-23 23:03:26');





INSERT INTO ecommerce.product_info VALUES ('PA001', 2, '2022-06-23 23:03:26', 'Fine Art Home Decor Metal Art & Craft Bird Ring Small with Led Light', '/assets/images/PA001.jpg', 'Sai pallavi painting', 73.00, 0, 45, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('PA002', 2, '2022-06-23 23:03:26', 'World Decor Led Couple Peacock Birds Metal Wall Art - Big, Multicolour', '/assets/images/PA002.jpg', 'Led couple peacock birds', 57.00, 0, 53, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('PA003', 2, '2022-06-23 23:03:26', 'Fine Art Home Decor Metal & MDF Art & Craft Bike Panel', '/assets/images/PA003.jpg', 'wall painting hansya dhanyapni ', 95.00, 0, 70, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('PA01', 2, '2022-06-23 23:03:26', 'Fine Art Home Decor Metal Art & Craft Bird Ring Small with Led Light', '/assets/images/PA01.jpg', 'Indian woman wall painting ', 73.00, 0, 45, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('PA02', 2, '2022-06-23 23:03:26', 'World Decor Led Couple Peacock Birds Metal Wall Art - Big, Multicolour', '/assets/images/PA02.jpg', 'Shop office wall painting', 57.00, 0, 53, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('PA03', 2, '2022-06-23 23:03:26', 'Fine Art Home Decor Metal & MDF Art & Craft Bike Panel', '/assets/images/PA03.jpg', 'Hand painted modern figure landscape ', 95.00, 0, 70, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('PA04', 2, '2022-06-23 23:03:26', 'Fine Art Home Decor Metal Art & Craft Bird Ring Small with Led Light', '/assets/images/PA04.jpg', 'Big panoramic Deer on a tree at sunset ', 73.00, 0, 45, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('PA05', 2, '2022-06-23 23:03:26', 'World Decor Led Couple Peacock Birds Metal Wall Art - Big, Multicolour', '/assets/images/PA05.jpg', 'Saumic craft set of five framed wall painting', 57.00, 0, 53, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('PA06', 2, '2022-06-23 23:03:26', 'Fine Art Home Decor Metal & MDF Art & Craft Bike Panel', '/assets/images/PA06.jpg', 'paper flowerwase framed wall art painting ', 95.00, 0, 70, '2022-06-23 23:03:26');


INSERT INTO ecommerce.product_info VALUES ('AF11', 3, '2022-06-23 23:03:26', 'unique flower- Fresh Flowers Bouquet Arrangement Indoor Plant-orchid bouquet', '/assets/images/AF11.jpg', 'Tdas artificial flower for decoration  ', 90.00, 0, 39, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('AF12', 3, '2022-06-23 23:03:26', 'Blooming Floret Artificial Cherry Orchid Flower Bunch', '/assets/images/AF12.jpg', 'Fancy mart artificial bamboo', 76.00, 0, 75, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('AF13', 3, '2022-06-23 23:03:26', 'Diwali Wedding Party Garden Craft Wall Home Door Decoration Theme', '/assets/images/AF13.jpg', 'Articial plant with pot for desk ', 82.00, 0, 20, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('AF05', 3, '2022-06-23 23:03:26', 'Diwali Wedding Party Garden Craft Wall Home Door Decoration Theme', '/assets/images/AF05.jpg', 'Artificial bodys breathe gypsophila flower sticks ', 82.00, 0, 20, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('AF06', 3, '2022-06-23 23:03:26', 'This stunning pink bouquet is a timeless arrangement � an assortment of pink roses, hellebores and peonies really encapsulate natures beauty.', '/assets/images/AF06.jpg', 'Beautiful Pair of Peacock Canvas Wall Painting ', 82.00, 0, 20, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('AF07',3 , '2022-06-23 23:03:26', ' The flowers are made up of Quality Product polyester fabric and the leaves are made of plastic', '/assets/images/AF07.jpg', 'Artificial Wisteria Vine Ratta Fake Wisteria Hanging Garland Silk Long ', 1200, 0, 800, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('AF08',3 , '2022-06-23 23:03:26', ' Orchid Flowers Can Be Use In Bouquet, Wedding Stage, Hotel, Restaurant Decoration & Outdoors Decor.', '/assets/images/AF08.jpg', ' Ryme Beautiful Purple Orchids Artificial Flowers for Home Decorations�',3800 ,0 ,800, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('AF09', 3, '2022-06-23 23:03:26', 'unique flower- Fresh Flowers Bouquet Arrangement Indoor Plant-orchid bouquet', '/assets/images/AF09.jpg', 'Artificial hanging flowers for ceiling balcony ', 90.00, 0, 39, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('AF10', 3, '2022-06-23 23:03:26', 'Blooming Floret Artificial Cherry Orchid Flower Bunch', '/assets/images/AF10.jpg', 'Decorating artificial plant with plastic pot', 76.00, 0, 75, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('AF14', 3, '2022-06-23 23:03:26', 'unique flower- Fresh Flowers Bouquet Arrangement Indoor Plant-orchid bouquet', '/assets/images/AF14.jpg', 'Artifial flower with plastic pot  ', 90.00, 0, 39, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('AF15', 3, '2022-06-23 23:03:26', 'Blooming Floret Artificial Cherry Orchid Flower Bunch', '/assets/images/AF15.jpg', 'Artificial garabara flower', 76.00, 0, 75, '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('AF16', 3, '2022-06-23 23:03:26', 'Blooming Floret Artificial Cherry Orchid Flower Bunch', '/assets/images/AF16.jpg', 'Artificial bodies breathe gypsophila flower', 76.00, 0, 75, '2022-06-23 23:03:26');








INSERT INTO ecommerce.users VALUES (2147483645, true, 'Plot 2, Shivaji Nagar, Benagluru', 'admin@eshop.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');




