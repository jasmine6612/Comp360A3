extends Node
class_name ProceduralTextureGenerator

## Generates various procedural textures for game objects

# Generate a brick wall texture
static func create_brick_texture(width: int = 512, height: int = 512) -> ImageTexture:
	var img = Image.create(width, height, false, Image.FORMAT_RGB8)
	
	var brick_width = 64
	var brick_height = 32
	var mortar_size = 4
	
	var brick_color = Color(0.6, 0.3, 0.2)  # Brown brick
	var mortar_color = Color(0.7, 0.7, 0.7)  # Light gray mortar
	
	for y in range(height):
		for x in range(width):
			var brick_row = int(y / brick_height)
			var offset = (brick_row % 2) * (brick_width / 2)
			
			var local_x = (x + offset) % brick_width
			var local_y = y % brick_height
			
			# Add some noise to brick color
			var noise_val = randf_range(-0.1, 0.1)
			var final_color = brick_color
			
			# Draw mortar lines
			if local_x < mortar_size or local_y < mortar_size:
				final_color = mortar_color
			else:
				final_color = Color(
					brick_color.r + noise_val,
					brick_color.g + noise_val,
					brick_color.b + noise_val
				)
			
			img.set_pixel(x, y, final_color)
	
	return ImageTexture.create_from_image(img)


# Generate a metallic/futuristic robot texture
static func create_metal_texture(width: int = 512, height: int = 512) -> ImageTexture:
	var img = Image.create(width, height, false, Image.FORMAT_RGB8)
	
	var base_color = Color(0.6, 0.65, 0.7)  # Metallic gray-blue
	
	for y in range(height):
		for x in range(width):
			# Create brushed metal effect with horizontal lines
			var line_intensity = sin(y * 0.5) * 0.05
			
			# Add some panel details
			var panel_x = int(x / 128) % 2
			var panel_y = int(y / 128) % 2
			var panel_shade = (panel_x + panel_y) * 0.05
			
			var final_color = Color(
				base_color.r + line_intensity + panel_shade,
				base_color.g + line_intensity + panel_shade,
				base_color.b + line_intensity + panel_shade
			)
			
			img.set_pixel(x, y, final_color)
	
	return ImageTexture.create_from_image(img)


# Generate a shiny gold coin texture
static func create_coin_texture(width: int = 256, height: int = 256) -> ImageTexture:
	var img = Image.create(width, height, false, Image.FORMAT_RGBA8)
	
	var center_x = width / 2.0
	var center_y = height / 2.0
	var radius = min(width, height) / 2.0 - 10
	
	var gold_color = Color(1.0, 0.84, 0.0)  # Gold
	var dark_gold = Color(0.8, 0.6, 0.0)
	
	for y in range(height):
		for x in range(width):
			var dx = x - center_x
			var dy = y - center_y
			var dist = sqrt(dx * dx + dy * dy)
			
			if dist < radius:
				# Create radial gradient for shine effect
				var shine = 1.0 - (dist / radius) * 0.3
				var angle = atan2(dy, dx)
				var highlight = max(0, cos(angle + PI/4)) * 0.2
				
				var final_color = Color(
					gold_color.r * shine + highlight,
					gold_color.g * shine + highlight,
					gold_color.b * shine
				)
				img.set_pixel(x, y, final_color)
			else:
				img.set_pixel(x, y, Color(0, 0, 0, 0))  # Transparent outside
	
	return ImageTexture.create_from_image(img)


# Generate a concrete/obstacle texture
static func create_concrete_texture(width: int = 512, height: int = 512) -> ImageTexture:
	var img = Image.create(width, height, false, Image.FORMAT_RGB8)
	
	var base_color = Color(0.5, 0.5, 0.5)  # Gray concrete
	
	for y in range(height):
		for x in range(width):
			# Add noise for concrete grain
			var noise = randf_range(-0.15, 0.15)
			
			# Add some cracks/imperfections
			var crack = 0.0
			if randf() > 0.99:
				crack = -0.2
			
			var final_color = Color(
				clamp(base_color.r + noise + crack, 0, 1),
				clamp(base_color.g + noise + crack, 0, 1),
				clamp(base_color.b + noise + crack, 0, 1)
			)
			
			img.set_pixel(x, y, final_color)
	
	return ImageTexture.create_from_image(img)


# Generate a glowing futuristic panel texture
static func create_futuristic_panel_texture(width: int = 512, height: int = 512) -> ImageTexture:
	var img = Image.create(width, height, false, Image.FORMAT_RGB8)
	
	var base_color = Color(0.1, 0.15, 0.2)  # Dark blue-gray
	var glow_color = Color(0.0, 0.8, 1.0)  # Cyan glow
	
	for y in range(height):
		for x in range(width):
			var grid_x = x % 64
			var grid_y = y % 64
			
			var is_grid_line = grid_x < 2 or grid_y < 2
			var glow_intensity = 0.0
			
			if is_grid_line:
				glow_intensity = 0.6
			
			var final_color = Color(
				base_color.r + glow_color.r * glow_intensity,
				base_color.g + glow_color.g * glow_intensity,
				base_color.b + glow_color.b * glow_intensity
			)
			
			img.set_pixel(x, y, final_color)
	
	return ImageTexture.create_from_image(img)
