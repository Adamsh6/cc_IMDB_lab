require('pg')
require("pry")
require_relative('../db/sql_runner')

class Movie

  attr_accessor :title, :genre
  attr_reader :id

  def initialize(options)
    @id = options['id'] if options['id']
    @title = options['title'] 
@genre = options['genre'] 

  end

  def save
    sql = 'INSERT INTO movie (title, genre) VALUES ($1, $2) RETURNING id'
    values = [@title, @genre]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end

  def update
    sql = 'UPDATE movie SET (title, genre) = ($1, $2) WHERE id = $3'
    values = [@title, @genre, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM movie WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = 'SELECT * FROM movie WHERE id = $1'
    values = [id]
    result = SqlRunner.run(sql, values)
    return Movie.new(result[0])
  end

  def self.all
    sql = 'SELECT title, genre FROM movie'
    result = SqlRunner.run(sql)
    return self.map_items(result)
    # return result.map{ |item| Movie.new(item) }
  end

  def self.delete_all
    sql = "DELETE FROM movie"
    result = SqlRunner.run(sql)
  end

  def self.map_items(data)
    result = data.map { |data| Movie.new( data ) }
    return result
  end


end
