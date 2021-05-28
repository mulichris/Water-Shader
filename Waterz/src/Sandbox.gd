extends Spatial
onready var player = $Player
onready var water = $Water

func _process(delta):
	water.mesh.surface_get_material(0).set_shader_param("player_position", player.global_transform.origin);
