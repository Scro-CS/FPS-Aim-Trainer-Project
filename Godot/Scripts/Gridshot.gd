extends Spatial

# Array of all the cube nodes in one variable.
onready var AllCubes = [$Cubes/Cube1,$Cubes/Cube2,$Cubes/Cube3,$Cubes/Cube4,$Cubes/Cube5,$Cubes/Cube6,$Cubes/Cube7,$Cubes/Cube8,
$Cubes/Cube9,$Cubes/Cube10,$Cubes/Cube11,$Cubes/Cube12,$Cubes/Cube13,$Cubes/Cube14,$Cubes/Cube15,$Cubes/Cube16,$Cubes/Cube17,$Cubes/Cube18,
$Cubes/Cube19,$Cubes/Cube20,$Cubes/Cube21,$Cubes/Cube22,$Cubes/Cube23,$Cubes/Cube24,$Cubes/Cube25]
onready var rng = RandomNumberGenerator.new() # create a new instance of RNG andd assign it to the variable rng.
var value_1 = 0 # first cube
var value_2 = 0 # second cube
var value_3 = 0 # third cube
var repeat_value = 0 # if visible, repeat this
var buffer = false # condition of if the cube is hidden or visible.

func _process(_delta):
	# when the countdown timer has stopped, and when the cube hit is visible, show a new cube that was hidden. All down the chance.
	if $"Player/321Countdown/Timer1".is_stopped() and buffer == true: 
		rng.randomize()
		repeat_value = rng.randi_range(0, 24) # number of cubes
		if AllCubes[repeat_value].is_visible():
			pass # pass if the cube generated is already visible (repeat function)
		else:
			AllCubes[repeat_value].show() # show the new cube
			buffer = false

func _ready():
	
	#hide all the cubes
	$Cubes/Cube1.hide()
	$Cubes/Cube2.hide()
	$Cubes/Cube3.hide()
	$Cubes/Cube4.hide()
	$Cubes/Cube5.hide()
	$Cubes/Cube6.hide()
	$Cubes/Cube7.hide()
	$Cubes/Cube8.hide()
	$Cubes/Cube9.hide()
	$Cubes/Cube10.hide()
	$Cubes/Cube11.hide()
	$Cubes/Cube12.hide()
	$Cubes/Cube13.hide()
	$Cubes/Cube14.hide()
	$Cubes/Cube15.hide()
	$Cubes/Cube16.hide()
	$Cubes/Cube17.hide()
	$Cubes/Cube18.hide()
	$Cubes/Cube19.hide()
	$Cubes/Cube20.hide()
	$Cubes/Cube21.hide()
	$Cubes/Cube22.hide()
	$Cubes/Cube23.hide()
	$Cubes/Cube24.hide()
	$Cubes/Cube25.hide()

	rng.randomize() # randomize
	value_1 = AllCubes[rng.randi_range(0, 24)]
	value_1.show() # show a random cube
	
	
	rng.randomize()
	value_2 = AllCubes[rng.randi_range(0, 24)]
	while value_2 == value_1: #repeat until value_2 != value_1 to show a new cube.
		rng.randomize()
		value_2 = AllCubes[rng.randi_range(0, 24)]
	value_2.show()
	
	rng.randomize()
	value_3 = AllCubes[rng.randi_range(0, 24)]
	while value_3 == value_2 or value_3 == value_1: #repeat until value_3 != value_1 or value_3 != value_2, to show a new cube.
		rng.randomize()
		value_3 = AllCubes[rng.randi_range(0, 24)]
	value_3.show()
