require('pg')
require_relative('../db/sql_runner.rb')
require_relative('customer.rb')
require_relative('film.rb')


class Ticket

  attr_reader :id, :film_id, :customer_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options[film_id].to_i
    @customer_id = options['customer_id'].to_i
  end

  def save
    sql = "
    INSERT INTO tickets
    (
    film_id,
    customer_id
    )
    (
    VALUES $1, $2
    )
    RETURNING *
    "
    values = []
    results = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all
    sql = "SELECT FROM tickets"
    values = []
    tickets = SqlRunner.run(sql, values)
    tickets_as_objects = ticket.map {|ticket| Ticket.new(ticket)}
  end




end
