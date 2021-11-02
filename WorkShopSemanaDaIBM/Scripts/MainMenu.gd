extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var next_scene : PackedScene = load("res://Scenes/MainScene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.grab_focus()
	$Button/Label.text = "jogar"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene_to(next_scene)
