require('pry')
require_relative('../models/customer.rb')
require_relative('../models/film.rb')
require_relative('../models/ticket.rb')

customer_1 = Customers.new({'name' => 'John', 'funds' =>100})
customer_1.save
customer_2 = Customers.new({'name' => 'Sophie', 'funds' =>100})
customer_2.save

film_1 = Films.new({'title' => 'Batman', 'price' => 8})
film_1.save
film_2 = Films.new({'title' => 'Dunkirk', 'price' => 8})
film_2.save

ticket_1 = Tickets.new({'customer_id' => customer_1.id, 'film_id' => film_1.id})
ticket_1.save

binding.pry




nil
