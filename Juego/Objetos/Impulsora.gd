extends StaticBody2D

onready var animacion = $AnimationPlayer
onready var sonido_rebote = $rebotar


func _ready():
	animacion.play("Idle")


func _on_DetectaImpulso_body_entered(body):
	sonido_rebote.play()
	animacion.play("Impulsar")
	body.impulsar()
