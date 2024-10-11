extends Control

func _ready():
	pass # Replace with function body.

func _on_Buttonquit_pressed(): # close program when quit button is pressed
	get_tree().quit()

func _on_PlayButton_button_up(): # change to the game scene
	get_tree().change_scene("res://Scenes/Gridshot.tscn")
	
func _on_ProfileButton_button_up(): # change to the profile scene
	get_tree().change_scene("res://Scenes/Profile.tscn")

func _on_SettingsButton_button_up(): # change to the settings scene
	get_tree().change_scene("res://Scenes/Settings.tscn")
