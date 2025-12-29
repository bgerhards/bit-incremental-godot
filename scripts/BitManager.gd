extends Node

signal bits_changed(new_total: float)

var bits: float = 0.0
const SAVE_PATH := "user://save.json"

func _ready():
	pass

func _process(_delta):
	pass
	
func emit_bits_changed():
	emit_signal("bits_changed", bits)

func add_bits(incoming_bits: float):
	bits += incoming_bits
	emit_bits_changed()
	
func make_purchase(amount: float) -> bool:
	if(amount > bits):
		return false
	bits -= amount
	emit_bits_changed()
	return true

func get_current_bits() -> float:
	return float(bits)
