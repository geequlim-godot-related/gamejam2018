const Constants = preload("./constants.gd")
const ACCEPT_DURATION = 0.1#0.833
const SCORE = 100

var time = 0
var key = Constants.btAny
var disposed = false
var header = false

# 处理事件, 返回得分
func process(p_time, btn):
	if not disposed and accept_button(btn):
		var time_offset = abs(p_time - time)
		if time_offset <= ACCEPT_DURATION:
			disposed = true
			return calculate_score(time_offset)
	return 0
	
func calculate_score(p_time_offset):
	# TODO: 计算得分
	if p_time_offset <= 0.02:
		return SCORE
	elif p_time_offset <= 0.06:
		return SCORE/2
	elif p_time_offset <= 0.1:
		return SCORE/4
	return 0

# 检查是否接受按键事件
func accept_button(btn):
	return key & btn