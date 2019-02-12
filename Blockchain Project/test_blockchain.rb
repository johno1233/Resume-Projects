#John Wartonick
# test blockchain.rb

require 'minitest/autorun'

require_relative "Hash.rb"
require_relative "Time.rb"
require_relative "Block.rb"
require_relative "Transaction.rb"
require_relative "blockchain.rb"

class BlockchainTest < Minitest::Test

	def setup 
		@blockchain = Blockchain::new
	end

	def test_check_current_hash
		error = @blockchain.checkCurrentHash("3|c72d|SYSTEM>Henry(100)|1518892051.764563000|7419")
		assert_nil error

		
	end	
	def test_check_bad_current_hash
		assert_raises RuntimeError do
			@blockchain.checkCurrentHash("3|c72d|SYSTEM>Henry(100)|1518892051.764563000|0")
		end
	end

	def test_check_prev_hash
		prev_block = "5|97df|Henry>Edward(23):Rana>Alfred(1):James>Rana(1):SYSTEM>George(100)|1518892051.783448000|d072"
		cur_block = "6|d072|Wu>Edward(16):SYSTEM>Amina(100)|1518892051.793695000|949"
		error = @blockchain.checkPrevHash(prev_block, cur_block)
		assert_nil error

		
	end
	def test_check_bad_prev_hash
		prev_block = "5|97df|Henry>Edward(23):Rana>Alfred(1):James>Rana(1):SYSTEM>George(100)|1518892051.783448000|d072"
		cur_block = "6|d033|Wu>Edward(16):SYSTEM>Amina(100)|1518892051.793695000|949"
		assert_raises RuntimeError do
			@blockchain.checkPrevHash(prev_block, cur_block)
		end
	end

	def test_check_order
		error = @blockchain.checkOrder(1, 1)
		assert_nil error

		
	end
	def test_check_bad_order
		assert_raises RuntimeError do
			@blockchain.checkOrder(0, 1)
		end
	end

	def test_check_time
		error = @blockchain.checkTime("1.4", "1.2", 1)
		assert_nil error		
	end
	def test_check_bad_time
		assert_raises RuntimeError do
			@blockchain.checkTime("1.1", "1.21234", 1)
		end
	end

	def test_check_valid_line
		error = @blockchain.checkValidLine("3|c72d|SYSTEM>Henry(100)|1518892051.764563000|0", 3)
		assert_nil error		
	end
	def test_check_invalid_line
		assert_raises RuntimeError do
			@blockchain.checkValidLine("3|c72d|SYSTEM>Henry(100)|1518892051.764563000", 3)
		end
	end

	def test_check_address
		addr = @blockchain.checkAddress("SYSTEM", 1)
		assert_equal addr, "SYSTEM"		
	end
	def test_check_bad_address
		assert_raises RuntimeError do
			@blockchain.checkAddress(1234567, 1)
		end
	end

	def test_check_balance
		error = @blockchain.checkBalance("Bob", 100, 1)		
		assert_nil error
	end
	def test_check_bad_balance
		assert_raises RuntimeError do
			@blockchain.checkBalance("Bob", -100, 1)
		end
	end

end