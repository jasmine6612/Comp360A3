extends Node
class_name MaterialSetup

## Script to generate and save all materials for the project
## Run this once to create all material files

const MATERIALS_PATH = "res://Materials/"

func _ready():
	# Create Materials directory if it doesn't exist
	if not DirAccess.dir_exists_absolute(MATERIALS_PATH):
		DirAccess.make_dir_absolute(MATERIALS_PATH)
	
	print("Generating materials...")
	generate_all_materials()
	print("Materials generated and saved!")


func generate_all_materials():
	# 1. Brick Wall Material
	var brick_material = create_brick_material()
	ResourceSaver.save(brick_material, MATERIALS_PATH + "BrickWallMaterial.tres")
	print("✓ Saved BrickWallMaterial.tres")
	
	# 2. Metal Robot Body Material
	var robot_body_material = create_robot_body_material()
	ResourceSaver.save(robot_body_material, MATERIALS_PATH + "RobotBodyMaterial.tres")
	print("✓ Saved RobotBodyMaterial.tres")
	
	# 3. Robot Arm Material (slightly different metal)
	var robot_arm_material = create_robot_arm_material()
	ResourceSaver.save(robot_arm_material, MATERIALS_PATH + "RobotArmMaterial.tres")
	print("✓ Saved RobotArmMaterial.tres")
	
	# 4. Gold Coin Material
	var coin_material = create_coin_material()
	ResourceSaver.save(coin_material, MATERIALS_PATH + "CoinMaterial.tres")
	print("✓ Saved CoinMaterial.tres")
	
	# 5. Concrete Obstacle Material
	var concrete_material = create_concrete_material()
	ResourceSaver.save(concrete_material, MATERIALS_PATH + "ConcreteMaterial.tres")
	print("✓ Saved ConcreteMaterial.tres")
	
	# 6. Futuristic Panel Material
	var panel_material = create_futuristic_panel_material()
	ResourceSaver.save(panel_material, MATERIALS_PATH + "FuturisticPanelMaterial.tres")
	print("✓ Saved FuturisticPanelMaterial.tres")


# Create brick wall material
func create_brick_material() -> StandardMaterial3D:
	var material = StandardMaterial3D.new()
	material.albedo_texture = ProceduralTextureGenerator.create_brick_texture()
	material.roughness = 0.8
	material.metallic = 0.0
	material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
	return material


# Create robot body material with metallic look
func create_robot_body_material() -> StandardMaterial3D:
	var material = StandardMaterial3D.new()
	material.albedo_texture = ProceduralTextureGenerator.create_metal_texture()
	material.metallic = 0.9
	material.roughness = 0.3
	material.albedo_color = Color(0.7, 0.75, 0.8)  # Slight blue tint
	material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
	return material


# Create robot arm material
func create_robot_arm_material() -> StandardMaterial3D:
	var material = StandardMaterial3D.new()
	material.albedo_texture = ProceduralTextureGenerator.create_metal_texture()
	material.metallic = 0.85
	material.roughness = 0.4
	material.albedo_color = Color(0.6, 0.6, 0.65)  # Darker gray
	material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
	return material


# Create shiny gold coin material
func create_coin_material() -> StandardMaterial3D:
	var material = StandardMaterial3D.new()
	material.albedo_texture = ProceduralTextureGenerator.create_coin_texture()
	material.metallic = 1.0
	material.roughness = 0.2
	material.albedo_color = Color(1.0, 0.84, 0.0)  # Gold color
	material.emission_enabled = true
	material.emission = Color(1.0, 0.9, 0.3)
	material.emission_energy_multiplier = 0.3
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
	return material


# Create concrete material for obstacles
func create_concrete_material() -> StandardMaterial3D:
	var material = StandardMaterial3D.new()
	material.albedo_texture = ProceduralTextureGenerator.create_concrete_texture()
	material.roughness = 0.9
	material.metallic = 0.0
	material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
	return material


# Create futuristic panel material
func create_futuristic_panel_material() -> StandardMaterial3D:
	var material = StandardMaterial3D.new()
	material.albedo_texture = ProceduralTextureGenerator.create_futuristic_panel_texture()
	material.metallic = 0.7
	material.roughness = 0.5
	material.emission_enabled = true
	material.emission = Color(0.0, 0.5, 0.8)
	material.emission_energy_multiplier = 0.5
	material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
	return material


# Helper function to apply material to a node and its children
static func apply_material_to_node(node: Node, material: Material):
	if node is MeshInstance3D:
		node.material_override = material
	
	for child in node.get_children():
		apply_material_to_node(child, material)
