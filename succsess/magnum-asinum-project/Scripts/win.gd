extends Area2D

var lvl1status = false

func _on_body_entered(body: Node2D) -> void:
	lvl1status = true
	save()
	get_tree().change_scene_to_file("res://Scenes/hub.tscn")

func save():
	var save_data = {
		"lvl1_completed": lvl1status
		}
	
	var json_string = JSON.stringify(save_data) #converts to JSON string
	var json_file = FileAccess.open("user://savegame.save", FileAccess.WRITE) # Opens/makes the save with write acces.
	json_file.store_line(json_string) # Stores the line into the JSON file
	json_file.close() # Closes the JSON file
