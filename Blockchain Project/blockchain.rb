#John Wartonick
#blockchain 

require_relative "Hash.rb"
require_relative "Time.rb"
require_relative "Block.rb"
require_relative "Transaction.rb"

class Blockchain

	def checkCurrentHash block, values
		str = block[0..block.length - (values[values.length - 1].length + 2)] # +2 to account for the "\n" at the end of the line

		x = Array.new
		x += str.unpack('U*')

		hash_val = 0

		x.each {|i| hash_val += (i**2000) * ((i + 2)**21) - ((i + 5)**3)}
		f_hash = hash_val % 65536

		computed_hash = f_hash.to_s(16)
		current_hash = values[values.length - 1].strip

		raise "Line #{values[0]}: String '#{block}' hash set to #{current_hash}, should be #{computed_hash}\nBLOCKCHAIN INVALID" unless current_hash == computed_hash
	end
	def checkPrevHash prev, cur
		prev_hash = prev[prev.length - 1].strip
		cur_hash = cur[1]

		raise "Line #{cur[0]}: Previous hash was #{cur_hash}, should be #{prev_hash}\nBLOCKCHAIN INVALID" unless cur_hash == prev_hash
		
	end

	def checkOrder block_number, i
		raise "Line #{i}: Invalid block number #{block_number}, should be #{i}\nBLOCKCHAIN INVALID" unless block_number == i 
	end

	def checkTime cur_time, prev_time, i
		
		split_time = prev_time.split(".")
		t1_sec = split_time[0].to_i
		t1_ns = split_time[1].to_i

		split_time = cur_time.split(".")
		t2_sec = split_time[0].to_i
		t2_ns = split_time[1].to_i

		if t2_sec < t1_sec
			raise "Line #{i}: Previous timestamp #{prev_time} >= new timestamp #{cur_time}\nBLOCKCHAIN INVALID"
		elsif t2_sec == t1_sec && t2_ns <= t1_ns
			raise "Line #{i}: Previous timestamp #{prev_time} >= new timestamp #{cur_time}\nBLOCKCHAIN INVALID"
		end
	end
	def checkValidLine line, i
		raise "Line #{i}: Invalid line format\nBLOCKCHAIN INVALID" unless line =~ /[0-9][|]\h*[|][[a-zA-Z]{0,6}[>][a-zA-Z]{0,6}[:]{0,1}[(][0-9]*[)]]*[|][0-9]*[.][0-9]*[|]\h*/
	end

	def checkAddress address, i
		raise "Line #{i}: Invalid address format\nBLOCKCHAIN INVALID" unless address =~ /[a-zA-Z]{0,6}/
		address.to_s
	end

	def printOut people
		people.each{|key, value| puts "#{key}: #{value} billcoins"}
	end
	def checkBalance key, value, i
 		raise "Line #{i}: Invalid block, address #{key} has #{value} billcoins!\nBLOCKCHAIN INVALID" unless value >= 0
	end

end
