require 'mini_magick'

class ImageFormatter

	def self.emojify_image(url)
		image = MiniMagick::Image.open(url)

		width, height = image.width, image.height
		max = image.dimensions.max

		ratio =  128.0 / width if max == width
		ratio =  128.0 / height if max == height

		width *= ratio
		height *= ratio
		dimensions = "#{width}x#{height}"

		image.resize(dimensions)

		tmp_dir = Dir.mktmpdir
		tmp_image_path = "#{tmp_dir}/emojified.png"
		image.write(tmp_image_path)

		return tmp_image_path
		
	rescue
	end
end