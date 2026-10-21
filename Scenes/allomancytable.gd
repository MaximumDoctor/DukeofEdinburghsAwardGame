extends Node2D

@onready var camera = get_parent()

@onready var canvasmodulate = $"../CanvasModulate"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	Engine.time_scale = 1.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position = camera.get_screen_center_position()
	
	if Input.is_action_pressed("Allomancy"):
		visible = true
		canvasmodulate.visible = true
		Engine.time_scale = 0.3
	else:
		visible = false
		canvasmodulate.visible = false
		Engine.time_scale = 1.0
