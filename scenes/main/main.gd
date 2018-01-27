extends Control
const Constants = preload("../../scripts/constants.gd")
var last_button = 0
var level = null

# 按钮按下事件
signal action_button_pressed(btn)

func _ready():
	level = preload("../../scripts/level.gd").new()
	level.load(preload("../../assets/levels/level1.gd").DATA)
	
	level.start()
	connect("action_button_pressed", self, "on_button_pressed")

func _process(delta):
	level.process(delta, last_button)

func _input(event):
	last_button = 0
	if event.is_pressed() and not event.is_echo():
		if event.is_action("ui_left"):
			emit_signal("action_button_pressed", Constants.btLeft)
		elif event.is_action("ui_right"):
			emit_signal("action_button_pressed", Constants.btRight)
		elif event.is_action("ui_select"):
			emit_signal("action_button_pressed", Constants.btAny)

func on_button_pressed(btn):
	last_button = btn