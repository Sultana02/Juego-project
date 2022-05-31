extends Node2D

onready var detecta_jugador = $Sprite/RayCast2D
onready var posiciones_disparo = $Sprite/PosicionesDisparo
onready var cadencia_disparo = $Timer
onready var sound_rayos = $Rayos

export var rayo: PackedScene
var puede_disparar = true


func _process(delta):
	if detecta_jugador.is_colliding() and puede_disparar:
		disparar()
		puede_disparar = false
		#reinicia el timer
		cadencia_disparo.start()


func disparar():
	sound_rayos.play()
	for posicion in posiciones_disparo.get_children(): #devuelve todos los hijos de un nodo
		var nuevo_rayo = rayo.instance()
		nuevo_rayo.crear(posicion.global_position)
		add_child(nuevo_rayo)


func _on_Timer_timeout():
	puede_disparar = true
