#John Wartonick
#transaction

class Transaction

	attr_accessor :from_address
	attr_accessor :to_address
	attr_accessor :num_billcoins_sent


	def initialize t
		temp = t.split("(")
		people = temp[0].split(">")
		@num_billcoins_sent = temp[1].split(")")[0]
		@from_address = people[0]
		@to_address = people[1]
	end

end