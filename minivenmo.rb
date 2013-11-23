#Program areas are broken off into respective functional areas (i.e. user, add, pay feed, balance) and their dependencies by '#---------''
#Remove the commented out 'puts @data_base' to see how @data_base changes with each command
#Program requires Ruby 2.0.0
#Welcome to my Mini-Venmo app.  Please run this file (minivenmo.rb) in your commmand line to start it up.  Type 'HELP' in the terminal for a list of commands and how to use the application; type 'EXIT' to exit the application.  Enjoy.


def input_command(string)
	@words = string.split(' ')
	first_word = @words.first #first word inputed into the command 
	case first_word
	when "help"
	  help_menu
	when "user"
		user_menu
	when "pay"
	  pay_menu
	when "add"
	  add_menu
	when "feed"
	  feed_menu
	when "balance"
	  balance_menu
	else
	  error_message("main")
	end
end

#-------------
def user_menu
	user_name = @words[1]
	if @words.length != 2 || user_name_check_alphanumeric?(user_name) == false 
		error_message("user")
	elsif user_name.split('').length < 4 || user_name.split('').length > 15
		error_message("user_name_too_long_too_short")
	elsif user_name_exists?(user_name) == true
		error_message("user_name_already_taken")		
	else
		@data_base << {user: "#{user_name}", balance: 0, credit_card: :none, feed: Array.new}
	end
	#puts @data_base
end

def user_name_check_alphanumeric?(user_name)
  false_counter = 0
  allowed_letters = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a + ['-'] + ['_']
  user_name_letters = user_name.split('')
  user_name_letters.each do |letter|
    false_counter += 1 unless allowed_letters.include?(letter)
  end
  if false_counter > 0
    return false
  elsif false_counter == 0
    return true
  end
end

def user_name_exists?(user_name)
	user_name_counter = 0 #will increment to see how many users have a particular user name
	@data_base.each do |user|
		user_name_counter += 1 if user[:user] == user_name
	end
	if user_name_counter == 0
		return false
	elsif user_name_counter > 0
		return true
	end
end
#-------------
def error_message(string)
	case string
	when "main"
		puts "- - - - - - - - - - - - - - - "
		puts "Please enter a correct input."
		puts "Type 'help' for a list of commands."
		puts "- - - - - - - - - - - - - - - "
	when "user"
		puts "- - - - - - - - - - - - - - - "
		puts "User name must be alphanumeric and may also contain underscores and hyphens."
		puts "- - - - - - - - - - - - - - - "
	when "user_name_already_taken"
		puts "- - - - - - - - - - - - - - - "		
		puts "The user name you selected has already been taken.  Please select a different user name."
		puts "- - - - - - - - - - - - - - - "
	when "user_name_too_long_too_short"
		puts "- - - - - - - - - - - - - - - "
		puts "User name must be between 4 to 15 characters long."
		puts "- - - - - - - - - - - - - - - "
	when "add"
		puts "- - - - - - - - - - - - - - - "
		puts "ERROR: This card is invalid"
		puts "- - - - - - - - - - - - - - - "
	when "credit_card_already_taken"
		puts "- - - - - - - - - - - - - - - "
		puts "ERROR: That card has already been added by another user, reported for fraud!"
		puts "- - - - - - - - - - - - - - - "
	when "no_user_name_found"
		puts "- - - - - - - - - - - - - - - "
		puts "The user name you have entered is not a valid user name.  Please retry your command."
		puts "- - - - - - - - - - - - - - - "
	when "pay"
		puts "- - - - - - - - - - - - - - - "
		puts "One, or both, of these users do not have a user name.  Please try again."
		puts "- - - - - - - - - - - - - - - "
	when "pay_no_credit_card_on_file"
		puts "- - - - - - - - - - - - - - - "
		puts "ERROR: This user does not have a credit card."
		puts "- - - - - - - - - - - - - - - "
	when "not_correct_money_format"
		puts "- - - - - - - - - - - - - - - "
		puts "Please enter the amount to be paid prefixed with a '$' followed by the dollar amount and cents amount."
		puts "$4.00 CORRECT"
		puts "4.00  INCORRECT"
		puts "4.0   INCORRECT"
		puts "$4    INCORRECT"
		puts "$4.0  INCORRECT"
		puts "- - - - - - - - - - - - - - - "
	when "empty_feed"
		puts "- - - - - - - - - - - - - - - "
		puts "The user currently doesn't have feed to display."
		puts "- - - - - - - - - - - - - - - "
	end
	puts ">>"
end

def help_menu
	puts "- - - - - - - - - - - - - - - "
	puts " "

	puts "- - - - - - - - - -"
	puts "| Create a new user |"
	puts "- - - - - - - - - -"
	puts "- Type 'user' followed by the user name to create a new user"
	puts "   - EXAMPLE 'user Tyler' will create a new user named Tyler"
	puts " "

	puts " - - - - - - - - - - - - -"
	puts "| Create add a credit card |"
	puts " - - - - - - - - - - - - -"
	puts "- Type 'add' followed by the user's name and the credit card number"
	puts "    - EXAMPLE 'add Tyler 0000000000000000' will add the credit card with number 0000000000000000 to Tyler's account"
	puts "- A single credit card can only be assigned to one user"
	puts " "
	
	puts "- - - - - - - - - -"
	puts "| Pay another user |"
	puts "- - - - - - - - - -"
	puts "- Type 'pay user_paying user_accepting $amount_of_money note'"
	puts "    - EXAMPLE 'pay Tyler John $4.25 booze from Friday night' menans Tyler will pay John $4.25 for the alcohol John spent on Tyler on Friday night"
	puts " "

	puts "- - - - - - - - - - -"
	puts "| Display user's feed |"
	puts "- - - - - - - - - - -"
	puts "- Type 'feed user_name'"
	puts "    - EXAMPLE 'feed Tyler' will diplay Tyler's list of transactions"
	puts " "

	puts "- - - - - - - - - - - - -"
	puts "| Display user's balance |"
	puts "- - - - - - - - - - - - -"
	puts "- Type 'balance user_name'"	
	puts "    - EXAMPLE 'balance Tyler' will display Tyler's balance"
	puts " "

	puts "- - - - - - - -"
	puts "| Exit program |"
	puts "- - - - - - - -"
	puts "- Type EXIT to exit application"

	puts ">>"
