extends Node2D

@onready var camera = get_parent()
@onready var canvasmodulate = $"../ColorRect"
@onready var alloindicator = $"../AllomancyIndicator"
@onready var sprite = $"AnimatedSprite2D"
@onready var bar = $"ColorRect"
@onready var player = get_parent().get_parent()

var mouseAngle = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canvasmodulate.visible = false
	visible = false
	Engine.time_scale = 1.0
	sprite.frame = 8
	bar.size.x = 124
	alloindicator.frame = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position = camera.get_screen_center_position()
	alloindicator.global_position = camera.get_screen_center_position() + Vector2(-340,-170)
	if Input.is_action_pressed("Allomancy"):
		visible = true
		canvasmodulate.visible = true
		Engine.time_scale = 0.15
		canvasmodulate.visible = true
		mouseAngle = rad_to_deg(get_local_mouse_position().angle())
	elif Input.is_action_just_released("Allomancy"):
		visible = false
		Engine.time_scale = 1.0
		canvasmodulate.visible=false
	
	if mouseAngle > -180 and mouseAngle < -135: #1
		sprite.frame = 0
		bar.color = Color.RED
		bar.size.x = player.Iron / 0.00806451612
		alloindicator.frame = 0
	if mouseAngle > -135 and mouseAngle < -90: #2
		sprite.frame = 1
		bar.color = Color.DODGER_BLUE
		bar.size.x = player.Steel / 0.00806451612
		alloindicator.frame = 1
	if mouseAngle > -90 and mouseAngle < -45: #3
		sprite.frame = 2
		bar.color = Color.LIME_GREEN
		bar.size.x = player.Tin / 0.00806451612
		alloindicator.frame = 2
	if mouseAngle > -45 and mouseAngle < 0: #4
		sprite.frame = 3
		bar.color = Color(1.0, 0.863, 0.0, 1.0)
		bar.size.x = player.Pewter / 0.00806451612
		alloindicator.frame = 3
	if mouseAngle > 0 and mouseAngle < 45: #5
		sprite.frame = 4
		bar.color = Color.PALE_VIOLET_RED		
		bar.size.x = player.Zinc / 0.00806451612
		alloindicator.frame = 4
	if mouseAngle > 45 and mouseAngle < 90: #6
		sprite.frame = 5
		bar.color = Color.DARK_ORANGE		
		bar.size.x = player.Brass / 0.00806451612
		alloindicator.frame = 5
	if mouseAngle > 90 and mouseAngle < 135: #5
		sprite.frame = 6
		bar.color = Color.DARK_TURQUOISE
		bar.size.x = player.Copper / 0.00806451612
		alloindicator.frame = 6
	if mouseAngle > 135 and mouseAngle < 180: #6
		sprite.frame = 7
		bar.color = Color.SADDLE_BROWN
		bar.size.x = player.Bronze / 0.00806451612
		alloindicator.frame = 7

	
	
