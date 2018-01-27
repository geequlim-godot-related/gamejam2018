extends Control
const Constants = preload("../../scripts/constants.gd")

var time = 0
var level = null

# 按钮按下事件
signal action_button_pressed(btn)

func _ready():
	level = get_node("/root/global").utils.parse_level(
		{
			"name": "小苹果",
			"actions": [
				"0:5:01 L",
				"0:10:05 R",
				"0:15:10 RH"
			]
		}
	)
	connect("action_button_pressed", self, "on_button_pressed")

func _process(delta):
	time += delta

func _input(event):
	if event.is_pressed() and not event.is_echo():
		if event.is_action("ui_left"):
			emit_signal("action_button_pressed", Constants.btLeft)
		elif event.is_action("ui_right"):
			emit_signal("action_button_pressed", Constants.btRight)
		elif event.is_action("ui_select"):
			emit_signal("action_button_pressed", Constants.btAny)

func on_button_pressed(btn):
	for a in level.actions:
		var score = a.process(time, btn)
		if score > 0:
			level.score += score
			printt("Action trigger:", inst2dict(a))