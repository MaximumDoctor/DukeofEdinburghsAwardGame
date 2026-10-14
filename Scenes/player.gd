extends CharacterBody2D


const ACCEL = 15.0
const DECCEL = 10.0
const MAXSPD = 300.0
const JUMP_VELOCITY = -400.0

var time_since_right = 0
var time_since_left = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	#making techy stuff easier
	if Input.is_action_just_released("move_right"): # if right has just been released
		time_since_right =0 #set the time since right has been relesased to 0
	if Input.is_action_just_released("move_left"): # if left has just been released
		time_since_left =0 #set the time since left has been relesased to 0
		
	#defining variables for techy stuff
	var FPER_LEFT: bool = time_since_right <=5 and Input.is_action_just_pressed("move_left")
	var FPER_RIGHT: bool = time_since_left <=5 and Input.is_action_just_pressed("move_right")
	
		
	#this stuff comes before regular movement code - so that things like deceleration don't mess with it
	#we also make sure that it can't happen simultaneously with the normal movement code just to make extra
	#sure that no errors occur
	if FPER_LEFT and velocity.x >= MAXSPD-10:# if we are moving at max speed
		velocity.x = -MAXSPD+25 # instantly flip our direction
		print("tech has occured")

	elif FPER_RIGHT and velocity.x <= (-MAXSPD)+10: #if we are moving at negative max speed
		velocity.x = MAXSPD-25 # instantly flip our direction
		print("tech has occured")

	else:
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("move_left", "move_right")
		if direction and abs(velocity.x) <MAXSPD:
			velocity.x += direction * ACCEL
		elif direction:
			velocity.x = MAXSPD * direction

		velocity.x = move_toward(velocity.x, 0, DECCEL)
	time_since_left +=1
	time_since_right +=1
	move_and_slide()
