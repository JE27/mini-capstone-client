require 'unirest'

system 'clear'

puts "Hot Sauces for the Whole Family at Wholesale Prices"
puts "Choose an option:"
puts "      [1] See all hot sauces"
puts "      [2] Select one hot sauce"
puts "      [3] Create your own custom hot sauce"
puts "      [4] Update a hot sauce order"

input_option = gets.chomp

if input_option == "1"
  response = Unirest.get("http://localhost:3000/products")
  products = response.body
  puts JSON.pretty_generate(products)
elsif input_option == "2"
  puts "Enter a product ID"
  input_id = gets.chomp

  response = Unirest.get("http://localhost:3000/products/#{input_id}")
  product = response.body
  puts JSON.pretty_generate(product)
elsif input_option == "3"
  client_params = {}

  print "Name:  "
  client_params[:name] = gets.chomp
  print "Price:  "
  client_params[:price] = gets.chomp
  print "Ingredients:  "
  client_params[:ingredients] = gets.chomp
  print "Heat Level:  "
  client_params[:heat_level] = gets.chomp
  print "Description:  "
  client_params[:description] = gets.chomp
  print "Link to bottle image:  "
  client_params[:image_url] = gets.chomp

  response = Unirest.post(
                          'http://localhost:3000/products',
                          parameters: client_params
                          )

  product = response.body

  puts JSON.pretty_generate(product)

elsif input_option == "4"
  
end