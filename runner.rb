require 'unirest'

system 'clear'

puts "Hot Sauces for the Whole Family at Wholesale Prices"
puts "Choose an option:"
puts "      [1] See all hot sauces"
puts "      [2] Select one hot sauce"
puts "      [3] Create your own custom hot sauce"
puts "      [4] Update a hot sauce order"
puts "      [5] Delete an order. Cannot be undone!"

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
  print "In Stock: "
  client_params[:in_stock] = gets.chomp
  print "Link to bottle image:  "
  client_params[:image_url] = gets.chomp

  response = Unirest.post(
                          'http://localhost:3000/products',
                          parameters: client_params
                          )

  product = response.body

  puts JSON.pretty_generate(product)

elsif input_option == "4"
  print "Enter product ID: "
  input_id = gets.chomp

  response = Unirest.get("http://localhost:3000/products/#{input_id}")
  product = response.body

  print "Name: (#{product["name"]})"
  client_params[:name] = gets.chomp
  print "Price: (#{product["price"]})"
  client_params[:price] = gets.chomp
  print "Ingredients: (#{product["ingredients"]})"
  client_params[:ingredients] = gets.chomp
  print "Heat Level: (#{product["heat_level"]})"
  client_params[:heat_level] = gets.chomp
  print "Description: (#{product["description"]})"
  client_params[:description] = gets.chomp
  print "In Stock: (#{product["in_stock"]})"
  client_params[:in_stock] = gets.chomp
  print "Link to bottle image: (#{product["image_url"]})"
  client_params[:image_url] = gets.chomp

  client_params.delete_if { |key, value| value.empty? }

  response = Unirest.patch(
                            'http://localhost:3000/products/#{input_id}',
                            parameters: client_params
                          )

product = response.body
puts JSON.pretty_generate(product)

elsif input_option == "5"
  print "Enter a product ID of product you want to delete:"
  input_id = gets.chomp

  response = Unirest.delete("http://localhost:3000/products/#{input_id}")

  product = response.body
  puts product["message"]
end
