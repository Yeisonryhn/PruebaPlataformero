extends Node
var muerto= false
var jugando= false
var posinicial = Vector2()
export (PackedScene) var Ninja

func _ready():
	posinicial.x = $KinematicBody2D.position.x
	posinicial.y = $KinematicBody2D.position.y
	
	pass


func _on_KinematicBody2D_cae():
	
	if !muerto:
		$Musica.stop()
		$Muerte.play()
		muerto = true		
		$HUI.show()

func _on_HUI_boton():
	if !jugando:
		print("inicio de partida")
		$HUI.hide()
		$HUI/Message.text = "Has Muerto"
		$HUI/Button.text = "Reintentar"
		$Musica.play()
		jugando= true
		
	elif jugando and muerto:
			print("jugando y muerto")
			#var ninja = Ninja.instance()
			#add_child(ninja)
			print ("(",$StartPosition.position.x ,",", $StartPosition.position.y,")")
			#ninja.position=$StartPosition.position
			$KinematicBody2D.position=$StartPosition.position
			#print ("(",ninja.position.x ,",", ninja.position.y,")")
			#ninja.show()
			muerto=false			
			$Muerte.stop()
			$HUI.hide()			
			$Musica.play()
			
