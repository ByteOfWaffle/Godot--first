extends Control

var login_mode = false  # Controls the current mode - False = Register mode, True = Login mode
var base_url = "http://localhost/dnd"  # Update this to match host's Device ip adress for lan, or have it as localhost for testing.

func _ready():
	update_button_text()

func update_button_text(): 
	$Login.text = "Login" if login_mode else "Create Account" 
	$SwitchMode.text = "Switch to Register" if login_mode else "Switch to Login"

func _on_button_button_down() -> void:
	var input_username = $Username.text
	var input_password = $Password.text
	
	if input_username.is_empty() or input_password.is_empty():
		print("Please fill in all fields")# Player can't see command panel, but might add a promt for this later
		return
	#Prepare data for requests 
	var data = {
		"username": input_username,
		"password": input_password
	}
	#Conver data to json and prepare header variable
	var json = JSON.stringify(data)
	var headers = ["Content-Type: application/json"]
	var url = base_url + ("/login.php" if login_mode else "/register.php") #Takes the url for localhost and opens either the login or php depending on login mode.
	
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, json)

func _on_http_request_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		print("Error with request")
		return
	
	var json = JSON.parse_string(body.get_string_from_utf8())
	if json == null:
		print("Error parsing response")
		return
	
	print(json.message)  # Print server response message
	
	if json.status == "success":
		if login_mode:
			get_tree().change_scene_to_file("res://Scenes/menu.tscn")
		else:
			# Switch to login mode after successful registration
			login_mode = true
			update_button_text()
	
	# Clear input fields
	$Username.text = ""
	$Password.text = ""

func _on_switch_mode_pressed():
	login_mode = !login_mode
	update_button_text()
