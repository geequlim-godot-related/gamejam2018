extends Control
const Constants = preload("../../scripts/constants.gd")
var last_button = 0
var level = null
onready var global = get_node('/root/global')
# 按钮按下事件
signal action_button_pressed(btn)

func _ready():
	level = preload("../../scripts/level.gd").new()
	level.load(preload("../../assets/levels/level1.gd").DATA)
	level.connect("add_score", self, "_on_add_score")
	level.start()
	connect("action_button_pressed", self, "on_button_pressed")

func _process(delta):
	level.process(delta, last_button)
	get_node("Time").set_text(String(level.time))
	get_node("UI/ScoreTexture/score").set_text(String(level.score))
	get_node("UI/ComboTexture/combo").set_text(String(level.combo))
	last_button = 0
	
func _input(event):
	if event.is_pressed() and not event.is_echo():
		if event.is_action("ui_left"):
			emit_signal("action_button_pressed", Constants.btLeft)
		elif event.is_action("ui_right"):
			emit_signal("action_button_pressed", Constants.btRight)
		elif event.is_action("ui_select"):
			emit_signal("action_button_pressed", Constants.btAny)

func on_button_pressed(btn):
	last_button = btn
	
# 加分表现，逻辑分数已经结算，这里只需做出表现即可
func _on_add_score(addition):
	# TODO: 加分表现
	print(level.Utils.time_to_expression(level.time), " 按下了: ", last_button, " 加分:", addition, " 总分:", level.score, ' 连击:', level.combo)