extends Area2D

#Makes the game manager node connected to the variable, same with animation player
@onready var gamemanager: Node = %Gamemanager
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	gamemanager.add_point()
	animation_player.play("PickUpAnimation")
