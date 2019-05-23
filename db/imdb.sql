DROP TABLE IF EXISTS stars;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS castings;

CREATE TABLE stars (
  id SERIAL4 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE movies (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  genre VARCHAR(255)
);

CREATE TABLE castings (
  id SERIAL4 PRIMARY KEY,
  fee INT,
  star_id INT4 REFERENCES stars(id),
  movie_id INT4 REFERENCES movies(id)
);
