
extends Control

# Before the game starts, preload before anything happens
const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns") 

var db # database 
var db_name = "res://Data Storage/Player Credentials" # Path to database
var table_name = "PlayerCredentials" # table name
	

func _ready():
	if $VBoxContainer/error_label_msg.is_visible(): 
		# on start of the program, if the error_label is visible, set all to hide
		$VBoxContainer/error_label_msg.hide()
		$VBoxContainer/error_username.hide()
		$VBoxContainer/error_password.hide()
		$VBoxContainer/error_not_found.hide()
		
func _on_Button_button_up():
	
	# set the text inputted from the user to a variable using singletons, in this case, username and password
	var Username = $VBoxContainer/Usernametype.text 
	var Password = $VBoxContainer/Passwordtype.text	 
	
	db = SQLite.new() # creating a new instance of the database to use
	db.path = db_name # putting a path towards the file location
	db.open_db() # open db
	
	# search the database of what the user has inputted into the nodes, when they have clicked the button.
	db.query("SELECT * FROM " + table_name + " WHERE Username = '" + Username + "' OR Password = '" + Password + "';") 
	
	if db.query_result.size() == 0: # if the database returns empty, no username/password is found.
		if $VBoxContainer/error_password.is_visible():
			$VBoxContainer/error_password.hide() # password hide
		if $VBoxContainer/error_username.is_visible():
			$VBoxContainer/error_username.hide() # username hide
		$VBoxContainer/error_label_msg.show()
		$VBoxContainer/error_not_found.show() # user has not been found.
	elif db.query_result.size() >= 1 and db.query_result[0]["Username"] == Username and db.query_result[0]["Password"] == Password: 
		# database has found the userID related to the username and password correctly.
		Score.ID = "UID"+str(db.query_result[0]["U.ID"])
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
		db.close_db()	
	elif db.query_result.size() >= 1 and db.query_result[0]["Username"] == Username and db.query_result[0]["Password"] != Password: 
		# database has found the username, but the password is incorrect.
		if $VBoxContainer/error_not_found.is_visible():
			$VBoxContainer/error_not_found.hide() # login not found hide
		if $VBoxContainer/error_username.is_visible():
			$VBoxContainer/error_username.hide() # username hide
		$VBoxContainer/error_label_msg.show()
		$VBoxContainer/error_password.show() # password is incorrect.
	elif db.query_result.size() >= 1 and db.query_result[0]["Username"] != Username and db.query_result[0]["Password"] == Password: 
		# database has found the password, but the username is incorrect.
		if $VBoxContainer/error_not_found.is_visible():
			$VBoxContainer/error_not_found.hide() # login not found hide
		if $VBoxContainer/error_password.is_visible():
			$VBoxContainer/error_password.hide() # password hide
		$VBoxContainer/error_label_msg.show()
		$VBoxContainer/error_username.show() # username is incorrect.
	else:
		print("ERROR CODE_1: UNKNOWN") # when there is a hidden error not accounted for.
		
func _on_QuitButtonFunc_pressed(): #closes the application when pressed.
	get_tree().quit()
	
	
"""
#SIGN UP FUNC - DO AT END
func commitDataToDB(): # Function to call the database
	db = SQLite.new() # Creates a new command
	db.path = db_name # Links the SQLite database to godot for use
	db.open_db() # Opening the database
	var tableName = "PlayerCredentials" # Declares variable to the table in the pre-existing db
	var dict : Dictionary = Dictionary() # Declares variable for godot to call the fields of the db
	dict["Username"] = "Scro" # Username Example
	dict["Password"] = "ScroThePro" # Password Example
	
	db.insert_row(tableName,dict) # Inserts the new data into the corresponding fields

"""
	
"""
#Getting text from the user
func _on_Usernametype_text_changed(NameofUser):
	db.open_db()
	db.query("SELECT Username FROM " + tableName + " WHERE Username=" + NameofUser + ";")
	if db.query_result[0]["Username"] == true:
		print("True")
	else:
		print("False")
"""

