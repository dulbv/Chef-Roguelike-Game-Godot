extends Area3D
	
#Character's Outside & Door Status - Starts as False
var is_outside: bool = true
var inside_door: bool = false
# Called when a body enters the area
func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		inside_door = true
		var head_sprite = body.get_node("HeadSprite")
		head_sprite.visible = true
		print("entered")

# Called when a body exits the area
func _on_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		var head_sprite = body.get_node("HeadSprite")
		head_sprite.visible = false
		inside_door = false
		print("exited")
	
# Player Pressing To Go Outside
func _physics_process(delta):
	if inside_door == true and Input.is_action_just_pressed("interact"):
		print("hello")
