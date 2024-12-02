extends Area2D

var lvl1status = false

func _ready(): #Runs when project has loaded.
	recover()



func recover():
	var jsonFile = FileAccess.open("res://savegame.json", FileAccess.READ)
	if jsonFile:
		var jsonString = jsonFile.get_as_text()
		jsonFile.close()
		
		# from json string to dictionary so in other words, from {"lvl1_completed":true} to "lvl1_completed": lvl1status, and since lvl1_completed is true, lvl1status turns true
		var saveData = JSON.parse_string(jsonString)
		if saveData.has("lvl1_completed"):
			lvl1status = saveData.lvl1_completed


func _on_body_entered(body: Node2D) -> void:
	if lvl1status == true:
		get_tree().change_scene_to_file("res://Scenes/game.tscn")
