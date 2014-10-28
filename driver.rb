require_relative 'racer_utils'
require_relative 'ruby_racer.rb'


puts "Hello! How many racers do you like to see race today? < 95"
puts "  1 - 26  -> lower case letters race"
puts "  27 - 52 -> upper case and lower case letters"
puts "  53 - 94 -> ASCII race"

num_of_racers = gets.chomp.to_i
while true do
  break if 0 <= num_of_racers && num_of_racers <= 94
  puts "Come on. Enter a valid number of racers."
end

puts ""
puts "Enter size of race you want."
puts "  \'xs\', \'sm\', \'md\', \'lg\', or \'xl\' "
track_size = gets.chomp
while true do
  case track_size
    when "xs"; then track_size = 5; break;
    when "sm"; then track_size = 15; break;
    when "md"; then track_size = 30; break;
    when "lg"; then track_size = 45; break;
    when "xl"; then track_size = 60; break;
    else
      puts "Come on. Enter a valid track size."
    end
end


# track_length = 6

startRace(num_of_racers, track_size)
