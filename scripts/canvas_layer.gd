extends CanvasLayer

var total_coins = 0
var collected_coins = 0

@onready var coins_label=$Control/LabelCoins
@onready var timer_label=$Control/LabelTimer

@export var start_time:float = 10.0
var time_left: float

func _ready():
	var coins = get_tree().get_nodes_in_group("coins")
	total_coins = coins.size()
	_update_label_coins()
	time_left = start_time
		
func _process(delta):
	if time_left<=0.0:
		get_tree().reload_current_scene()
		
	time_left-=delta
	time_left=max(time_left,0.0)
	timer_label.text="%.2f" % time_left
	

func _update_label_coins():
	coins_label.text="%d / %d" %[collected_coins,total_coins]

func coin_collected():
	collected_coins+=1
	if collected_coins == total_coins:
		load_next_level()
	_update_label_coins()
		


func load_next_level():
	var current_scene=get_tree().current_scene
	var current_name=current_scene.scene_file_path
	
	var level_number=int(current_name.get_file().get_basename().replace("level",""))
	var next_level = level_number+1
	
	var next_path="res://scenes/level%d.tscn" % next_level
	get_tree().change_scene_to_file(next_path)
