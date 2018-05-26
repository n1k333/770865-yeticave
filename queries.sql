-- добавление категорий
INSERT INTO categories (id, name)
VALUES ("1", "Доски и лыжи"), ("2", "Крепления"), ("3", "Ботинки"), ("4", "Одежда"), ("5", "Инструменты"), ("6", "Разное");

-- добавление пользователей
INSERT INTO users (id, reg_date, email, name, password, avatar, contact)
VALUES ("1", "2018-05-18 13:21:15", "vladimirv87@mail.ru", "Владимир", "GbnFr6!ff", "img/vladimirv.jpg", "Russia"),
       ("2", "2018-05-18 14:47:31", "knight137@yandex.ru", "Андрей", "123456qqwr", "img/andreyk.jpg", "Russia"),
       ("3", "2018-05-19 14:52:17", "tvklimova01@gmail.com", "Татьяна", "tYbb76F4R30", "img/tvk.jpg", "Russia");

-- добавление объявлений
INSERT INTO lots (id, creation_date, name, description, image, start_price, end_date, lot_step, category_id, author_id, win_id)
VALUES ("1", "2018-05-18 09:15:46", "2014 Rossignol District Snowboard", "no description", "img/lot-1.jpg", 10999, "2018-05-30 23:59:59", 200, 1, 2, NULL),
       ("2", "2018-05-18 14:47:11", "DC Ply Mens 2016/2017 Snowboard", "no description", "img/lot-2.jpg", 159999, "2018-05-30 23:59:59", 1000, 1, 1, NULL),
       ("3", "2018-05-19 18:52:07", "Крепления Union Contact Pro 2015 года размер L/XL", "no description", "img/lot-3.jpg", 8000, "2018-05-30 23:59:59", 100, 2, 2, NULL),
       ("4", "2018-05-19 11:20:03", "Ботинки для сноуборда DC Mutiny Charocal", "no description", "img/lot-4.jpg", 10999, "2018-05-30 23:59:59", 200, 3, 3, NULL),
       ("5", "2018-05-18 08:16:57", "Куртка для сноуборда DC Mutiny Charocal", "no description", "img/lot-5.jpg", 7500, "2018-05-30 23:59:59", 100, 4, 1, NULL),
       ("6", "2018-05-19 17:50:33", "Маска Oakley Canopy", "no description", "img/lot-6.jpg", 5400, "2018-05-30 23:59:59", 100, 6, 3, NULL);

-- добавление ставок
INSERT INTO bets (date, bet_sum, user_id, lot_id)
VALUES ("2018-05-19 21:15:02", 8200, 1, 3),
       ("2018-05-18 17:25:30", 7700, 2, 5),
       ("2018-05-19 19:23:11", 162000, 3, 2);

-- выбор всех категорий (получить все категории)
SELECT id, name FROM categories;

-- выбор новых лотов (получить самые новые, открытые лоты. Каждый лот должен включать название, стартовую цену, ссылку на изображение, цену, количество ставок, название категории)

SELECT lots.name, lots.start_price, lots.image, categories.name as category, COUNT(bets.lot_id) as betCount, MAX(bets.bet_sum) + lots.lot_step as betPrice
FROM lots
INNER JOIN categories ON lots.category_id = categories.id
LEFT JOIN bets ON lots.id = bets.lot_id
WHERE lots.end_date > NOW()
GROUP BY lots.name, lots.start_price, lots.image, categories.name, lots.creation_date, lots.id
ORDER BY lots.creation_date DESC;

-- выбор лота по его id (показать лот по его id. Получение названия категории, к которой принадлежит лот)
SELECT lots.name, categories.name
FROM lots
LEFT JOIN categories ON lots.category_id = categories.id
WHERE lots.id = 2;

-- обновление лота (обновить название лота по его идентификатору)
UPDATE lots SET name = "Крепления Union Contact Pro 2015 года размер L/XL S++"
WHERE id = 3;

-- выбор свежих ставок (получить список самых свежих ставок для лота по его идентификатору;)
SELECT * FROM bets
WHERE lot_id = 2
ORDER BY date DESC;