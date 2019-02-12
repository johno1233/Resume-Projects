#John Wartonick
#test hash

require 'minitest/autorun'

require_relative "Hash.rb"

class TestHash < Minitest::Test

	def setup
		@h = Hash::new
	end

	def test_get_hash
		block = "3|c72d|SYSTEM>Henry(100)|1518892051.764563000|"
		str = block.split("|")
		new_str = str[0..str.length-1]
		h = @h.getHash(new_str.to_s)
	
		assert_equal h, "9e"
	end

end