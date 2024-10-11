extends Control

# Before the game starts, preload before anything happens
const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

var db # database 
var db_name = "res://Data Storage/SCOREDATA" # Path to database


export (int) var Seconds = 60 # generally 60 seconds of play time, but can change in inspector
var mil_seconds = 0 # milli seconds variable 
var Counter = 18.0 # stall counter
var n = 1.0 # integer multiplier

func _ready():
	$Timer2.wait_time = 3.0 # set the wait time to 3 seconds
	$Timer2.start() # start the timer
	
func _physics_process(_delta):
	if Counter - n * $Timer2.wait_time >= 0.0: # Loop until value <= 0, now the timer can count down.
		$Seconds.set_text(str(60))
		$DSeconds.set_text("0"+str(0))
		n += 1.0
	else:
		$Timer2.wait_time = 0.1 # set the wait_time back to count every milli second
		calc() # start function calculation below
	
func calc():
	# if miliseconds go from 1 -> 0, and seconds arent less than 0, minus 1 from seconds
	if Seconds > 0 and mil_seconds <= 0: 
		Seconds -= 1
		mil_seconds = 10
		
	if Seconds >= 10: # text placement
		$Seconds.set_text(str(Seconds))
	else:
		$Seconds.set_text("0"+str(Seconds))
		
	if mil_seconds >= 10: # text placement
		$DSeconds.set_text(str(mil_seconds))
	else:
		$DSeconds.set_text("0"+str(mil_seconds))
		
	if Seconds == 0 and mil_seconds == 0: # when the timer hits 0
		$Timer2.stop() # stop timer
		db = SQLite.new() # create a new instance of the database
		db.path = db_name # putting a path towards the file location
		db.open_db() # open db
		var table_name = Score.ID # assigning the score.ID to a new table name variable
		Score.current_score = int($Score/ScoreCount.text) # set the game scene score to the score global variable
		var dict : Dictionary = Dictionary() # add a new record to the table
		dict["SCORE"] = Score.current_score # set the parameters
		
		db.insert_row(table_name,dict) # insert the data to the database
		
		db.query("SELECT MAX(SCORE) FROM " + table_name + ";") #queries to the sql database to get the maximum score
		Score.high_score = int(db.query_result[0]["MAX(SCORE)"]) #sets the first value of the "max(score)" to the gobal of Score.high_score
		
		db.query("SELECT AVG(SCORE) FROM " + table_name + ";") #queries to the sql database to get the average score
		Score.average_score = int(db.query_result[0]["AVG(SCORE)"]) #sets the first value of the "avg(score)" to the gobal of Score.average_score
		
		get_tree().change_scene("res://Scenes/Stats.tscn") # change to the stat scene
	
func _on_Timer2_timeout(): # minus 1 millisecond every millisecond
	mil_seconds -= 1
	
