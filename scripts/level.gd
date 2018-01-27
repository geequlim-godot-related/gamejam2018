const Action = preload("action.gd")
const Constants = preload("constants.gd")
const Utils = preload("utils/utils.gd")

var name = "关卡"
var actions = []
var score = 0
var time = 0
var bgm_stream = null
var bgm_offset = 10.0

func start():
	score = 0
	time = 0
	global.play_background_music(bgm_stream, bgm_offset)

func process(delta, last_btn):
	time += delta
	for a in actions:
		var s = a.process(time, last_btn)
		if s > 0:
			# TODO: 派发加分事件
			score += s
			printt(inst2dict(a))

func load(dict):
	self.name = dict['name']
	self.bgm_stream = load(str("res://assets/bgm/", dict['bgm']['file']))
	self.bgm_offset = Utils.parse_time_expression(dict['bgm']['offset'])
	for ad in dict['actions']:
		var time_key_pair = ad.split(" ")
		if not ad.empty() and time_key_pair.size() == 2:
			var a = Action.new()
			a.time = Utils.parse_time_expression(time_key_pair[0])
			var key_part = time_key_pair[1]
			a.header = key_part.find("H") != -1
			if key_part.find("L") != -1:
				a.key = Constants.btLeft
			elif key_part.find("R") != -1:
				a.key = Constants.btRight
			else:
				printt("关卡按键配置错误：", ad)
				continue
			self.actions.append(a)
		else:
			printt("关卡配置错误：", ad)