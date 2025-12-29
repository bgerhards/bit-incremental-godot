# File: res://scripts/main.gd
# Attach to: Main (Control)

extends Control

@onready var bits_label: Label = $Center/UI/BitsLabel
@onready var items_container: VBoxContainer = $Center/UI/ItemsContainer
const item_scene = preload("res://scenes/item_container.tscn")

var bits: float = 0.0

var bits_per_click: float = 1.0
var bits_per_sec: float = 0.0

var click_level: int = 1
var auto_level: int = 0

func _ready() -> void:
	#_load_game()
	BitManager.bits_changed.connect(_on_bits_changed)
	_load_items()
	_refresh_ui()

func _on_bits_changed(_bits: float):
	_refresh_ui()

func _refresh_ui() -> void:
	bits_label.text = "Bits: " + _fmt(BitManager.get_current_bits())

func _fmt(value: float) -> String:
	# Beginner-friendly formatting (you can upgrade this later)
	if value >= 1000000.0:
		return "%.2fM" % (value / 1000000.0)
	if value >= 1000.0:
		return "%.2fK" % (value / 1000.0)
	if value == floor(value):
		return str(int(value))
	return "%.2f" % value

func _load_items():
	var zeds: Array[Zed] = [
		Zed.new("Shambler", 0, true),
		Zed.new("Rotters", 1000),
		Zed.new("Shambler", 0, true),
		Zed.new("Rotters", 1000),
		Zed.new("Shambler", 0, true),
		Zed.new("safasd", 1000),
		Zed.new("Shambler", 0, true),
		Zed.new("Rotters", 1000),
		Zed.new("Shambler", 0, true),
		Zed.new("Rotters", 1000),
		Zed.new("Shambler", 0, true),
		Zed.new("f", 1000),
		Zed.new("Shambler", 0, true),
		Zed.new("Rotters", 1000)
		]
	for zed in zeds:
		var node = item_scene.instantiate()
		node.set_meta("zed", zed)
		items_container.add_child(node)
