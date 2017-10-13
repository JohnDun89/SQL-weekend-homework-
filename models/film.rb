require('pg')
require_relative('../db/sql_runner.rb')
require_relative('ticket.rb')

class Films

  attr_reader :id, :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save
    sql = " INSERT INTO  films
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



end
