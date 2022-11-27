extends YSort

enum {
	RIGHT
	DOWN
	LEFT
}

onready var FNF_FAN: PackedScene = preload("res://SRC/Enemies/FNFFAN.tscn")
onready var Truck_Driver_Girl: PackedScene = preload("res://SRC/Enemies/Truck_Driver_Gurl.tscn")
onready var Sticker: PackedScene = preload("res://SRC/Level_Stuff/WomanWithCornDogSticker.tscn")

func _ready() -> void:
	Globals.connect("Sticker_Collected", self, "Start_Sticker_Timer")

func Start_Sticker_Timer() -> void:
	$Timers/Sticker_Spawner.start()

func _on_FNF_Fan_Spawner_timeout() -> void:
	var FNF_FAN_INST: KinematicBody2D = FNF_FAN.instance()
	var Different_Positions: Array = [RIGHT, DOWN, LEFT]
	var Rand_Pos: int = Different_Positions[randi() % Different_Positions.size()]
	
	$Enemies.add_child(FNF_FAN_INST)
	
	match Rand_Pos:
		RIGHT:
			FNF_FAN_INST.global_position = Vector2(-20, rand_range(96, 250))
		DOWN:
			FNF_FAN_INST.global_position = Vector2(rand_range(0, 300), 260)
		LEFT:
			FNF_FAN_INST.global_position = Vector2(310, rand_range(96, 250))


func _on_Trucker_Girl_Spawner_timeout() -> void:
	var Different_Positions: Array = [RIGHT, LEFT]
	var TDG_Inst: Area2D = Truck_Driver_Girl.instance()
	$Enemies.add_child(TDG_Inst)
	var Rand_Pos: int = Different_Positions[randi() % Different_Positions.size()]
	match Rand_Pos:
		RIGHT:
			TDG_Inst.global_position = Vector2(-35, rand_range(96, 250))
			TDG_Inst.dir = 1
		LEFT:
			TDG_Inst.global_position = Vector2(325, rand_range(96, 250))
			TDG_Inst.dir = -1
	


func _on_Sticker_Spawner_timeout() -> void:
	var Sticker_Inst: Area2D = Sticker.instance()
	$Sticker_Container.add_child(Sticker_Inst)
	Sticker_Inst.global_position = Vector2(rand_range(20, 280), rand_range(105, 230))
	


func _on_Start_Doing_Stuff_timeout() -> void:
	$Tutorial.hide()
	$Timers/Sticker_Spawner.start()
	$Timers/Trucker_Girl_Spawner.start()
	$Timers/FNF_Fan_Spawner.start()
