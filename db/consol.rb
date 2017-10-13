require('pry')
require_relative('../models/customer.rb')
require_relative('../models/film.rb')
require_relative('../models/ticket.rb')

customer_1 = Customer.new({'name' => 'John', 'funds' =>200})

customer_1.save

film_1 = Film.new({'title' => 'Batman', 'price' => 8})

film_1.save


binding.pry

nil
