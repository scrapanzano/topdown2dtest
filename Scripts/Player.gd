extends KinematicBody2D

export (float) var speed = 120.0


var velocity  = Vector2.ZERO
var state = MOVE

var has_sword : bool = false

enum {
	MOVE,
	ATTACK
}

func _physics_process(delta) -> void:
	match state:
		MOVE:
			move_state()
		ATTACK:
			attack_state()


func get_direction_as_string():
	var dir = $RayCast2D.cast_to
	if dir.x > 0:
		return "Right"
	else:
		return "Left"


func move_state() -> void:
	var movement = Vector2.ZERO
	
	movement.x = Input.get_axis("ui_left", "ui_right")
	movement.y = Input.get_axis("ui_up", "ui_down")
	movement = movement.normalized()
	
	velocity += movement * speed
	velocity = velocity.clamped(speed)
	
	if movement.x != 0:
		$RayCast2D.cast_to = movement * 16
		$AnimationPlayer.play("Walk" + get_direction_as_string())
	elif movement.y != 0:
		$AnimationPlayer.play("Walk" + get_direction_as_string())
	else:
		velocity = Vector2.ZERO
		$AnimationPlayer.play("Idle" + get_direction_as_string())
	
	if has_sword:
		if Input.is_action_just_pressed("player_attack"):
			state = ATTACK
	
	
	move_and_slide(velocity)
	


func attack_state() -> void:
	velocity = Vector2.ZERO
	$AnimationPlayer.play("Attack" + get_direction_as_string())
	yield(get_node("AnimationPlayer"), "animation_finished")
	state = MOVE

