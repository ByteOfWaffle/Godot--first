extends Area2D

var player_entered = false


func _on_body_entered(body: Node2D) -> void:
	player_entered = true



func _input(event: InputEvent) -> void: #Build in function for inputs
	if player_entered == true && Input.is_action_just_pressed("use"):
		get_tree().change_scene_to_file("res://Scenes/hub.tscn")


func _on_body_exited(body: Node2D) -> void:
	player_entered = false
