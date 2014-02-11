CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

/* SEED DATA: */

/* users */
INSERT INTO
  users (fname, lname)
VALUES
  ('Albert', 'Einstein'),
  ('Neils', 'Bohr'),
  ('Will', 'Hastings'),
  ('Stepan', 'Parunashvili');

/* questions */
INSERT INTO
  questions(title, body, user_id)
VALUES
  ('This is a question?', 'Yes it is!',
  (SELECT id FROM users WHERE fname = 'Will')),
  ('This is my second question?', 'Yes it is my second!',
  (SELECT id FROM users WHERE fname = 'Will')),
  ('This is my third question?', 'No likes!',
  (SELECT id FROM users WHERE fname = 'Will')),
  ('This is another question?', 'Yes it is another one!',
  (SELECT id FROM users WHERE fname = 'Stepan'));

/* question followers */
INSERT INTO
  question_followers( question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE id = 1),
   (SELECT id FROM users WHERE fname = 'Albert')),
  ((SELECT id FROM questions WHERE id = 1),
   (SELECT id FROM users WHERE fname = 'Stepan')),
  ((SELECT id FROM questions WHERE id = 2),
   (SELECT id FROM users WHERE fname = 'Neils'));

/* replies */
INSERT INTO
  replies(question_id, parent_reply_id, user_id, body)
VALUES
  (1, NULL, 1, "This is a reply"),
  (1, 1, 2, "This is a child reply");

/* question_likes */
INSERT INTO
  question_likes(question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE id = 1),
   (SELECT id FROM users WHERE id = 1)),
  ((SELECT id FROM questions WHERE id = 1),
   (SELECT id FROM users WHERE id = 2)),
  ((SELECT id FROM questions WHERE id = 2),
   (SELECT id FROM users WHERE id = 4));
