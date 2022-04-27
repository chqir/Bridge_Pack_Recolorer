require 'Rmagick'
include Magick
require 'color_math'


puts "what is the color folders seperated by spaces?"
blue_path = gets.chomp.split(" ")

blue_path.length.times do |i|
  file_names = `find #{blue_path[i]} -type f -regex ".*\.png"`.split(/\n/)
  puts "what color? (hex) > on file #{blue_path[i]}"
  hex = gets.chomp

  file_names.each do |file|
    c_image = ImageList.new(file)
    empty_rgb = []
    rgb_array = c_image.pixel_color(2,2).to_s.split(",").each {|x| empty_rgb << ((x.gsub(/\D+/,"").to_i)/257)}
    cl = ColorMath.new empty_rgb[0],empty_rgb[1],empty_rgb[2]
    hsl_color = cl.to_hsl
    hex_color = cl.to_hex

    #`convert #{file} -modulate 100,100,#{modulate_arg} #{file}`
    puts `convert #{file} -fuzz 15% -fill "#{hex}" -opaque "#{hex_color}" #{file}`
  end
end
