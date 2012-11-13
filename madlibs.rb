class MadLibs
	attr_accessor :rules
	

	def initialize
		@rules = Array.new(7)
		counter = 0
		IO.foreach('grammar_rules.txt') do |line|
		
			#puts line
			if line != "\n"
				input = line.split
				#puts input.inspect
				rules[counter] = input
				counter += 1
			end
		end
		
		for i in 0..6
			args = rules[i].length
			for j in 1..(args-1)
				rules[i][j] = rules[i][j].split('|')
			end
		end
		
		#puts rules.inspect
	end
	
	def findInput(input)
		if input.include? "LINE"
			return 1
		elsif input.include? "ADJECTIVE"
			return 2
		elsif input.include? "PRONOUN"
			return 4
		elsif input.include? "NOUN"
			return 3
		elsif input.include? "VERB"
			return 5
		elsif input.include? "PREPOSITION"
			return 6
		else
			return 0
		end
	end
	
	def printInput(line, position)
		length = rules[line][position].length
		#puts length
		argVal = rand(length)
		#puts argVal
		arg = rules[line][position][argVal].inspect
		#puts arg
		if arg.include? "<"
			done = printInput(findInput(arg), 1)
			if done == 1
				return 1
			else
				return 0
			end
		elsif arg.include? "$"
			if arg.include? "LINEBREAK"
				puts
				return 0
			else
				return 1
			end
		else
			print arg
			print " "
			done = printInput(line, 2)
			if done == 1
				return 1
			else
				return 0
			end
		end
		
	end	
	
	def run
		for i in 1..5
			#printf( "Running: %d\n", i)
			printInput(0, i)
			puts
		end
	end
end

if __FILE__ == $0
	ml = MadLibs.new
	#ml.initialize
	ml.run
end
