extends KinematicBody2D
export (int) var gravedad = 1200
export (int) var velocidad_correr = 10
export (int) var velocidad_salto = -600
var velocidad = Vector2()
var max_vel = 300
var saltando = false
var derecha
var izquierda
var timer = true
var reproduciendo_pasos = false
signal cae
func _ready():
	velocidad.x = 0
		

func control():
	derecha = Input.is_action_pressed("ui_right")
	izquierda = Input.is_action_pressed("ui_left")
	var salto = Input.is_action_pressed("ui_up")
	
	if salto and is_on_floor():
		
		saltando=true
		velocidad.y = velocidad_salto		
		$AnimatedSprite.animation = "jump"
		if reproduciendo_pasos:		
			reproduciendo_pasos = false
			$Pasos.stop()
		$Salto.play()
		$TimerJump.start()
		timer = false
		
	elif derecha and is_on_floor():
		if velocidad.x < max_vel:
			velocidad.x += velocidad_correr		
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h=false
		if(!reproduciendo_pasos):
			$Pasos.play()
			reproduciendo_pasos=true
		
	elif izquierda and is_on_floor():
		if velocidad.x > -max_vel:
			velocidad.x -= velocidad_correr		
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h=true
		if(!reproduciendo_pasos):
			$Pasos.play()
			reproduciendo_pasos=true
		
	elif( !derecha and !izquierda and !saltando):
		velocidad.x = 0
		$AnimatedSprite.animation = "idle"
		if reproduciendo_pasos:
			reproduciendo_pasos= false
			$Pasos.stop()
		
func _physics_process(delta):
	control()
	velocidad.y += gravedad * delta
	if  saltando and is_on_floor() and timer:
		saltando=false
		$AnimatedSprite.animation = "idle"
		$AnimatedSprite.play()
	velocidad = move_and_slide(velocidad, Vector2(0,-1))
	if position.y > 480:
		emit_signal("cae")


func _on_TimerJump_timeout():
	$AnimatedSprite.stop()
	$TimerJump.stop()
	$Salto.stop()
	timer=true
	
func muere():
	queue_free()
		
func start(pos):
	position=pos
	
