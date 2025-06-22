extends Area3D


@onready var sprite := $Sprite3D

func _on_body_entered(body):
	sprite.visible == false
	pass # Replace with function body.
