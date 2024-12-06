extends Control

var accounts = {}  # Dictionary to store all accounts
var login_mode = false  # Controls the current mode - False = Register mode, True = Login mode

# Runs when scene loads
func _ready():
	load_accounts() # Load any existing accounts from the save file
	update_button_text() # Set starting button text states
	
# Updates the text on buttons based on current mode
# If in login mode: main button shows "Login" and switch button shows "Switch to Register"
# If in register mode: main button shows "Create Account" and switch button shows "Switch to Login"
func update_button_text(): 
	$Login.text = "Login" if login_mode else "Create Account" 
	$SwitchMode.text = "Switch to Register" if login_mode else "Switch to Login"

func _on_button_button_down() -> void:
	var input_username = $Username.text
	var input_password = $Password.text.sha256_text()
	
	if !login_mode:  # Register mode (If not login mode ! reverses)
		# Check if username already exists
		if accounts.has(input_username):
			print("Username already exists!")
			return
			
		# Add new account
		accounts[input_username] = input_password
		print("Account created successfully!")
		save_accounts()
	else:  # Login mode
		# Check if account exists and password matches
		if accounts.has(input_username):
			if accounts[input_username] == input_password:
				print("Login success")
				get_tree().change_scene_to_file("res://Scenes/menu.tscn")
			else:
				print("Wrong password")
		else:
			print("Account not found")
	
	# Clear input fields
	$Username.text = ""
	$Password.text = ""

func _on_switch_mode_pressed():
	login_mode = !login_mode
	update_button_text()

func save_accounts():
	var save_data = {
		"accounts": accounts
	}
	
	var json_string = JSON.stringify(save_data)
	var json_file = FileAccess.open("res://saveuser.json", FileAccess.WRITE)
	json_file.store_line(json_string)
	json_file.close()

func load_accounts():
	if FileAccess.file_exists("res://saveuser.json"):
		var json_file = FileAccess.open("res://saveuser.json", FileAccess.READ)
		var json_string = json_file.get_line()
		var json_data = JSON.parse_string(json_string)
		
		if json_data and json_data.has("accounts"):
			accounts = json_data["accounts"]
		
		json_file.close()
