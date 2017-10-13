require('pg')
require_relative('../db/sql_runner.rb')
require_relative('customer.rb')
require_relative('film.rb')
require_relative('')

class Tickets

  attr_reader :id, :film_id, :customer_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options[film_id].to_i
    @customer_id = options['customer_id'].to_i
  end


end
