require('pg')
require("pry")
require_relative('../db/sql_runner')

class Casting

  attr_accessor :fee, :star_id, :movie_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @fee = options['fee'] 
@star_id = options['star_id'] 
@movie_id = options['movie_id'] 

  end

  def save
    sql = 'INSERT INTO castings (fee, star_id, movie_id) VALUES ($1, $2, $3) RETURNING id'
    values = [@fee, @star_id, @movie_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end

  def update
    sql = 'UPDATE castings SET (fee, star_id, movie_id) = ($1, $2, $3) WHERE id = $4'
    values = [@fee, @star_id, @movie_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM castings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = 'SELECT * FROM castings WHERE id = $1'
    values = [id]
    result = SqlRunner.run(sql, values)
    return Casting.new(result[0])
  end

  def self.all
    sql = 'SELECT fee, star_id, movie_id FROM castings'
    result = SqlRunner.run(sql)
    return self.map_items(result)
    # return result.map{ |item| Casting.new(item) }
  end

  def self.delete_all
    sql = "DELETE FROM castings"
    result = SqlRunner.run(sql)
  end

  def self.map_items(data)
    result = data.map { |data| Casting.new( data ) }
    return result
  end


end
