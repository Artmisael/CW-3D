extends Spatial

signal entrar
export onready var camara = "repetidor"
export (bool) onready var inicial = false
var edificios = []
signal edificio_inicial

func _ready():
	$seleccion.altura = Vector3(0,2,0)
	$seleccion.camara = camara
	if inicial:
		emit_signal("edificio_inicial",self)

func _construir(edificios_anteriores):
	edificios = edificios_anteriores
	$CPUParticles.show()
	pass
	
func _conectar(jugador):
	pass
	
func _ubicasion():
	return (to_global(Vector3(0,2,0)))

func _deselecionar():
	$seleccion/selecionado.hide()
	print("selec")
	
func _entrar():
	emit_signal("entrar",to_global(Vector3.ZERO))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
