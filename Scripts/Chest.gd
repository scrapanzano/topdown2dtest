extends StaticBody2D

export (PackedScene) var loot_scene

export (float) var speed = 1
export var length = Vector2()

var opened : bool = false
var active : bool = false


func _unhandled_input(event):
	if Input.is_action_just_pressed("player_interract") && active:
		opened = true
		active = false
		$AnimationPlayer.play("Opened")
		yield(get_node("AnimationPlayer"), "animation_finished")
		var loot = loot_scene.instance()
		add_child(loot)
		loot.position = $LootSpawnPoint.position


func _on_PlayerDetector_body_entered(body):
	if body.name == "Player":
		active = true
