extends Control

enum EffectLevel {
	Perfect,
	VeryGood,
	Good,
	Bad
}

var popupscene = preload("res://scenes/main/popup.tscn")


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

# 播放特效
func play_effect(level):
	#get_node("ShakeEffect").play("play")
	var pop = popupscene.instance()
	add_child(pop)
	match level:
		Perfect:
			pop.set_texture("res://scenes/main/1.png")
		VeryGood:
			pop.set_texture("res://scenes/main/2.png")
		Good:
			pop.set_texture("res://scenes/main/3.png")
		Bad:
			pop.set_texture("res://scenes/main/5.png")
