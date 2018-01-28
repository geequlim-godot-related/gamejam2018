extends Panel

onready var global = get_node('/root/global')
func _ready():
	get_node("score/score").text = str(global.get_level().score)


func _on_restart():
	get_tree().change_scene("res://scenes/main/main.tscn")
