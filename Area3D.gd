extends Area3D


# Called when a body enters the area
func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		var head_sprite = body.get_node("HeadSprite")
		head_sprite.visible = true
		print("entered")
		

# Called when a body exits the area
func _on_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		var head_sprite = body.get_node("HeadSprite")
		head_sprite.visible = false
		print("exited")
