extends Panel

signal boton

func _ready():
	pass


func _on_Button_pressed():
	emit_signal("boton")