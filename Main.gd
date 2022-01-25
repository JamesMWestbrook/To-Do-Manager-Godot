extends Control

export(PackedScene) var window_scene
export(PackedScene) var tab_scene
func _ready():
	var dir = Directory.new()
	if dir.open("user://") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			
			if file_name.get_extension() == "json":
				print(file_name)
				
				var new_tab = tab_scene.instance()
				$TabContainer.add_child(new_tab)
				var new_name = file_name.trim_suffix(".json")
				new_tab.name = new_name
				new_tab.get_node("Window/name_edit").text = new_name
			file_name = dir.get_next()
		for i in $TabContainer.get_children():
			pass
			i.get_node("Window")._on_load_pressed()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_add_pressed():
	var new_tab = tab_scene.instance()
	
	$TabContainer.add_child(new_tab)
	new_tab.name = "Bitch"
