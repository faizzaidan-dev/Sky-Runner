extends KinematicBody2D

var motion = Vector2(0,0.2)
var speed = 200
var jumpforce = -800
var gravity = 35

onready var sprite = $AnimatedSprite

func _physics_process(delta):
	
	if Input.is_action_pressed("right"):
		motion.x = speed
		sprite.play("run")
		sprite.flip_h = false
		
	elif Input.is_action_pressed("left"):
		motion.x = -speed
		sprite.play("run")
		sprite.flip_h = true
		
	else:
		sprite.play("idle")
	if not is_on_floor():
		sprite.play("jump")
		
	motion.y = motion.y + gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		motion.y = jumpforce
		$AudioStreamPlayer2D.play()
		
	motion = move_and_slide(motion,Vector2.UP)
	motion.x = lerp(motion.x,0,0.2)
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Control.tscn")
		
		
		


func _on_Area2D_body_entered(body):
	get_tree().reload_current_scene()


func _on_Area2D2_body_entered(body):
	get_tree().change_scene("res://Node2D.tscn")
	$AudioStreamPlayer2D2.play()
