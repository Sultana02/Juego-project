extends Area2D

export(String, "oro", "plata", "bronce") var tipo_moneda

onready var animacion := $AnimatedSprite
onready var anima_consume := $AnimationPlayer
onready var colision_personaje := $ColisionPersonaje


func _ready():
	animacion.play()

func _on_body_entered(_body):
	DatosPlayer.sumar_monedas(tipo_moneda)
	colision_personaje.set_deferred("disabled", true)
	anima_consume.play("consumir")
