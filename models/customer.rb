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

end
