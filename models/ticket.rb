require('pg')
require_relative('../db/sql_runner.rb')
require_relative('customer.rb')
require_relative('film.rb')


class Tickets

  attr_reader :id, :film_id, :customer_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
  end

  def save
    sql = "
    INSERT INTO tickets
    (
    film_id,
    customer_id
    )
    VALUES
    (
     $1, $2
    )
    RETURNING *
    "
    values = [@film_id, @customer_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all
    sql = "SELECT FROM tickets"
    values = []
    tickets = SqlRunner.run(sql, values)
    tickets_as_objects = tickets.map {|ticket| Tickets.new(ticket)}
  end

  def self.delete_all
    sql = "DELETE FROM tickets"
    values = []
    tickets = SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end



end
