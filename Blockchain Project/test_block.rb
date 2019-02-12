#John Wartonick
# test_block

require 'minitest/autorun'

require_relative "Transaction.rb"
require_relative "Block.rb"

class TestBlock < Minitest::Test

	def setup
		@b = Block::new
		@t = Transaction::new("Henry>Cyrus(17)")
	end

	def test_add_transaction
		@b.addTransaction(@t)
		assert_equal @b.block.length, 1
	end

end