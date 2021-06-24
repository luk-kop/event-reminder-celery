--SQL script for PostgreSQL

--Connect to 'reminderdb'
\c reminderdb

INSERT INTO "user" ("username", "password_hash", "email", "access_granted", "role_id", "last_seen", "creation_date", "failed_login_attempts", "pass_change_req")
VALUES ('john_doe', 'pbkdf2:sha256:150000$5b2CvGLQ$0cec90763090f8029aa7b02f15d0667a1519197beb2b5481cf42304272a29318','john_doe@niepodam.pl', True, '2', NULL, NOW()::timestamp, 0, False),
('marry', 'pbkdf2:sha256:150000$b3mHMA6y$4a5ae9b30d72b56e0d20bbd17bb0376daea34d2236524b314fca05d77f179245','marry@niepodam.pl', True, '2', NULL, NOW()::timestamp,0, False),
('test_user', 'pbkdf2:sha256:150000$EnX6y1Zd$4baa1012676b859f909441308c05d3ad2445f6ba546daebfedd17729e9380b41','test_user@niepodam.pl', True, '2',NULL, NOW()::timestamp, 0, False),
('harry', 'pbkdf2:sha256:150000$433EVzsc$1c8b90c25b4d9a8a80004e1ee32845144410a146fa36c151fe0fde5038b5f11e','harry@niepodam.pl', False, '2', NULL, NOW()::timestamp, 0, False),
('ponton', 'pbkdf2:sha256:150000$KVIJyeDn$80506687915bf7bd2e9d29ab7c0863cb229d856a47f4be32f905251258288d57','ponton@niepodam.pl', True, '2', NULL, NOW()::timestamp, 0, False),
('shrek', 'pbkdf2:sha256:150000$3hFw6hxg$4f9954488ce092a158bacad6295d776d18f2dcf8aecf13d5520063bb45c45c44','shrek@niepodam.pl', True, '2', NULL, NOW()::timestamp, 0, False),
('john.box', 'pbkdf2:sha256:150000$mJSVm88y$ee37972bcccbad6fc4402a98ade35d0c3cd37f908de6a22a60699bf1dc7b1227','john.box@niepodam.pl', True, '2', NULL, NOW()::timestamp, 0, False),
('tom.mustang', 'pbkdf2:sha256:150000$utMSYg9u$857da8b8a093e6a97573fdb223422e26dd0c449a171f030dba1a96beec03ebe0','tom.mustang@niepodam.pl', True, '2', NULL, NOW()::timestamp, 0, False),
('luk.brown', 'pbkdf2:sha256:150000$8CitcuFJ$7f26b71151731698cebc6a52be35d26c39203a1254f4ec4223de400e91b547cd','luk.brown@niepodam.pl', False, '2', NULL, NOW()::timestamp, 0, False);


