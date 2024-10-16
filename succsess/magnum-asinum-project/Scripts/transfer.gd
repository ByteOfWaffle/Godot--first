extends Area2D

@onready var timertrans: Timer = $Timertrans


func _on_body_entered(body: Node2D) -> void:
	Engine.time_scale = 0.5
	timertrans.start()


func _on_timertrans_timeout() -> void:
	print("Transfered")
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Scenes/train.tscn")
