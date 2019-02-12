#John Wartonick
#main file

require 'flamegraph'

require_relative "CheckArgs.rb"
require_relative "blockchain.rb"


Flamegraph.generate('verify_graph.html') do
	arg_check = CheckArgs::new
	begin
		arg_check.check_args(ARGV) #check if valid args
	rescue => e
		puts e.message
		exit
	end

	blockchain_file = ARGV[0] #get the file

	chain = Blockchain::new

	block_hash = ""
	prev_block_hash = ""
	block_number = 0
	block_times = Array.new		
	people = Hash.new

	f = IO.readlines(blockchain_file)

	f.each_index {|i|
		begin
			chain.checkValidLine(f[i], i)
		rescue => e
			puts e.message
			exit
		end

		values = f[i].split("|")
		block_number = values[0].to_i
		prev_block_hash = values[1]
		block_times << values[3].to_s

		block_hash = values[4].strip

		if i != 0
			prev_values = f[i - 1].split("|")
		end
		#check to see if the times are valid
		if i != 0
			cur_time = values[3]
			prev_time = prev_values[3]
			begin
				chain.checkTime(cur_time, prev_time, i)
			rescue => e
				puts e.message
				exit
			end
		end

		begin
			chain.checkOrder(block_number, i)
		rescue => e
			puts e.message
			exit
		end
		block = Array.new
		trans = values[2].split(":")
		trans.each{|x|
			t = Transaction::new(x.to_s)
			block << t
		}
		block.each{|x|
			begin
				from_address = chain.checkAddress(x.from_address.to_s, i)				
			rescue => e
				puts e.message
				exit
			end
			begin
				to_address = chain.checkAddress(x.to_address.to_s, i)
			rescue => e
				puts e.message
				exit
			end

			if from_address != "SYSTEM" && people.key?(from_address) == false
				people[from_address.to_s] = 0
			elsif people.key?(to_address) == false
				people[to_address.to_s] = 0
			end
			# set balances of people's addresses
			if from_address != "SYSTEM"
				people[to_address.to_s] += x.num_billcoins_sent.to_i
				people[from_address.to_s] -= x.num_billcoins_sent.to_i
			else
				people[to_address.to_s] += x.num_billcoins_sent.to_i
			end
		}
		begin
			people.each{|key, value| 
				chain.checkBalance(key, value, i)
			}		
		rescue => e
			puts e.message
			exit
		end

		if i != 0
			begin
				chain.checkPrevHash(prev_values, values)
			rescue => e
				puts e.message
				exit
			end
		end
		begin
			chain.checkCurrentHash(f[i], values)
		rescue => e
			puts e.message
			exit
		end
	}
	# chain.printOut(people)
	people.each{|key, value| puts "#{key}: #{value} billcoins"}
end