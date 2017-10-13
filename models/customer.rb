require('pg')
require_relative('../db/sql_runner.rb')
require_relative('ticket.rb')

class Customers

attr_reader :id, :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options ['funds']
  end

  def save
    sql = "
    INSERT INTO customer
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
    @id = results[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM customer"
    values = []
    customers = SqlRunner.run(sql, values)
    customers_as_objects = customers.map { |customer| Customer.new(customer)}

  end
end
