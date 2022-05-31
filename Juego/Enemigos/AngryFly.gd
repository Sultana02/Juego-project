extends Area2D

export var velocidad = 100.0

onready var detector_jugador = $DetectaJugador
onready var detector_pisoton = $Pisoton/Colision
onready var animacion = $AnimationPlayer

func _on_Pisoton_body_entered(body):
	desactivar_colisionadores([detector_jugador, detector_pisoton])
	animacion.stop()
	animacion.play("morir")
	body.impulsar()


func _on_body_entered(body):
	body.respawn() 


func desactivar_colisionadores(colisionadores):
	for colision in colisionadores:
		colision.set_deferred("disabled", true)
		colision.set_deferred("visible", false)
