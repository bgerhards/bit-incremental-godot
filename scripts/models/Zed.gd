class_name Zed extends Resource

var type: String
var unlock_bits: float
var unlocked: bool

func _init(p_type: String, p_unlock_bits: float, p_unlocked = false):
	type = p_type
	unlock_bits = p_unlock_bits
	unlocked = p_unlocked
