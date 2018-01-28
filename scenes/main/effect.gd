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
	pop.set_texture("res://icon.png")
