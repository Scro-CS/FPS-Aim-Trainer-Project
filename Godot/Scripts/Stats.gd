extends Control
# Before the game starts, preload before anything happens
const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

var db # database 
var db_name = "res://Data Storage/SCOREDATA" # Path to database
var tableName = str(Score.ID) # table name of the user

func _on_Backbutton_button_up(): # change scene back to the main menu
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) # set the cursor back to visible
	
	db = SQLite.new() # creating a new instance of the database to use
	db.path = db_name # putting a path towards the file location
	db.open_db() # open db

	$YOURSCORE/COUNTER.set_text(str(Score.current_score)) # set the current_score text to the global variable value
	$HIGHESTSCORE/COUNTER.set_text(str(Score.high_score)) # set the high_score text to the global variable value
	$AVERAGESCORE/COUNTER.set_text(str(Score.average_score)) # set the average_score text to the global variable value
