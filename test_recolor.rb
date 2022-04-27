require 'RMagick'
include Magick

puts "what is the pack folder path?"
folder = gets.chomp
file_names = `find #{folder} -type f -regex ".*\.png"`.split(/\n/)

puts "enter the rbg values of the color you would like to add to the pack seperated by ONLY COMMAS! i.e. 28,212,32"
#input = gets.chomp
hex = gets.chomp

#red_val = (1.0/255.0).to_f * input[0].to_f
#green_val = (1.0/255.0).to_f * input[1].to_f
#blue_val = (1.0/255.0).to_f * input[2].to_f

#puts red_val
#puts green_val
#puts blue_val

file_names.each do |file|
  #current_image = ImageList.new(file)
  #new_image = current_image.colorize(red_val, green_val, blue_val, 0.1, "")
  
  #new_image.write(file)
  `convert #{file} -colorspace Gray #{file}`
    

end

files_names.each do |file|
  current_image = ImageList.new(file)
  colorized = img.colorize(1, 1, 1, "#{hex}")
  colorized.write(file)



end
