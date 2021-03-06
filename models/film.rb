require('pg')
require_relative('../db/sql_runner.rb')
require_relative('ticket.rb')

class Films

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save
    sql = " INSERT INTO films
    (
    title,
    price
    )
    VALUES
    (
     $1, $2
    )
    RETURNING *
    "
    values = [@title, @price]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    films_as_objects = films.map { |film| Films.new(film)}
    return films_as_objects
  end

  def self.delete_all
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = "
    UPDATE films SET ( title, price )
    = ( $1, $2 ) WHERE id = $3
    "
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets ON tickets.customer_id = customers.id
    WHERE user_id = $1"
    values = [@id]
    customer_data = SqlRunner.run(sql, values)
    return Customers.map_items(customer_data)
  end


end
