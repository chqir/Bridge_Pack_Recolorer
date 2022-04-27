require 'RMagick'
require 'color_math'
include Magick

puts "what is the blue folder path?"
b_path = gets.chomp
b_names = `find #{b_path} -type f -regex ".*\.png"`.split(/\n/)

puts "red path?"
r_path = gets.chomp
r_names = `find #{r_path} -type f -regex ".*\.png"`.split(/\n/)

puts "what is the blue color?"
blue = gets.chomp.to_i
$b_val = ( blue * 100/180 ) + 100
puts $b_val.to_s + " : blue color"

puts "what is the red color?"
red = gets.chomp.to_i
$r_val = ( red * 100/180 ) + 100
puts $r_val.to_s + " : red color"

b_names.each do |file|
  #creates a variable that has a file value so it can be worked on with imgmagick
  c_image = ImageList.new(file)
  #creates an array of thr rgb values of a pixel in the middle
  rgb_array = c_image.pixel_color(2,2).to_s.split(",")
  #generates an empty rgb array
  empty_rgb = []
  #appends each rgb value that we got to the empty array, and divides to convert to rgb
  rgb_array.each {|x| empty_rgb << ((x.gsub(/\D+/,"").to_i)/257)}
  #creates colormath object to be operated on
  almost_there = ColorMath.new empty_rgb[0], empty_rgb[1], empty_rgb[2]
  #converts array of rgb to hsl array
  so_close = almost_there.to_hsl
  #takes the hue from the array, and multiplies it by 200/360 to get the conversion to mod units
  #then it multiplies the number (out of 200) by .01 to convert to the mod units
  puts so_close[0].to_s + " actual hsl of image"
  modulate_hue = ( so_close[0].to_i * 100/180 ) + 100
  #
  hue = modulate_hue + ($b_val - modulate_hue)

  n_image = c_image.modulate(1.0, 1.0, hue)
  n_image.write(file)
end


r_names.each do |file|
  c_image = ImageList.new(file)
  rgb_array = c_image.pixel_color(2,2).to_s.split(",")
  empty_rgb = []
  rgb_array.each {|x| empty_rgb << ((x.gsub(/\D+/,"").to_i)/257)}
  almost_there = ColorMath.new empty_rgb[0], empty_rgb[1], empty_rgb[2]
  so_close = almost_there.to_hsl
  hue = (1.0/100.0)*(200.0/360.0)*(so_close[0].to_f)
  shift = hue + ($r_val - hue)
  n_image = c_image.modulate(1.0, 1.0, shift)
  n_image.write(file)
end
=begin
m_names.each do |file|
  c_image = ImageList.new(file)
  rgb_array = c_image.pixel_color(2,2).to_s.split(",")
  empty_rgb = []
  rgb_array.each {|x| empty_rgb << ((x.gsub(/\D+/,"").to_i)/257)}
  almost_there = ColorMath.new empty_rgb[0], empty_rgb[1], empty_rgb[2]
  so_close = almost_there.to_hsl
  hue = (1.0/100.0).to_f*(200/360).to_f*(so_close[0].to_f)
  shift = hue + (m_val - hue)
  n_image = c_image.modulate(1.0, 1.0, m_val)
  n_image.write(file)
end
=end

# get 6 input colors
# search for all distinct rgb values in the image
# *searh for hsl values and put into array
# eliminate duplicates
# compare which ones arr darker
# take that value and replace it with choice color
# take light value and replace it with other color
# repeat for all files
#


