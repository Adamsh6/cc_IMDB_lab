require('pg')
require("pry")
require_relative('../db/sql_runner')

class Star

  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name'] 
@last_name = options['last_name'] 

  end

  def save
    sql = 'INSERT INTO stars (first_name, last_name) VALUES ($1, $2) RETURNING id'
    values = [@first_name, @last_name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end

  def update
    sql = 'UPDATE stars SET (first_name, last_name) = ($1, $2) WHERE id = $3'
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM stars WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = 'SELECT * FROM stars WHERE id = $1'
    values = [id]
    result = SqlRunner.run(sql, values)
    return Star.new(result[0])
  end

  def self.all
    sql = 'SELECT first_name, last_name FROM stars'
    result = SqlRunner.run(sql)
    return self.map_items(result)
    # return result.map{ |item| Star.new(item) }
  end

  def self.delete_all
    sql = "DELETE FROM stars"
    result = SqlRunner.run(sql)
  end

  def self.map_items(data)
    result = data.map { |data| Star.new( data ) }
    return result
  end


end
