################################################################################
# 项目唯一全局单例
# Created by Geequlim on 2018/01/26
################################################################################
extends Node

# 实用工具
const utils = preload("../utils/utils.gd")

# 背景音乐播放器
var _bgm_player = AudioStreamPlayer.new()

signal npc_left
signal npc_right
signal npc_head

signal lead_left
signal lead_right
signal lead_head

signal clear_key_level

signal finished

signal block

func _init():
	_bgm_player.connect("finished", self, "emit_signal", ["finished"])
	add_child(_bgm_player)


# 播放背景音乐
# 停止播放传入null
func play_background_music(stream, offset=0.0):
	_bgm_player.stop()
	_bgm_player.stream = stream
	_bgm_player.play(offset)

# 获取当前bgm的播放位置
func get_background_music_position():
	return 0 if not _bgm_player.playing else _bgm_player.get_playback_position()