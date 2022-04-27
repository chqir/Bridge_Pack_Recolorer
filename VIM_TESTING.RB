require 'Rmagick'
include Magick
require 'color_math'

4.times do |i|   
  puts "what is the color folder?"
  blue_path = gets.chomp
  file_names = `find #{blue_path} -type f -regex ".*\.png"`.split(/\n/)
  puts "what color? (hex)"
  hex = gets.chomp
  #this is ruby, and also the worst fucking program ive ever written in my entire life. 
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
