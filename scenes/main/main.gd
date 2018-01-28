extends Control
const Constants = preload("../../scripts/constants.gd")
const EffectView = preload("res://scenes/main/effect.gd")

var last_button = 0
var level = null
onready var global = get_node('/root/global')
# 按钮按下事件
signal action_button_pressed(btn)

func _ready():
	level = preload("../../scripts/level.gd").new()
	level.load(preload("../../assets/levels/level1.gd").DATA)
	level.connect("add_score", self, "_on_add_score")
	global.connect("clear_key_level", self, "_on_add_score", [0])
	global.connect("block", self, "show_block")
	global.connect("combo_disposed", self, "combo_disposed")
	connect("action_button_pressed", self, "on_button_pressed")
	get_node("UI/Restart").connect("pressed", level, "restart")
	

# 开始关卡
func on_start():
	level.start()

# 开始关卡
func on_start():
	level.start()

func _process(delta):
	level.process(delta, last_button)
	get_node("Time").set_text(String(level.time))
	get_node("UI/ScoreTexture/score").set_text(String(level.score))
	if level.combo >= 1:
		get_node("UI/ComboTexture").show()
	else:
		get_node("UI/ComboTexture").hide()
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
	var node = get_node("UI/KeyLevel")
	if addition >50:
		get_node("Effect").play_effect(EffectView.EffectLevel.Perfect)
	elif addition >25:
		get_node("Effect").play_effect(EffectView.EffectLevel.VeryGood)
	elif addition >10:
		get_node("Effect").play_effect(EffectView.EffectLevel.Good)
	elif addition > 0:
		get_node("Effect").play_effect(EffectView.EffectLevel.Bad)
	if addition > 0:
		print(level.Utils.time_to_expression(level.time), " 按下了: ", last_button, " 加分:", addition, " 总分:", level.score, ' 进度:', level.get_progress(),' 连击:', level.combo)
		
func show_block():
	var block = get_node("block").duplicate()
	add_child(block)
	block.show()
	block.get_node("AnimationPlayer").play("block")
	block.get_node("AnimationPlayer").connect("animation_finished", self, "free_block", [block])
	
func free_block(animation ,block):
	remove_child(block)
	block.free()
	
func combo_disposed():
	level.combo = 0
