extends Spatial

export (bool) onready var inicial = false
var edificios = []
signal edificio_inicial

func _ready():
	if inicial:
		emit_signal("edificio_inicial",self)

func _entrar():
	pass

func _construir(edificios_anteriores):
	edificios = edificios_anteriores
	$AnimationPlayer.play("metralla")
	$metralla2/custom/SpotLight.show()
	pass
	
func _conectar(jugador):
	pass
	

func _deselecionar():
	$seleccion/selecionado.hide()
	print("selec")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
