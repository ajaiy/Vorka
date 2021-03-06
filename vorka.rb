#usage ruby -rubygems vorka.rb <category> <length> <number of names>
require 'json'
companies_json=IO.read "company_grouped.json"
companies=JSON.parse(companies_json)
puts "Wrong usage ruby -rubygems vorka.rb <category> <length> <number of name>" and exit if ARGV.length<3
vertical=ARGV[0]
length=ARGV[1].to_i
num_name=ARGV[2].to_i 
chain={}
companies[vertical].each do |company|
	letters=company.downcase.split(//)
	letters.each{|letter| chain[letter]||=[]}
	letters[0..-2].zip(letters[1..-1]).each{|key,value| chain[key].push(value)}
end
def generate(length,chain)
	items=chain.keys
	result=[]
	while !items.empty? and result.length < length 
		item=items.choice
		result.push item
        	items=chain[item]
	end
	return result.join.capitalize 
end
num_name.times{|i| puts generate(length,chain)}

