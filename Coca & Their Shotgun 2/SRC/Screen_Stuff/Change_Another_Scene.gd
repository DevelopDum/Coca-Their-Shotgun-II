extends Node2D

export (String) var Event: String = ""
export (String, FILE) var Next_Scene: String

func _ready() -> void:
	if name == "Start_Screen":
		NGio.request("Medal.unlock", {"id": 71822})
	if name == "Game_Over_Screen":
		NGio.request("ScoreBoard.postScore", {"id": 12358, "value": Globals.Stickers})

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(Event):
		Globals.Stickers = 0
		get_tree().change_scene(Next_Scene)
