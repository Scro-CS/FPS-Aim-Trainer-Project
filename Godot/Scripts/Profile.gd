extends Control

# Before the game starts, preload before anything happens
const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

var db # database 
var db_name = "res://Data Storage/SCOREDATA" # Path to database
var table_name = str(Score.ID) # table name

# Called when the node enters the scene tree for the first time.
func _ready():
	db = SQLite.new() # creating a new instance of the database to use
	db.path = db_name # putting a path towards the file location
	db.open_db() # open db
	
	db.query("SELECT MAX(SCORE) FROM " + table_name + ";") #queries to the sql database to get the maximum score
	Score.high_score = int(db.query_result[0]["MAX(SCORE)"]) #sets the first value of the "max(score)" to the gobal of Score.high_score
	
		
	db.query("SELECT AVG(SCORE) FROM " + table_name + ";") #queries to the sql database to get the average score
	Score.average_score = int(db.query_result[0]["AVG(SCORE)"]) #sets the first value of the "avg(score)" to the gobal of Score.average_score

	
	$HIGHESTSCORE/COUNTER.set_text(str(Score.high_score)) # set the high_score text to the global variable value
	$AVERAGESCORE/COUNTER.set_text(str(Score.average_score)) # set the average_score text to the global variable value

func _on_Backbutton_pressed(): # change scenes back to main menu
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
