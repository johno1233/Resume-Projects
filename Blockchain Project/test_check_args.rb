#John Wartonick
#args checker test file
require 'minitest/autorun'

require_relative "./ArgsChecker.rb"

class ArgsCheckerTest < Minitest::Test

	def setup 
		@ArgsChecker = ArgsChecker::new
	end

	 def test_no_input
	 	error = assert_raises(RuntimeError) do
	 		@ArgsChecker.check_args([])
	 	end
	 	assert_equal error.message, "Enter a valid blockchain file"
	 end

	 def test_single_input
	 	assert_equal @ArgsChecker.check_args([1]), 1
	 end

	 def test_multi_input
	 	error = assert_raises(RuntimeError) do
	 		@ArgsChecker.check_args([1, 2, 3])
	 	end
	 	assert_equal error.message, "Enter a valid blockchain file"
	 end

end