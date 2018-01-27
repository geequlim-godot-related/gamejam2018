################################################################################
# 通用工具类
# Created by Geequlim on 2018/01/26
##############################################################################

# 解析时间表达式
static func parse_time_expression(str_time):
	var time_parts = str_time.split(":")
	if time_parts.size() == 3:
		return int(time_parts[0]) * 60 + int(time_parts[1]) + int(time_parts[2]) / 1000.0
	else:
		printt("时间配置错误:", str_time)
	return 0.0

# 游戏时间转为时间表达式
static func time_to_expression(time):
	var mm = int(time) / 60
	var ss = int(time) % 60
	var ms = int((time - int(time)) * 1000)
	return str(mm,':', ss, ':', ms)