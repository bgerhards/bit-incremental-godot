extends Node

const SAVE_PATH := "user://save.json"

var game_State: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _onready():
	pass

#func _save_game() -> void:
	#var data := {
		#"bits": bits,
		#"bits_per_click": bits_per_click,
		#"bits_per_sec": bits_per_sec,
		#"click_level": click_level,
		#"auto_level": auto_level
	#}
	#var f := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	#if f:
		#f.store_string(JSON.stringify(data))
#
#func _load_game() -> void:
	#if not FileAccess.file_exists(SAVE_PATH):
		#return
#
	#var f: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
	#if not f:
		#return
#
	#var parsed: Variant = JSON.parse_string(f.get_as_text())
	#if typeof(parsed) != TYPE_DICTIONARY:
		#return
#
	#var data: Dictionary = parsed
#
	#bits = float(data.get("bits", 0.0))
	#click_level = int(data.get("click_level", 1))
	#auto_level = int(data.get("auto_level", 0))
#
	## Recompute derived values (safer than trusting save)
	#bits_per_click = float(click_level)
	#bits_per_sec = float(auto_level) * 0.5
