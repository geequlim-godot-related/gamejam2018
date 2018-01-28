extends Panel

var star_node

func _ready():
	star_node = get_node("TextureButton")
	star_node.connect("pressed", self, "star_game")

func star_game():
	get_tree().change_scene("res://scenes/main/main.tscn")