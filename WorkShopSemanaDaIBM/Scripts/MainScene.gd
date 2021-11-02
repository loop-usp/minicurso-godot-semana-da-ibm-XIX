extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var enemy_scene = load("res://Scenes/Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(2), "timeout")
	var enemy = enemy_scene.instance()
	enemy.position.x = 700
	$Enemies.call_deferred("add_child", enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
		