INSERT INTO "event" ("title", "details", "time_creation", "all_day_event", "time_event_start", "time_event_stop", "to_notify", "time_notify", "author_uid", "notification_sent", "is_active")
VALUES ('Visit to the dentist', 'Tearing out three teeth. Doctor - John McDonald. Address - 132, Giant bird street', NOW()::timestamp - interval '2 days 2 hours', False, date_trunc('hour', NOW()::timestamp) + interval '2 days 2 hours', date_trunc('hour', NOW()::timestamp) + interval '2 days 2 hours', True, date_trunc('hour', NOW()::timestamp) + interval '1 day', 4, False, True),
('Visit to the vet', 'Vestibulum condimentum, enim vitae tempor malesuada, sem sem tempor erat, eget aliquam ex lectus at erat. Maecenas viverra blandit neque. Donec malesuada sed odio ut convallis.', NOW()::timestamp - interval '3 days 6 hours', False, date_trunc('hour', NOW()::timestamp) + interval '8 days 1 hours', date_trunc('hour', NOW()::timestamp) + interval '8 days 2 hours', True, date_trunc('hour', NOW()::timestamp) + interval '1 day', 8, False, True),
('Extension of car insurance','Aliquam et egestas enim. Nunc at nisl vitae libero sollicitudin luctus. Donec eu purus ipsum. Nam bibendum dictum dolor eu varius. Fusce quis purus consequat.', NOW()::timestamp - interval '1 days 5 hours', True, date_trunc('hour', NOW()::timestamp) + interval '10 days', date_trunc('hour', NOW()::timestamp) + interval '10 days 2 hours', True, date_trunc('hour', NOW()::timestamp) + interval '8 days',6, False, True),
('Journey to Sardinia','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam non elit sed turpis pellentesque consectetur eget non nisl. Integer dignissim, orci ornare pretium gravida, odio arcu convallis.', NOW()::timestamp - interval '1 days 2 hours', True, date_trunc('hour', NOW()::timestamp) + interval '5 days 2 hours', date_trunc('hour', NOW()::timestamp) + interval '8 days', True, date_trunc('hour', NOW()::timestamp) + interval '3 days', 8, False, True),
('Red Hat System Administration I Course','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam non elit sed turpis pellentesque consectetur eget non nisl. Integer dignissim, orci ornare pretium gravida, odio arcu convallis.', NOW()::timestamp - interval '10 days 2 hours', True, date_trunc('hour', NOW()::timestamp) + interval '3 days', date_trunc('hour', NOW()::timestamp) + interval '8 days', False, NULL, 5, True, True),
('Neque porro quisquam','Quisque facilisis venenatis nulla vulputate dictum. Cras aliquam sem sapien. Nam lobortis, erat ut porttitor sodales, sem urna sagittis turpis, quis venenatis nulla eros ac orci.', NOW()::timestamp - interval '15 days 2 hours', True, date_trunc('hour', NOW()::timestamp) - interval '15 days 2 hours', date_trunc('hour', NOW()::timestamp) - interval '13 days', True, date_trunc('hour', NOW()::timestamp) - interval '18 days', 2, True, True),
('Changing wheels in the car','Quisque facilisis venenatis nulla vulputate dictum. Cras aliquam sem sapien. Nam lobortis, erat ut porttitor sodales, sem urna sagittis turpis, quis venenatis nulla eros ac orci.', NOW()::timestamp - interval '15 days 2 hours', False, date_trunc('hour', NOW()::timestamp) - interval '4 days 5 hours', date_trunc('hour', NOW()::timestamp) - interval '4 days', True, date_trunc('hour', NOW()::timestamp) - interval '18 days', 6, True, True),
('Beer Call!','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in turpis eu nisl placerat eleifend eu sed lacus. In accumsan sapien sit amet eros dignissim, iaculis ', NOW()::timestamp - interval '2 days 2 hours', False, date_trunc('hour', NOW()::timestamp) + interval '3 hours', date_trunc('hour', NOW()::timestamp) + interval '5 hours', False, NULL, 6, True, True),
('Fridge repair','Morbi fermentum nisi eget sapien aliquam, sit amet rutrum sem scelerisque. Aliquam ultrices pretium nisl quis pharetra. Phasellus ultricies eros a.', NOW()::timestamp - interval '4 days', False, date_trunc('hour', NOW()::timestamp) - interval '4 hours', date_trunc('hour', NOW()::timestamp) - interval '2 hours', True, date_trunc('hour', NOW()::timestamp) - interval '1 day', 9, True, True),
('Aliquam venenatis justo ultrices urna pellentesque ullamcorper.','Sed tristique ligula elit, eu tempor lectus consectetur sit amet. Curabitur tempus justo et massa fringilla, ut vestibulum magna ornare. Sed et libero erat. Ut vel mauris at lectus molestie consequat.', NOW()::timestamp - interval '15 days 2 hours', False, date_trunc('hour', NOW()::timestamp) - interval '2 hours', date_trunc('hour', NOW()::timestamp) + interval '4 hours', True, date_trunc('hour', NOW()::timestamp) - interval '5 days', 10, True, True),
('Japanese encephalitis vaccination','Duis congue, urna quis ullamcorper mattis, nisl elit blandit sem, ac tempor lorem diam at sem. Phasellus purus purus, euismod eget commodo a, semper eu quam. Ut in consequat metus, ut mattis leo. ', NOW()::timestamp - interval '3 days 2 hours', False, date_trunc('hour', NOW()::timestamp) + interval '18 hours', date_trunc('hour', NOW()::timestamp) + interval '22 hours', True, date_trunc('hour', NOW()::timestamp) - interval '2 days', 4, True, True),
('CCNA R&S Exam','Aenean commodo quam eget augue blandit aliquam. Cras ex diam, bibendum ac enim sed, iaculis sollicitudin sapien. ', NOW()::timestamp - interval '9 days 2 hours', False, date_trunc('hour', NOW()::timestamp) - interval '8 days 3 hours', date_trunc('hour', NOW()::timestamp) - interval '8 days', False, NULL, 2, True, True),
('CCNA CyberOPS Exam','Quisque vitae sapien imperdiet, porttitor leo ut, auctor nulla. Pellentesque eget ipsum fermentum, pellentesque lacus ut, pharetra ex.', NOW()::timestamp - interval '5 days 2 hours', False, date_trunc('hour', NOW()::timestamp) - interval '1 day 8 hours', date_trunc('hour', NOW()::timestamp) - interval '1 day 4 hours', True, date_trunc('hour', NOW()::timestamp) - interval '7 days', 8, True, True),
('Excursion to Wejherowo','Estibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed efficitur nibh sit amet auctor consectetur. Proin tortor arcu, dapibus eu ornare sed, eleifend sed ligula.', NOW()::timestamp - interval '1 days 2 hours', False, date_trunc('hour', NOW()::timestamp) + interval '13 days', date_trunc('hour', NOW()::timestamp) + interval '14 days 4 hours', True, date_trunc('hour', NOW()::timestamp) - interval '7 days',5, False, True),
('Netflix Marathon!','Remember to buy lots of crisps and beer. The Wither is coming!', NOW()::timestamp - interval '1 days 2 hours', False, date_trunc('hour', NOW()::timestamp) - interval '2 days 2 hours', date_trunc('hour', NOW()::timestamp) + interval '1 day 4 hours', True, date_trunc('hour', NOW()::timestamp) - interval '3 days 4 hours', 7, True, True),
('Pay the bill for the accommodation!','Pellentesque a posuere sapien. Pellentesque nibh metus, posuere vitae sem vitae, varius pellentesque felis. Etiam laoreet cursus condimentum.', NOW()::timestamp - interval '1 days 2 hours', True, date_trunc('hour', NOW()::timestamp) + interval '14 days', date_trunc('hour', NOW()::timestamp) + interval '14 days', True, date_trunc('hour', NOW()::timestamp) + interval '12 days 4 hours', 2, False, True),
('Sekurak Hacking Party','Nulla eget libero a nulla malesuada scelerisque sed vel dolor. Nulla ut suscipit felis. Etiam euismod pellentesque lorem ac finibus. Vestibulum nulla enim, tincidunt id fringilla commodo, malesuada ut tellus.', NOW()::timestamp - interval '1 day 2 hours', False, date_trunc('hour', NOW()::timestamp) + interval '14 days 3 hours', date_trunc('hour', NOW()::timestamp) + interval '16 days 2 hours', True, date_trunc('hour', NOW()::timestamp) + interval '10 days', 3, False, True),
('Water grandma''s flowers','Maecenas tempor leo dui, id posuere libero maximus at.', NOW()::timestamp - interval '2 day 2 hours', False, date_trunc('hour', NOW()::timestamp) + interval '3 hours', date_trunc('hour', NOW()::timestamp) + interval '5 hours', True, date_trunc('hour', NOW()::timestamp) + interval '1 hour', 7, False, True),
('Take the neighbor''s dog for a walk','Nulla ut suscipit felis. Etiam euismod pellentesque lorem ac finibus.', NOW()::timestamp - interval '1 day 2 hours', False, date_trunc('hour', NOW()::timestamp) + interval '14 days', date_trunc('hour', NOW()::timestamp) + interval '15 days', True, NOW()::timestamp + interval '3 minutes', 6, False, True),
('Purchase materials for home improvement','Vestibulum nulla enim, tincidunt id fringilla commodo, malesuada ut tellus.', NOW()::timestamp - interval '2 hours', False, date_trunc('hour', NOW()::timestamp) + interval '5 days', date_trunc('hour', NOW()::timestamp) + interval '5 days 5 hours', True, NOW()::timestamp + interval '6 minutes', 9, False, True),
('Home NAS update','Nam libero metus, luctus quis bibendum lobortis, tristique a mauris. Pellentesque semper leo sit amet dolor semper iaculis. Donec tristique massa a tortor tempus finibus.', NOW()::timestamp - interval '23 days 10 hours', False, date_trunc('hour', NOW()::timestamp) - interval '22 days 10 hours', date_trunc('hour', NOW()::timestamp) - interval '22 days 7 hours', True, date_trunc('hour', NOW()::timestamp) - interval '22 days 16 hours',4, True, True),
('Lorem ipsum dolor sit amet','Cras molestie viverra dui in tincidunt. Vivamus scelerisque nunc in porta vestibulum.', NOW()::timestamp - interval '22 days 10 hours', True, date_trunc('hour', NOW()::timestamp) - interval '21 days', date_trunc('hour', NOW()::timestamp) - interval '19 days', True, date_trunc('hour', NOW()::timestamp) - interval '22 days 16 hours', 5, True, True),
('The oil change in the car','Fusce id dapibus sem, pellentesque ultrices orci. Pellentesque auctor odio sed lectus sagittis dapibus. Nam velit neque, accumsan ac dapibus vel, mattis vel ipsum. Mauris malesuada luctus velit, non vestibulum leo laoreet id.', NOW()::timestamp - interval '10 days 10 hours', True, date_trunc('hour', NOW()::timestamp) - interval '9 days', date_trunc('hour', NOW()::timestamp) - interval '8 days', False, NULL, 8, True, False),
('Payment for the VPS','Phasellus luctus tempus tortor, eu laoreet orci facilisis id. Suspendisse potenti. Maecenas bibendum nisi et dictum tempor.', NOW()::timestamp - interval '10 days 10 hours', True, date_trunc('hour', NOW()::timestamp) + interval '9 days', date_trunc('hour', NOW()::timestamp) + interval '10 days', False, NULL, 9, True, False),
('BTC halving day','Maecenas bibendum nisi et dictum tempor.', NOW()::timestamp - interval '10 days 9 hours', True, date_trunc('hour', NOW()::timestamp) - interval '9 days', date_trunc('hour', NOW()::timestamp) - interval '8 days', False,NULL,8, True, True),
('Dinner at the mother-in-law''s','Ut vitae vehicula mi. Proin ac quam ullamcorper, viverra orci vitae, laoreet tortor. Vestibulum lobortis, ligula in accumsan aliquet, lorem neque molestie orci, id maximus lorem augue nec erat.', NOW()::timestamp - interval '10 days 9 hours', False, date_trunc('hour', NOW()::timestamp) + interval '11 days 9 hours', date_trunc('hour', NOW()::timestamp) + interval '12 days 10 hours', True, date_trunc('hour', NOW()::timestamp) + interval '8 days 2 hours', 2, False, True),
('Visit of a mother-in-law','Ut fringilla tortor ac finibus tincidunt. In sollicitudin ultrices leo, at vehicula nisl condimentum vitae. Maecenas placerat elit quis nisl fermentum semper. Aliquam sit amet massa vel massa consequat vestibulum nec at lorem.', NOW()::timestamp - interval '11 days 9 hours', False, date_trunc('hour', NOW()::timestamp) - interval '7 days 1 hour', date_trunc('hour', NOW()::timestamp) - interval '5 days 2 hours', False, NULL, 7, True, False),
('Neque porro quisquam','Aliquam sit amet massa vel massa consequat vestibulum nec at lorem.', NOW()::timestamp - interval '11 days 9 hours', False, date_trunc('hour', NOW()::timestamp) - interval '6 days 2 hours', date_trunc('hour', NOW()::timestamp) - interval '4 days 3 hours', False, NULL, 4, True, True),
('Ut vitae vehicula mi','Curabitur aliquet pretium leo sit amet auctor. Donec dapibus, neque eget ullamcorper malesuada, purus tellus posuere risus, a rutrum tortor lacus ac turpis.', NOW()::timestamp - interval '15 days 2 hours', False, date_trunc('hour', NOW()::timestamp) - interval '13 days 4 hours', date_trunc('hour', NOW()::timestamp) - interval '11 days 1 hour', False,NULL, 10, True, True),
('Repairing garden furniture','Purus tellus posuere risus, a rutrum tortor lacus ac turpis.', NOW()::timestamp - interval '10 days 9 hours', False, date_trunc('hour', NOW()::timestamp) - interval '7 days 3 hours', date_trunc('hour', NOW()::timestamp) - interval '6 days 12 hours', False, NULL, 10, True, True),
('Visit of the plumber','Purus tellus posuere risus, a rutrum tortor lacus ac turpis.', NOW()::timestamp - interval '10 days 3 hours', False, date_trunc('hour', NOW()::timestamp) - interval '7 days', date_trunc('hour', NOW()::timestamp) - interval '6 days 20 hours', False, NULL, 10, True, True),
('Business trip to Warsaw','Vestibulum lobortis, ligula in accumsan aliquet, lorem neque molestie orci, id maximus lorem augue nec erat.', NOW()::timestamp - interval '1 day 3 hours', True, date_trunc('hour', NOW()::timestamp) + interval '9 days', date_trunc('hour', NOW()::timestamp) + interval '11 days', True, date_trunc('hour', NOW()::timestamp) + interval '7 days 2 hours',2, True, True),
('Business trip to Zakopane','Ut hendrerit et lectus in dignissim. Quisque tristique odio leo, ut maximus justo dapibus ac. Pellentesque euismod velit arcu, sed venenatis ipsum tincidunt ac. Aliquam non gravida lorem.', NOW()::timestamp - interval '10 days 3 hours', True, date_trunc('hour', NOW()::timestamp) + interval '12 days', date_trunc('hour', NOW()::timestamp) + interval '14 days', True, date_trunc('hour', NOW()::timestamp) + interval '10 days 6 hours', 5, True, True),
('Business trip to Poznan','Proin quis metus vel nunc fermentum viverra. Maecenas a lacus dapibus, consectetur quam et, auctor dui.', NOW()::timestamp - interval '14 days 6 hours', True, date_trunc('hour', NOW()::timestamp) - interval '12 days 5 hours', date_trunc('hour', NOW()::timestamp) - interval '11 days 3 hours', False, NULL, 3, False, True),
('Test event',' Maecenas a lacus dapibus, consectetur quam et, auctor dui.', NOW()::timestamp - interval '25 days 6 hours', True, date_trunc('hour', NOW()::timestamp) - interval '6 days 5 hours', date_trunc('hour', NOW()::timestamp) - interval '4 days 3 hours', False, NULL, 7, False, True);


INSERT INTO "user_to_event" ("user_id", "event_id")
VALUES (7, 1),
(6, 1),
(4, 1),
(9, 2),
(10, 2),
(4, 3),
(9, 3),
(3, 3),
(7, 4),
(7, 5),
(8, 6),
(10, 7),
(3, 7),
(8, 7),
(8, 8),
(2, 9),
(4, 9),
(8, 10),
(3, 10),
(9, 11),
(9, 12),
(9, 13),
(9, 14),
(6, 14),
(10, 14),
(5, 15),
(7, 16),
(5, 16),
(3, 16),
(6, 17),
(3, 17),
(2, 17),
(4, 18),
(6, 19),
(8, 19),
(9, 20),
(9, 21),
(5, 22),
(2, 22),
(4, 23),
(9, 24),
(4, 25),
(4, 26),
(3, 27),
(5, 27),
(4, 28),
(5, 29),
(5, 30),
(7, 30),
(5, 31),
(5, 32),
(2, 33),
(5, 33);