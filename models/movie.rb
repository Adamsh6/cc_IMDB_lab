require('pg')
require("pry")
require_relative('../db/sql_runner')

class Movie

  attr_accessor :title, :genre, :budget
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
@genre = options['genre']
@budget = options['budget']

  end

  def save
    sql = 'INSERT INTO movies (title, genre, budget) VALUES ($1, $2, $3) RETURNING id'
    values = [@title, @genre, @budget]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end

  def update
    sql = 'UPDATE movies SET (title, genre, budget) = ($1, $2, $3) WHERE id = $4'
    values = [@title, @genre, @budget, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM movies WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def stars
    sql = "SELECT stars.* FROM stars
          INNER JOIN castings
          ON stars.id = castings.star_id
          WHERE castings.movie_id = $1"
    values = [@id]
    stars = SqlRunner.run(sql, values)
    stars_array = stars.map {|star| Star.new(star)}
    return stars_array
  end

  def self.find(id)
    sql = 'SELECT * FROM movies WHERE id = $1'
    values = [id]
    result = SqlRunner.run(sql, values)
    return Movie.new(result[0])
  end

  def self.all
    sql = 'SELECT title, genre, budget FROM movies'
    result = SqlRunner.run(sql)
    return self.map_items(result)
    # return result.map{ |item| Movie.new(item) }
  end

  def self.delete_all
    sql = "DELETE FROM movies"
    result = SqlRunner.run(sql)
  end

  def self.map_items(data)
    result = data.map { |data| Movie.new( data ) }
    return result
  end


end
