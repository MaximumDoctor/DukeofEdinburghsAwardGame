extends CharacterBody2D

#defining variables for all the character's wall detectionraycasts
@onready var bottom_left_ray = $"RayCast2D BL"
@onready var bottom_right_ray = $"RayCast2D BR"
@onready var top_left_ray = $"RayCast2D TL"
@onready var top_right_ray = $"RayCast2D TR"

@onready var Ironglow = $"Camera2D/Allomancytable/Ironglow"
@onready var Steelglow = $"Camera2D/Allomancytable/Steelglow"
@onready var Tinglow = $"Camera2D/Allomancytable/Tinglow"
@onready var Pewterglow = $"Camera2D/Allomancytable/Pewterglow"
@onready var Zincglow = $"Camera2D/Allomancytable/Zincglow"
@onready var Brassglow = $"Camera2D/Allomancytable/Brassglow"
@onready var Copperglow = $"Camera2D/Allomancytable/Copperglow"
@onready var Bronzeglow = $"Camera2D/Allomancytable/Bronzeglow"



var ACCEL = 15.0
var DECCEL = 20.0
var MAXSPD = 200.0
var JUMP_VELOCITY = -200.0

var time_since_right = 0
var time_since_left = 0

var Iron = 0 
var Steel = 0
var Tin = 0
var Pewter = 0
var Zinc = 0
var Brass = 0
var Copper = 0
var Bronze = 0
var Gold = 0
var Atium = 0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	Iron += 0.024*delta
	if Iron >= 1:
		Iron = 1
	Steel += 0.024*delta
	if Steel >= 1:
		Steel = 1
	Tin += 0.024*delta
	if Tin >= 1:
		Tin = 1
	Pewter += 0.024*delta
	if Pewter >= 1:
		Pewter = 1
	Zinc += 0.024*delta
	if Zinc >= 1:
		Zinc = 1
	Brass += 0.024*delta
	if Brass >= 1:
		Brass = 1
	Copper += 0.024*delta
	if Copper >= 1:
		Copper = 1
	Bronze += 0.024*delta
	if Bronze >= 1:
		Bronze = 1
	
	Ironglow.vertex_colors[0].a = Iron
	Steelglow.vertex_colors[0].a = Steel
	Tinglow.vertex_colors[0].a = Tin
	Pewterglow.vertex_colors[0].a = Pewter
	Zincglow.vertex_colors[0].a = Zinc
	Brassglow.vertex_colors[0].a = Brass
	Copperglow.vertex_colors[0].a = Copper
	Bronzeglow.vertex_colors[0].a = Bronze

	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var direction := Input.get_axis("move_left", "move_right") # defining velocity

		
#defining variables for techy stuff
	var _FPER_LEFT: bool = time_since_right <=5 and Input.is_action_just_pressed("move_left")
	var _FPER_RIGHT: bool = time_since_left <=5 and Input.is_action_just_pressed("move_right")
	
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
	#sure that no errors occu

	if true:
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
			velocity.x = move_toward(velocity.x, 0, DECCEL/16)
	time_since_left +=1
	time_since_right +=1
	move_and_slide()
