#John Wartonick
#Block 

require_relative "Transaction.rb"

class Block

	attr_accessor :block

	def initialize
		@block = Array.new
	end

	def addTransaction t
		@block << t
	end

end