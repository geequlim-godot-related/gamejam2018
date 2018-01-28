extends Node2D

onready var global = get_node('/root/global')
export var score = 0
var speed = 5
var level = null
var is_lead = false

func _ready():
	is_lead = score == 0
	if !is_lead:
		global.connect("npc_left", self, "play_left")
		global.connect("npc_right", self, "play_right")
		global.connect("npc_head", self, "play_head")
	else:
		global.connect("lead_left", self, "play_left")
		global.connect("lead_right", self, "play_right")
		global.connect("lead_head", self, "play_head")	
	
# 处理动作，播放动画
func process_action(act):
	pass

func play_left():
	level = get_parent().get_parent().level
	if level.get_progress() < score:
		return
	get_node("l_leg_player").playback_speed = speed
	get_node("l_leg_player").play("play")
		
	
func play_right():
	level = get_parent().get_parent().level
	if level.get_progress() < score:
		return
	get_node("r_leg_player").playback_speed = speed
	get_node("r_leg_player").play("play")
	
func play_head():
	level = get_parent().get_parent().level
	if level.get_progress() < score:
		return
	get_node("head_player").playback_speed = speed
	get_node("head_player").play("play")