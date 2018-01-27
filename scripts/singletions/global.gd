################################################################################
# 项目唯一全局单例
# Created by Geequlim on 2018/01/26
################################################################################
extends Node

# 实用工具
const utils = preload("../utils/utils.gd")

# 背景音乐播放器
var _bgm_player = AudioStreamPlayer.new()

func _init():
	add_child(_bgm_player)


# 播放背景音乐
func play_background_music(stream, offset=0.0):
	_bgm_player.stop()
	_bgm_player.stream = stream
	_bgm_player.play(offset)