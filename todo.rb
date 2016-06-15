x = 0
$list = []
$completed_list = []
IO.foreach('todo.txt') do |line|
	x += 1
	$list << line
end

def view_list
	$list.each_with_index do |line, index|
		puts "#{index+1}. #{line}"
	end
	$completed_list.each_with_index do |line, index|
		puts "#{index+$list.length}. #{line}"
	end
end

def review?
	puts "Would you like to review your list now? (yes/no)"
	answer = gets.chomp
	view_list if answer == "yes"
end

choice = nil
until choice == "quit"
	puts "What would you like to do with your list? (view/add/delete/complete/quit)"
	choice = gets.chomp
	case choice
	when "view" then view_list
	when "add" then puts "What would you like to add?"
		task = gets.chomp
		$list << task
		puts "Added '#{task}' to your list!"
		review?
	when "delete" then view_list
		puts "Which line would you like to delete?"
		line_num = gets.chomp.to_i
		puts "Deleted '#{$list[line_num-1]}' from your list!"
		$list.delete_at(line_num-1)
		review?
	when "complete" then view_list
		puts "Which task is complete?"
		completed = gets.chomp.to_i
		$completed_list << "COMPLETED: #{$list[completed-1]}"
		puts "Checked #{$list[completed-1]} off your list!"
		$list.delete_at(completed-1)
		review?
	when "quit" then puts "Save your list? (yes/no)"
		save = gets.chomp
		if save == "yes"
			File.open("todo.txt", "w+") do |f|
  			$list.each {|element| f.puts(element)}
  			$completed_list.each {|element| f.puts(element)}
			end
		end
	end
end


# What classes do you need?

# Remember, there are four high-level responsibilities, each of which have multiple sub-responsibilities:
# 1. Gathering user input and taking the appropriate action (controller)
# 2. Displaying information to the user (view)
# 3. Reading and writing from the todo.txt file (model)
# 4. Manipulating the in-memory objects that model a real-life TODO list (domain-specific model)

# Note that (4) is where the essence of your application lives.
# Pretty much every application in the universe has some version of responsibilities (1), (2), and (3).