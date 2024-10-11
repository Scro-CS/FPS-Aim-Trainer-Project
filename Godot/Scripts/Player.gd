extends KinematicBody

onready var Vcamera = $Head/Camera # the camera node
onready var Aimcast = $Head/Camera/AimCast # the projectory of the raycast from the camera
export (float) var Vartimer = 59.1 # timer
export var Sensitivity = 0.05 # personal sensitivity of the mouse
export var max_angle = 90 # max angle of rotation
export var min_angle = -75 # min angle of rotation
export var Rateofs = 15 # rate of speed increase
export var Vscore = 0 # the score
var Look = Vector3.ZERO # the rotation of the camera
var Velocity = Vector3.ZERO # the movement of the user

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # Captures where the mouse is on the screen
	_update_hud() # update the hud depending on the global variables in Crosshairs.gd


func _physics_process(_delta): #delta is unused because I do not require gravity.
	
	_process_input(_delta) # interacting with objects

	Vcamera.rotation_degrees.x = Look.x # rotation for x direction
	Vcamera.rotation_degrees.y = Look.y # rotation for y direction
	
	var input_dir := Input.get_vector("moveleft", "moveright", "forward", "backward") # WASD movement
	
	# transform the camera so the raycast is moving when the camera is rotating
	var Direction = (Vcamera.transform.basis.rotated(Vector3.UP, rotation.y) * Vector3(input_dir.x, 0, input_dir.y)).normalized() 
	
	if Direction:
	# moving on the x and z axis in the 3D space * rate of speed in the postion of the camera
			Velocity.x = Direction.x * Rateofs 
			Velocity.z = Direction.z * Rateofs 
	else:
	# if camera has not moved, move as normal
			Velocity.x = move_toward(Velocity.x, 0, Rateofs)
			Velocity.z = move_toward(Velocity.z, 0, Rateofs)
	
	# setting what the velocity is
	Velocity = move_and_slide(Velocity, Vector3.UP)
	
func _process_input(_delta):
	
	if Input.is_action_just_pressed("esc"): # if "esc" is pressed, the program is sent back to the main menu.
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.is_action_just_pressed("Leftclick"):	# when left click is clicked
		# when the raycast is colliding and the countdown timer has stopped
		if Aimcast.is_colliding() and $"321Countdown/Timer1".is_stopped():
			# set the collider object to a variable 
			var hit_target = Aimcast.get_collider()
			# if the hit_target is in the group "Cubes" and it is visible
			if hit_target.is_in_group("Cubes") and hit_target.is_visible():
				get_parent().buffer = true # set the buffer variable from the gridshot to true, so a new cube is set visible
				hit_target.hide() # hide the current hit_ target
				# calculate the current time left to see how fast the user clicked the cubes in sucession
				var time_left = float(($PlayingTimer/Seconds.text) + "." + ($PlayingTimer/DSeconds.text))
				if Vartimer - time_left <= 0.01: # fastest click and biggest multiplier
					Vscore += 100
					$PlayingTimer/Score/ScoreCount.set_text(str(Vscore)) # show new score
					Vartimer = time_left # set time_left to the new value of vartimer
				elif Vartimer - time_left <= 0.025: # average multiplier
					Vscore += 75
					$PlayingTimer/Score/ScoreCount.set_text(str(Vscore))
					Vartimer = time_left # set time_left to the new value of vartimer
				elif Vartimer - time_left <= 0.05: # small multiplier
					Vscore += 50
					$PlayingTimer/Score/ScoreCount.set_text(str(Vscore))
					Vartimer = time_left # set time_left to the new value of vartimer
				else: # no multiplier
					Vscore += 10
					$PlayingTimer/Score/ScoreCount.set_text(str(Vscore))
					Vartimer = time_left # set time_left to the new value of vartimer
			else:
				pass # do nothing
		else:
			pass # do nothing

func _input(event):
	if event is InputEventMouseMotion:
		Look.y -= (event.relative.x * Sensitivity) #Having the y vector - the x relative to the screen for each input
		Look.x -= (event.relative.y * Sensitivity) #Having the x vector - the y relative to the screen for each input
		Look.x = clamp(Look.x, min_angle, max_angle) #Setting a cap to how far the player can look in either y direction (Up/Down)
		
func _update_hud():
		# if any crosshairs are true from the global variable script, show them.
		if Crosshairs.c_1 == true:
			$HUD/CrosshairDot.show()
		else: 
			pass
		if Crosshairs.c_2 == true:
			$HUD/CrosshairDotCyan.show()
		else: 
			pass
		if Crosshairs.c_3 == true:
			$HUD/CrosshairDotWhite.show()
		else: 
			pass
		if Crosshairs.c_4 == true:
			$HUD/CrosshairStandard.show()
		else: 
			pass
		if Crosshairs.c_5 == true:
			$HUD/CrosshairStandardCyan.show()
		else: 
			pass
		if Crosshairs.c_6 == true:
			$HUD/CrosshairStandardWhite.show()
		else: 
			pass
		
		
		

		

