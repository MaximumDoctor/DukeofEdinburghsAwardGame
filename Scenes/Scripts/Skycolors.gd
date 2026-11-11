extends Sprite2D

var skycolor4 = Color(0.081, 0.135, 0.228, 1.0)
var skycolor3 = Color(0.132, 0.173, 0.338, 1.0) 
var skycolor2 = Color(0.105, 0.137, 0.191, 1.0)
var skycolor1 = Color(0.15,0.15,0.3,1.0) 

var lastCol = 1

var currentCol = skycolor1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.modulate = currentCol


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if lastCol == 1:
		currentCol = lerp(currentCol, skycolor2,0.01)
	elif lastCol == 2:
		currentCol = lerp(currentCol, skycolor3,0.01)
	elif lastCol == 3:
		currentCol = lerp(currentCol, skycolor4,0.01)
	elif lastCol == 4:
		currentCol = lerp(currentCol, skycolor1,0.01)
		
	if currentCol.is_equal_approx(skycolor1):
		lastCol =1
	elif currentCol.is_equal_approx(skycolor2):
		lastCol =2
	elif currentCol.is_equal_approx(skycolor3):
		lastCol =3
	elif currentCol.is_equal_approx(skycolor4):
		lastCol =4
		
	self.modulate=currentCol

	
