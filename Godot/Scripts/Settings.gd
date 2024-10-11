extends Control

func _ready():
	# load data from the global script of "Crosshairs" to see if there are already on
	if Crosshairs.c_1:
		$CheckButton.pressed = true
	else:
		$CheckButton.pressed = false
	if Crosshairs.c_2:
		$CheckButton2.pressed = true
	else:
		$CheckButton2.pressed = false
	if Crosshairs.c_3:
		$CheckButton3.pressed = true
	else:
		$CheckButton3.pressed = false
	if Crosshairs.c_4:
		$CheckButton4.pressed = true
	else:
		$CheckButton4.pressed = false
	if Crosshairs.c_5:
		$CheckButton5.pressed = true
	else:
		$CheckButton5.pressed = false
	if Crosshairs.c_6:
		$CheckButton6.pressed = true
	else:
		$CheckButton6.pressed = false
		

func _on_Backbutton_button_up(): # change the scene back to main menu
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_CheckButton_toggled(button_pressed): # press the button to turn on and again to turn it back off
	if button_pressed:
		Crosshairs.c_1 = true
	else:
		Crosshairs.c_1 = false
		
func _on_CheckButton2_toggled(button_pressed): # press the button to turn on and again to turn it back off
	if button_pressed:
		Crosshairs.c_2 = true
	else:
		Crosshairs.c_2 = false


func _on_CheckButton3_toggled(button_pressed): # press the button to turn on and again to turn it back off
	if button_pressed:
		Crosshairs.c_3 = true
	else:
		Crosshairs.c_3 = false


func _on_CheckButton4_toggled(button_pressed): # press the button to turn on and again to turn it back off
	if button_pressed:
		Crosshairs.c_4 = true
	else:
		Crosshairs.c_4 = false


func _on_CheckButton5_toggled(button_pressed): # press the button to turn on and again to turn it back off
	if button_pressed:
		Crosshairs.c_5 = true
	else:
		Crosshairs.c_5 = false


func _on_CheckButton6_toggled(button_pressed): # press the button to turn on and again to turn it back off
	if button_pressed:
		Crosshairs.c_6 = true
	else:
		Crosshairs.c_6 = false


