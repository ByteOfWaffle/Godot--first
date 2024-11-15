extends Node

signal game_loaded(save_data)

var server_url = "http://your_raspberry_pi_ip:8000"
var player_id = "player1"  # Might want to generate this dynamically

func save_game(save_data: Dictionary):
	var http = HTTPRequest.new()
	add_child(http)
	# Fix: Use callable for signal connection
	http.request_completed.connect(_on_save_completed)
	
	var body = {
		"player_id": player_id,
		"save_data": save_data
	}
	
	var headers = ["Content-Type: application/json"]
	var json_string = JSON.stringify(body)  
	
	
	var error = http.request(
		server_url + "/save",
		PackedStringArray(headers),  
		HTTPClient.METHOD_POST,  
		json_string
	)
	
	if error != OK:
		print_debug("An error occurred in the HTTP request")  

func load_game():
	var http = HTTPRequest.new()
	add_child(http)
	
	http.request_completed.connect(_on_load_completed)
	
	
	var error = http.request(
		server_url + "/load/" + player_id,
		PackedStringArray([]), 
		HTTPClient.METHOD_GET  
	)
	
	if error != OK:
		print_debug("An error occurred in the HTTP request")

func _on_save_completed(result, response_code, headers, body):
	#JSON parser instance
	var json = JSON.new()
	var parse_result = json.parse(body.get_string_from_utf8())
	
	if response_code == 200:
		print_debug("Game saved successfully!")
	else:
		if parse_result == OK:
			print_debug("Error saving game: ", json.get_data().detail)
		else:
			print_debug("Error saving game and parsing response")

func _on_load_completed(result, response_code, headers, body):
	if response_code == 200:
		
		var json = JSON.new()
		var parse_result = json.parse(body.get_string_from_utf8())
		
		if parse_result == OK:
			var save_data = json.get_data()
			# Emit signal with loaded data
			emit_signal("game_loaded", save_data)
		else:
			print_debug("Error parsing loaded game data")
	else:
		print_debug("Error loading game")
