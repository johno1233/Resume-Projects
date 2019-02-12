#John Wartonick
#hash function


class Hash

	MOD_CONST = 65536

	def getHash str
		x = Array.new
		x += str.unpack('U*')

		hash_val = 0

		x.each {|i| hash_val += (i**2000) * ((i + 2)**21) - ((i + 5)**3)}		

		f_hash = hash_val % MOD_CONST
		f_hash.to_s(16)		
	end

end