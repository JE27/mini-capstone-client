require 'unirest'

response = Unirest.get('http://localhost:3000/all_products_url')

date = response.body

puts JSON.pretty_generate(data)