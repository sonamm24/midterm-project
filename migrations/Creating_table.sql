CREATE TABLE users (
  id SERIAL PRIMARY KEY NOT NULL,
  register_on TIMESTAMP DEFAULT NOW(),
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

CREATE TABLE quizzes (
  id SERIAL PRIMARY KEY NOT NULL,
  owner_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  create_on TIMESTAMP DEFAULT NOW(),
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  visibility BOOLEAN DEFAULT TRUE,
  photo_url TEXT,
  category VARCHAR(255)
);

CREATE TABLE questions (
  id SERIAL PRIMARY KEY NOT NULL,
  quiz_id INTEGER REFERENCES quizzes(id) ON DELETE CASCADE,
  question TEXT NOT NULL
);

CREATE TABLE answers (
  id SERIAL PRIMARY KEY NOT NULL,
  question_id INTEGER REFERENCES questions(id) ON DELETE CASCADE,
  value TEXT NOT NULL,
  is_correct BOOLEAN NOT NULL
);


CREATE TABLE attempts (
  id SERIAL PRIMARY KEY NOT NULL,
  attempt_on TIMESTAMP DEFAULT NOW(),
  quiz_id INTEGER REFERENCES quizzes(id) ON DELETE CASCADE,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  score INTEGER
);