end
#-----------------
def add_menu
	user_index = 1 #will reset
	user_name = @words[1]
	credit_card = @words[2]
	if @words.length != 3
		error_message("main")
	elsif credit_card_valid?(credit_card) == false		
		error_message("add")
	elsif credit_card_check_if_already_taken?(user_name, credit_card) == true
		error_message("credit_card_already_taken")
	elsif user_name_exists?(user_name) == false
		error_message("no_user_name_found")
	else
		add_credit_card(user_name, credit_card)
	end
	#puts @data_base
end

def credit_card_valid?(credit_card)
  sum = 0
  nums = credit_card.to_s.split("")
  nums.each_with_index do |n, i|
    sum += if (i % 2 == 0)
             n.to_i * 2 >9 ? n.to_i*2-9 : n.to_i*2
           else
             n.to_i
           end
  end
  if (sum % 10) == 0
    return true
  else
    return false
  end
end

def add_credit_card(user_name, credit_card)
	@data_base.each do |user|
		user[:credit_card] = credit_card if user[:user] == user_name
	end
end

def credit_card_check_if_already_taken?(user_name, credit_card)
	credit_card_counter = 0 #will increment to see how many users have a particular user name
	@data_base.each do |user|
		credit_card_counter += 1 if user[:credit_card] == credit_card
	end
	if credit_card_counter == 0
		return false
	elsif credit_card_counter > 0
		return true
	end
end

def user_has_credit_card_on_file?(user_name)
	@data_base.each do |user|
		if user[:user] == user_name
			if user[:credit_card]  == :none
				return false
			else
				return true
			end
		end
	end
end

def correct_money_format?(amount_of_money)
	digits = amount_of_money.split('')
	index_of_decimal = digits.index('.') #finds where the decimal point is; will use this in next line for logic
	if amount_of_money.match(/\$[0-9]*\.[0-9]{2}/) && ((digits.length-1)-2) == index_of_decimal 
		return true
	else
		return false
	end
end

def perform_transaction(user_accepting, amount_of_money)
	amount_of_money = amount_of_money.gsub(/[^\d\.]/, '').to_f 
	@data_base.each do |user|
		user[:balance] = user[:balance]+amount_of_money if user[:user] == user_accepting
	end
end

def add_transaction_to_feed(user_paying, user_accepting, amount_of_money, *feed)
	feed_as_string = feed.join(' ')
	@data_base.each do |user|
		user[:feed].unshift(["-- You paid #{user_accepting} #{amount_of_money} for #{feed_as_string}."]) if user[:user] == user_paying
		user[:feed].unshift(["-- #{user_paying} paid you #{amount_of_money} for #{feed_as_string}."]) if user[:user] == user_accepting
	end
end
#--------------------------------
def pay_menu
	if @words.length <= 4
		error_message("main")
	else
		feed = [] #reset the feed
		user_paying = @words[1]
		user_accepting = @words[2]
		amount_of_money = @words[3]
		#create array for the feed
		if @words.length > 4
			for i in (4...@words.length)
				feed << @words[i]
			end
		end

		if user_name_exists?(user_paying) == false || user_name_exists?(user_accepting) == false
			error_message("pay")
		elsif  user_has_credit_card_on_file?(user_paying) == false
			error_message("pay_no_credit_card_on_file")
		elsif correct_money_format?(amount_of_money) == false
			error_message("not_correct_money_format")
		else
			perform_transaction(user_accepting, amount_of_money)
			add_transaction_to_feed(user_paying, user_accepting, amount_of_money, feed)
		end
		#puts @data_base
	end
end
#--------------------------------
def feed_menu
	if @words.length != 2
		error_message("main")
	else
		user_name = @words[1]
		if user_name_exists?(user_name) == false
			error_message("no_user_name_found")
		else
			@data_base.each do |user|
				if user[:user] == user_name
					if user[:feed].empty?
						error_message("empty_feed")
					else
						user[:feed].each { |msg| puts msg }
					end
				end 
			end
		end
	end
end
#--------------------------------
def display_balance(balance)
	balance = balance.to_s
	if balance != "0"
		digits = balance.split('')
		index_of_decimal = digits.index('.')
		if ((digits.length-1) - index_of_decimal) == 2
			return "-- $#{balance}"
		elsif ((digits.length-1) - index_of_decimal) == 1
			return "-- $#{balance}0"
		end
	else
		return "-- $0.00"
	end 
end

def balance_menu
	if @words.length != 2
		error_message("main")
	else
		user_name = @words[1]
		if user_name_exists?(user_name) == false
			error_message("no_user_name_found")
		else
			@data_base.each do |user|
				if user[:user] == user_name
					puts display_balance(user[:balance])
				end
			end
		end
	end
end
#--------------------------------
#
@data_base = [] #array of hashes for users; inside array will be the user's name, balance, and credit card number
command = "START"

puts "Type 'help' for a list of commands"
while command != "EXIT"
	puts "Please type a command"
	puts ">>"
	command = gets.chomp
	input_command(command)
end