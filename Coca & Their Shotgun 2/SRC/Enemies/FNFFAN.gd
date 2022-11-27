extends KinematicBody2D

var Velocity: Vector2 = Vector2.ZERO
var Accel: float = 2500
var Max_Speed: float = 105

var HP: int = 1
export (bool) var Is_Attacking: bool = false

var Player: KinematicBody2D = null
onready var Body_Anim: AnimationNodeStateMachinePlayback = $Anims/AnimationTree.get("parameters/playback")

func _ready() -> void:
	Is_Attacking = false
	var Player_Group: Array = get_tree().get_nodes_in_group("Player")
	Player = Player_Group[0]

func _physics_process(delta: float) -> void:
	if Player != null && Is_Attacking == false:
		var Dir: Vector2 = (Player.global_position - global_position).normalized()
		Velocity = Velocity.move_toward(Dir * Max_Speed, Accel * delta)
	else:
		Velocity = lerp(Velocity, Vector2.ZERO, 0.2)
	
	if Is_Attacking == false:
		if Velocity.x > 0:
			$Sprite.flip_h = true
			$Hitboxes.scale.x = -1
		else:
			$Sprite.flip_h = false
			$Hitboxes.scale.x = 1
	Velocity = move_and_slide(Velocity)

func ouch() -> void:
	HP -= 1
	if HP <= 0:
		queue_free()


func _on_Player_Detector_body_entered(body: Node) -> void:
	if body.name == "Coca":
		Body_Anim.travel("Attack")


func _on_Hitbox_body_entered(body: Node) -> void:
	if body.name == "Coca":
		body.ouch()
