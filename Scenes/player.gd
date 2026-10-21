extends CharacterBody2D

#defining variables for all the character's wall detectionraycasts
@onready var bottom_left_ray = $"RayCast2D BL"
@onready var bottom_right_ray = $"RayCast2D BR"
@onready var top_left_ray = $"RayCast2D TL"
@onready var top_right_ray = $"RayCast2D TR"


var ACCEL = 15.0
var DECCEL = 20.0
var MAXSPD = 200.0
var JUMP_VELOCITY = -200.0

var time_since_right = 0
var time_since_left = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var direction := Input.get_axis("move_left", "move_right") # defining velocity

		
#defining variables for techy stuff
	var FPER_LEFT: bool = time_since_right <=5 and Input.is_action_just_pressed("move_left")
	var FPER_RIGHT: bool = time_since_left <=5 and Input.is_action_just_pressed("move_right")
	
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		velocity.x *= 1.2
		
	#making techy stuff easier
	if Input.is_action_just_released("move_right"): # if right has just been released
		time_since_right =0 #set the time since right has been relesased to 0
	if Input.is_action_just_released("move_left"): # if left has just been released
		time_since_left =0 #set athe time since left has been relesased to 0
			
	
		
	#this stuff comes before regular movement code - so that things like deceleration don't mess with it
	#we also make sure that it can't happen simultaneously with the normal movement code just to make extra
	#sure that no errors occur
	if FPER_LEFT and velocity.x >= MAXSPD-10:# if we are moving at max speed
		if is_on_floor():
			velocity.x = -MAXSPD+25 # instantly flip our direction
			print("tech has occured")

	elif FPER_RIGHT and velocity.x <= (-MAXSPD)+10: #if we are moving at negative max speed
		if is_on_floor():
			velocity.x = MAXSPD-25 # instantly flip our direction
			print("tech has occured")

	else:
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		if direction and abs(velocity.x) <MAXSPD:
			if is_on_floor():
				velocity.x += direction * ACCEL
		elif direction:
			if is_on_floor():
				velocity.x = move_toward(velocity.x,MAXSPD * direction,DECCEL)
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, DECCEL/2)
		else:
			velocity.x = move_toward(velocity.x, 0, DECCEL/8)
	time_since_left +=1
	time_since_right +=1
	move_and_slide()
