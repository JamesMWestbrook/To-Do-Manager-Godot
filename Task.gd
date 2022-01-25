extends Control

var priority = 1
var value = 0
onready var label = $TextEdit

signal complete(node)


func _ready():
	_update_text()


func _update_text():
	$priority_label.text = "Priority: " + String(priority)

func _on_minus_pressed():
	priority -= 0.1
	priority = clamp(priority, 0.1, 5)
	_update_text()

func _on_plus_pressed():
	priority += 0.1
	priority = clamp(priority, 0.1, 5)
	_update_text()



func _on_Complete_button_down():
	emit_signal("complete", self)


func _on_del_pressed():
	queue_free()
