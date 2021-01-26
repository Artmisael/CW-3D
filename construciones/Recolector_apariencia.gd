extends Spatial

var edificios
export (bool) onready var inicial = false
signal edificio_inicial
signal mensage
var energia_nesesaria = 10
var superposicion = [self]
var carga = true
var energia = 0
var conectados = []

func _ready():
	if inicial:
		emit_signal("edificio_inicial",self)
		
func _process(delta):
	if energia < energia_nesesaria:
		var fuente = conectados.pop_front()
		if fuente != null:
			fuente._embiar(self,energia_nesesaria-energia)
			$conecion.set_cast_to(to_local(fuente._ubicasion()))
			if fuente == $conecion.get_collider():
				conectados.append(fuente)
		else:
			emit_signal("mensage","desconecado")


func _construir(edificios_anteriores):
	edificios = edificios_anteriores
	for edificio in edificios:
		edificio.edificios.append(self)
		if edificio.is_in_group("repetidor"):
			conectados.append(edificio)
	$AnimationPlayer.play("Colector")
	if not inicial:
		set_scale(Vector3(1,energia/energia_nesesaria,1)) 
	
func _conectar(jugador):
	pass

func _cargar():
	$Timer.start()

func _on_carga_timeout():
	carga = true
	
func _on_competecia_area_entered(area):
	superposicion.append(area)
	$Timer.set_wait_time(superposicion.size())
	$alcanse.show()

func _on_competecia_area_exited(area):
	superposicion.remove(area)
	$Timer.set_wait_time(superposicion.size())
	if $Timer.get_wait_time()==1:
		$alcanse.hide()
