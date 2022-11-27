extends KinematicBody2D

var Velocity: Vector2 = Vector2.ZERO
var Accel: float = 2500
export (float) var Max_Speed: float = 200
var Bullet_Angle_Index: float = -45

onready var Bullet: PackedScene = preload("res://SRC/Player/Player_Bullet.tscn")
onready var Explosion: PackedScene = preload("res://SRC/Particles_And_Such/Explosion.tscn")
onready var Muzzle: Position2D = $Shotgun/Sprite_Container/Sprite/Muzzle

func _physics_process(delta: float) -> void:
	var Movement_Dir: Vector2 = Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		Input.get_action_strength("Down") - Input.get_action_strength("Up")
	)
	
	Movement_Dir = Movement_Dir.normalized()
	
	if Movement_Dir != Vector2.ZERO:
		Velocity += Movement_Dir * Accel * delta
		Velocity = Velocity.limit_length(Max_Speed)
		$Anims/Body/AnimationPlayer.play("Run")
	else:
		Velocity = lerp(Velocity, Vector2.ZERO, 0.2)
		$Anims/Body/AnimationPlayer.play("Idle")
	
	if Input.is_action_pressed("Shoot") && !$Anims/Shotgun/AnimationPlayer.is_playing():
		$SFX/Shotgun_Shoot.pitch_scale = rand_range(0.9, 2)
		$SFX/Shotgun_Shoot.play()
		$Anims/Shotgun/AnimationPlayer.play("Shoot")
		
		var Explosion_Inst: Sprite = Explosion.instance()
		get_parent().add_child(Explosion_Inst)
		Explosion_Inst.global_position = Muzzle.global_position
		
		for _i in range(3):
			var Bullet_Inst: RigidBody2D = Bullet.instance()
			get_parent().add_child(Bullet_Inst)
			Bullet_Inst.global_position = Muzzle.global_position
			Bullet_Inst.rotation = $Shotgun.rotation
			Bullet_Inst.apply_impulse(Vector2.ZERO, Vector2(300, Bullet_Angle_Index).rotated($Shotgun.rotation))
			Bullet_Angle_Index += 45
		Bullet_Angle_Index = -45
	
	if Input.is_action_just_pressed("ui_accept") && !$Anims/Jump/AnimationPlayer.is_playing():
		$SFX/Jump.pitch_scale = rand_range(0.9, 1.1)
		$SFX/Jump.play()
		$Anims/Jump/AnimationPlayer.play("Jump!")
	
	Flip()
	$Shotgun.look_at(get_global_mouse_position())
	
	global_position.x = clamp(global_position.x, 0, 300)
	global_position.y = clamp(global_position.y, 96, 250)
	
	$CanvasLayer/RichTextLabel.bbcode_text = "Stickers: " + str(Globals.Stickers)
	
	Velocity = move_and_slide(Velocity)
	

func Flip() -> void:
	if get_global_mouse_position().x < global_position.x:
		$Shotgun/Sprite_Container.scale.y = -1
	else:
		$Shotgun/Sprite_Container.scale.y = 1
	
	$Sprite_Container/Sprite.set_flip_h(get_global_mouse_position().x < global_position.x)

func ouch() -> void:
	get_tree().change_scene("res://SRC/Screen_Stuff/Game_Over_Screen.tscn")
