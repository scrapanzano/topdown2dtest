extends Area2D

export (float) var speed = 1
export var length = Vector2()


func _ready():
	move()


func move():
	$Tween.interpolate_property(
		self,
		"position",
		global_position,
		global_position + length,
		speed,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT
	)
	
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	length *= -1
	move()
