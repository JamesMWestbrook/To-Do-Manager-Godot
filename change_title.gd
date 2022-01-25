extends Tabs


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Window.get_node("name_edit").connect("text_changed", self, "_change_name" )

func _change_name(change):
	name = change
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
