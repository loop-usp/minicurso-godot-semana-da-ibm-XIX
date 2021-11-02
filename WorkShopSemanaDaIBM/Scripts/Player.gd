extends KinematicBody2D

# Export Var
export var speed : int = 300
export(int, 10, 50) var gravity : int = 20

# Var
var is_on_floor : bool
var vel : Vector2 = Vector2()
var is_attacking := false

# Const
const JUMP_SPEED : int = -500
const POS_ATTACK_X : int = 73

# Enum
enum { RIGHT, LEFT }

# Signal
signal on_hit

func _ready():
	pass


func _process(_delta):
	if vel.x > 0:
		turn(RIGHT)
	elif vel.x < 0:
		turn(LEFT)
	
	if is_attacking:
		$AnimatedSprite.play("attack1")
	else:
		if !is_on_floor:
			if vel.y >= 0:
				$AnimatedSprite.play("fall")
			else:
				$AnimatedSprite.play("jump")
		else :
			if vel.x == 0:
				$AnimatedSprite.play("idle")
			else :
				$AnimatedSprite.play("run")
		
func _physics_process(_delta):
	is_on_floor = is_on_floor()
	if Input.is_action_pressed("move_left"):
		vel.x = -speed
		
	if Input.is_action_pressed("move_right"):
		vel.x = speed
		
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		vel.x = 0
		
	if Input.is_action_just_pressed("jump"):
		if is_on_floor:
			vel.y = JUMP_SPEED
	
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		#execute_attack()
						
	vel.y += gravity
	vel = move_and_slide(vel, Vector2.UP) # Vector2.UP = (0,-1)



func turn(side : int) -> void:
	if side == RIGHT:
		$AnimatedSprite.flip_h = false
		$HurtboxAttack.position.x = POS_ATTACK_X
	else:
		$AnimatedSprite.flip_h = true
		$HurtboxAttack.position.x = -POS_ATTACK_X


#func execute_attack():
#	pass


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "attack1":
		emit_signal("on_hit")
		is_attacking = false


func _on_AnimatedSprite_frame_changed():
	if $AnimatedSprite.animation == "attack1":
		if $AnimatedSprite.frame == 1:
			$HurtboxAttack.monitoring = true
		elif $AnimatedSprite.frame == 2:
			$HurtboxAttack.monitoring = false







func _on_HurtboxAttack_body_entered(body):
	body.take_hit()
