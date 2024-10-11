extends Control

onready var n_3 = $number3 # "3" image
onready var n_2 = $number2 # "2" image
onready var n_1 = $number1 # "1" image
export var constant = 0

func _ready():
	# hide all the number images
	n_3.hide() 
	n_2.hide()
	n_1.hide()
	
func _process(_delta):
	
	if constant == 3: # At 3, show the "3" image. 
		n_3.show()
	elif constant == 2: # At 2, show the "2" image. hide the previous
		n_3.hide()
		n_2.show()
	elif constant == 1: # At 1, show the "1" image. hide the previous
		n_2.hide()
		n_1.show()
	elif constant <= 0: # At 0, hide the previous and bg, stop timer.
		n_1.hide()
		$"red transparency".hide()
		$Timer1.stop()
		
func _on_Timer_timeout(): # constant negative per second.
	constant -= 1
