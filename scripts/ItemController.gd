extends Node

@onready var item_label: Label = $ItemLabel
@onready var item_level: Label = $ItemLevelLabel
@onready var rates_label: Label = $ItemRatesLabel
@onready var unlock_click_button: Button = $ItemUnlockButton
@onready var upgrade_auto_button: Button = $ItemUpgradeAutoButton

@onready var tick_timer: Timer = $TickTimer
var bits_per_sec: float = 0.0
var speed_multiplier: float = 1.0

var auto_level: int = 0
var unlock_cost: float = 0

var unlocked: bool = false

var zed: Zed
var base_cost: float

var _income_buffer: float = 0.0

func _ready() -> void:
	zed = get_meta("zed")
	item_label.text = zed.type
	if(zed.unlocked):
		unlocked = zed.unlocked
		_upgrade_auto()
	base_cost = zed.unlock_bits if zed.unlock_bits > 0.0 else 1.0

	unlock_click_button.pressed.connect(_on_unlock_pressed)
	upgrade_auto_button.pressed.connect(_on_upgrade_auto_pressed)
	BitManager.bits_changed.connect(_on_bits_changed)
	
	_refresh_ui()
	
func _process(delta: float):
	var income := bits_per_sec * speed_multiplier * delta
	if income <= 0.0:
		return
		
	_income_buffer += income

	if _income_buffer >= bits_per_sec:
		BitManager.add_bits(_income_buffer)
		_income_buffer = 0.0
		_refresh_ui()

func _on_bits_changed(_bits: float):
	_refresh_ui()

func _on_unlock_pressed() -> void:
	var upgrade_successful = BitManager.make_purchase(zed.unlock_bits)
	if !upgrade_successful:
		return
	unlocked = true
	_refresh_ui()
	#_save_game()

func _on_upgrade_auto_pressed() -> void:
	var cost := _auto_upgrade_cost()
	var upgrade_successful = BitManager.make_purchase(cost)
	if !upgrade_successful:
		return
	_upgrade_auto()
		
func _upgrade_auto():
	auto_level += 1
	bits_per_sec = 1 * pow(1.3, float(auto_level))
	speed_multiplier = speed_multiplier * pow(1.01, float(auto_level))
	_refresh_ui()
	#_save_game()

func _auto_upgrade_cost() -> float:
	# 25, 40, 64, 102...
	return floor(base_cost * 2 * pow(1.6, float(auto_level)))

func _refresh_ui() -> void:
	var current_bits = BitManager.get_current_bits()
	rates_label.text = "+%s / sec" % [_fmt(bits_per_sec)]

	if(unlocked):
		upgrade_auto_button.disabled = current_bits < _auto_upgrade_cost()
		upgrade_auto_button.text = "Upgrade (Cost: %s)" % _fmt(_auto_upgrade_cost())
		item_level.text = "Level %s" % auto_level
		unlock_click_button.visible = false
		upgrade_auto_button.visible = true
		item_level.visible = true
	else:
		unlock_click_button.text = "Unlock (Cost: %s)" % _fmt(zed.unlock_bits)
		unlock_click_button.disabled = current_bits < zed.unlock_bits
		unlock_click_button.visible = true
		upgrade_auto_button.visible = false
		item_level.visible = false


func _fmt(value: float) -> String:
	# Beginner-friendly formatting (you can upgrade this later)
	if value >= 1000000.0:
		return "%.2fM" % (value / 1000000.0)
	if value >= 1000.0:
		return "%.2fK" % (value / 1000.0)
	if value == floor(value):
		return str(int(value))
	return "%.2f" % value
