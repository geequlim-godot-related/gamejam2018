extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var popupImage = get_node("PopUpImage")

func _init():
	pass

func set_texture(resname):
	popupImage.texture = load(resname)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass



func _on_PopUp_animation_finished( anim_name ):
	queue_free() # replace with function body
