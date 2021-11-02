extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gravity := 20
var vel := Vector2()

var vida : int = MAX_VIDA

const MAX_VIDA = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	# $Sprite/AnimationPlayer.play("idle")
	$AnimatedSprite.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(_delta):
	vel.y += gravity
	vel = move_and_slide(vel, Vector2.UP) # Vector2.UP = (0,-1)

func take_hit():
	vida -= 1
	if vida == 0:
		die()
		
func die():
	$AnimatedSprite.play("die")
	$Collision.position.y -= 20
	self.set_collision_layer_bit(2, false)
	#$Collision.call_deferred("set", "disabled", true)
	#$Collision.disabled = true
	$Timer.start()




func _on_AnimatedSprite_animation_finished():
	pass




func _on_Timer_timeout():
	queue_free()
