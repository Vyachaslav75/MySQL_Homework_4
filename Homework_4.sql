DROP DATABASE IF EXISTS lesson4;
CREATE DATABASE IF NOT EXISTS `lesson4` ;
USE lesson4;

-- создаем таблицу AUTO
CREATE TABLE  AUTO 
(       
	REGNUM VARCHAR(10) PRIMARY KEY, 
	MARK VARCHAR(10), 
	COLOR VARCHAR(15),
	RELEASEDT DATE, 
	PHONENUM VARCHAR(15)
);
-- проверяем
DESCRIBE AUTO;
-- заполняем AUTO
INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111114,'LADA', 'КРАСНЫЙ', date'2008-01-01', '9152222221');


INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111115,'VOLVO', 'КРАСНЫЙ', date'2013-01-01', '9173333334');


INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111116,'BMW', 'СИНИЙ', date'2015-01-01', '9173333334');


INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111121,'AUDI', 'СИНИЙ', date'2009-01-01', '9173333332');


INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111122,'AUDI', 'СИНИЙ', date'2011-01-01', '9213333336');


INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111113,'BMW', 'ЗЕЛЕНЫЙ', date'2007-01-01', '9214444444');


INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111126,'LADA', 'ЗЕЛЕНЫЙ', date'2005-01-01', null);


INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111117,'BMW', 'СИНИЙ', date'2005-01-01', null);


INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111119,'LADA', 'СИНИЙ', date'2017-01-01', 9213333331);
-- проверяем
SELECT * FROM AUTO;

-- Задание №1 Вывести на экран сколько машин каждого цвета для машин марок BMW и LADA
SELECT MARK, COLOR, COUNT(1)
  FROM AUTO
  WHERE MARK IN ('BMW', 'LADA')
  GROUP BY MARK, COLOR
  ORDER BY MARK;

-- Задание №2 Вывести на экран марку авто(количество) и количество авто не этой марки.
SELECT A1.MARK, A1.COUNT, A2.COUNT - A1.COUNT AS ALL_ANOTHER
  FROM (
     SELECT MARK, COUNT(1) AS COUNT
       FROM AUTO
	   GROUP BY MARK) AS A1
  CROSS JOIN (
     SELECT COUNT(1) AS COUNT
       FROM AUTO
       ) AS A2;

-- Задание №3. Напишите запрос, который вернет строки из таблицы test_a, 
-- id которых нет в таблице test_b, НЕ используя ключевого слова NOT.
CREATE TABLE test_a
  (
  id INT,
  test VARCHAR(10)
  );
  
  CREATE TABLE test_b
  (
  id INT
  );
  
  INSERT INTO test_a (id, test)
    VALUES
    (10, 'A'),
    (20, 'B'),
    (30, 'F'),
    (40, 'D'),
    (50, 'C');
    
    INSERT INTO test_b (id)
    VALUES
    (10),
    (30),
    (50);
    
    SELECT t1.id, t1.test 
      FROM test_a AS t1
      LEFT JOIN test_b AS t2
      ON t1.id = t2.id
      WHERE t2.id IS NULL;
      
      
-- Таблица 3 Заказы
-- создаем таблицу 
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	onum SERIAL PRIMARY KEY,
    amt DECIMAL(7,2),
    odate VARCHAR(15) NOT NULL,
    cnum INT NOT NULL,
    snum INT NOT NULL
);
-- проверяем
DESCRIBE orders;
-- заполняем

INSERT INTO orders (onum, amt, odate, cnum, snum) 
VALUES
  (3001, 18.69, '10/03/1990', 2008, 1007),
  (3003, 767.19, '10/03/1990', 2001, 1001),
  (3002, 1900.10, '10/03/1990', 2007, 1004),
  (3005, 5160.45, '10/03/1990', 2003, 1002),
  (3006, 1098.16, '10/03/1990', 2008, 1007),
  (3009, 1713.23, '10/04/1990', 2002, 1003),
  (3007, 75.75, '10/04/1990', 2004, 1002),
  (3008, 4723.00, '10/05/1990', 2006, 1001),
  (3010, 1309.95, '10/06/1990', 2004, 1002),
  (3011, 9891.88, '10/06/1990', 2006, 1001);
  
-- проверяем
SELECT * FROM orders;

-- смотрим какие есть столбцы
SHOW COLUMNS FROM orders;

-- переименовываем столбец odate
ALTER TABLE orders
  CHANGE odate odatetxt VARCHAR(15);
  
-- смотрим результат
SHOW COLUMNS FROM orders;

-- добавляем столбец odate типа DATE
ALTER TABLE orders 
  ADD COLUMN odate DATE AFTER amt;
  
-- смотрим результат  
SHOW COLUMNS FROM orders;

-- заполняем столбец odate
UPDATE orders
  SET odate = STR_TO_DATE(odatetxt, '%m/%d/%Y')
  WHERE odatetxt IS NOT NULL;
  
-- смотрим результат
SELECT * FROM orders;

-- удаляем столбец odatetxt
ALTER TABLE orders
  DROP COLUMN odatetxt;
  
-- смотрим результат  
SHOW COLUMNS FROM orders;

-- смотрим результат
SELECT * FROM orders;