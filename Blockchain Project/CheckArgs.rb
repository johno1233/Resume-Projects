class CheckArgs

	def check_args arr
		raise "Enter a valid blockchain file" unless arr.count == 1
		arr[0]
	end

end