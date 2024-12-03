extends Area2D

var player_entered = false

func _on_body_entered(body: Node2D) -> void:
	player_entered = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("use") && player_entered == true:
		get_tree().change_scene_to_file("res://Scenes/game.tscn")



func _on_body_exited(body: Node2D) -> void:
	player_entered = false
