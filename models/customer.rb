require('pg')
require_relative('../db/sql_runner.rb')
require_relative('ticket.rb')


class Customers

attr_reader :id
attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options ['funds']
  end

  def save
    sql = "
    INSERT INTO customers
    (
    name,
    funds
    )
    VALUES
    (
     $1, $2
    )
    RETURNING *
    "
    values = [@name, @funds]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    customers_as_objects = customers.map { |customer| Customers.new(customer)}
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = " UPDATE customers SET (name, funds)
    = ( $1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets
    ON tickets.film_id = film.id WHERE user_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    return Films.map_items(film_data)
  end

end
