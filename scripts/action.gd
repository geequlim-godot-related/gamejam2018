const Constants = preload("./constants.gd")
const ACCEPT_DURATION = 1#0.833
const SCORE = 10

var time = 0
var key = Constants.btAny
var disposed = false
var header = false

# 处理事件, 返回得分
func process(p_time, btn):
	if not disposed:
		if abs(p_time - time) <= ACCEPT_DURATION:
			disposed = true
			return SCORE
	return 0

# 检查是否接受按键事件
func accept_button(btn):
	return key & btn