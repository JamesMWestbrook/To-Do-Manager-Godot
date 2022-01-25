extends Control

export(PackedScene) var task
var tasks = []
onready var task_list = $ScrollContainer/VBoxContainer
var time = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time >= 900:
		time = 0
		_on_save_pressed()
	

func _get_tasks():
	tasks = task_list.get_children()


func _on_remove_pressed():
	pass # Replace with function body.



func _on_add_pressed():
	_create_task()

func _create_task(task_name = "Name", priority = 1, value = 0):
	var new_task = task.instance()
	task_list.add_child(new_task)

	new_task.label.text = task_name
	new_task.priority = priority
	new_task.value = value
	new_task._update_text()
	new_task.connect("complete", self, "_task_complete")
	
	
	
func _task_complete(node):
	node.value = 0
	task_list.remove_child(node)
	task_list.add_child(node)
	
	_run_tasks()
	

func _run_tasks():
	for i in task_list.get_children():
		i.value += i.priority
	
	for i in task_list.get_children().size():
		for q in task_list.get_children().size():
			var a = task_list.get_child(q)
			var b
			if q == 0:
				b = 1
				print("d")
			elif q == task_list.get_children().size() - 1:
				pass
			else:
				b = q + 1
			if b != null:
				b = task_list.get_child(b)
				
				if b.value > a.value:
					print("Bigger: ", String(a.value), " : ",String(b.value))
					task_list.remove_child(a)
					task_list.add_child(a)


func _on_save_pressed():
	var data = []
	for i in task_list.get_children():
		var child = {}
		child.label = i.label.text
		child.priority = i.priority
		child.value = i.value
		data.append(child)
	var save = File.new()
	var no = "user://"
	no += $name_edit.text
	no += ".json"
	save.open(no, File.WRITE)
	save.store_string(to_json(data))
	save.close()



func _on_load_pressed():
	var save = File.new()
	var no = "user://"
	no += $name_edit.text
	no += ".json"
	save.open(no,  File.READ)
	
	var data = parse_json( save.get_as_text())
	
	for i in task_list.get_children():
		i.queue_free()
		
	for i in data:
		print(i.label)
		_create_task(i.label, i.priority, i.value)
	
	save.close()




func _on_plus_pressed():
	_create_task()


func _on_delete_pressed():
	var no = "user://"
	no += $name_edit.text
	no += ".json"
	
	var dir = Directory.new()
	dir.open("user://")
	if(dir.file_exists(no)):
		dir.remove(no)
	
	get_parent().queue_free()
