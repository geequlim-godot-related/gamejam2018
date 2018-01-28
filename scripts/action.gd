const Constants = preload("./constants.gd")
const ACCEPT_DURATION = 0.333
const SCORE = 100

var time = 0
var key = Constants.btAny
var disposed = false
var npc_disposed = false
var block_disposed = false
var combo_disposed = false
var header = false

func init_var():
	disposed = false
	npc_disposed = false
	block_disposed = false
	combo_disposed = false
	
# 处理事件, 返回得分
func process(p_time, btn):
	if not disposed and accept_button(btn):
		var time_offset = abs(p_time - time)
		if time_offset <= ACCEPT_DURATION:
			if key == Constants.btLeft:
				global.emit_signal("lead_left")
			if key == Constants.btRight:
				global.emit_signal("lead_right")
			if header == true:
				global.emit_signal("lead_head")
			disposed = true
			return calculate_score(time_offset)
	elif not disposed && combo_disposed == false:
		if p_time - time > ACCEPT_DURATION:
			global.emit_signal("combo_disposed")
			combo_disposed = true
	elif accept_button(btn):
		# 如果按过再按
		global.emit_signal("clear_key_level")
	
	# npc跳舞
	if not npc_disposed:
		var time_offset = abs(p_time - time)
		if time_offset <= ACCEPT_DURATION:
			if key == Constants.btLeft:
				global.emit_signal("npc_left")
			if key == Constants.btRight:
				global.emit_signal("npc_right")
			if header == true:
				global.emit_signal("npc_head")
			npc_disposed = true
			
	# 方块出现时机
	if not block_disposed:
		if abs(p_time - time) <= 0.8:
			#出现方块
			global.emit_signal("block")
			block_disposed = true
	return 0
	
func calculate_score(p_time_offset):
	if p_time_offset <= 0.02:
		return SCORE
	elif p_time_offset <= 0.06:
		return SCORE/2
	elif p_time_offset <= 0.1:
		return SCORE/4
	else:
		return 0

# 检查是否接受按键事件
func accept_button(btn):
	return key & btn