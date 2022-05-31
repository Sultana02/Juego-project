extends Control

func _ready():
	$PanelPuntaje/Puntaje.text = "Puntaje: {p}".format({"p": DatosPlayer.generar_puntaje()})


func _on_BotonMenuPrincipal_pressed():
	get_tree().change_scene("res://Juego/Menus/MenuPrincipal.tscn")
