require 'Rmagick'
require 'color_math'
include Magick

puts "enter filename"
file = gets.chomp
currentimage = ImageList.new(file)
rgb_array = currentimage.pixel_color(2,2).to_s.split(",")
empty_rgb = []
rgb_array.each {|x| empty_rgb << ((x.gsub(/\D+/,"").to_i)/257)}

almost_there = ColorMath.new empty_rgb[0], empty_rgb[1], empty_rgb[2]
puts almost_there.to_hsl
#divide by 257 to get corresponding rgb values
