extends Spatial

export (PackedScene) var modelo_colector
export (PackedScene) var modelo_repetidor
var ubicacion = null
var instrucion = 0
var movimiento = Vector3()
var seleccion = null
var seleccion_ubicacio = Vector3.ZERO
var estado_camara = 1
var cursor = 0
var edificios = []
var energia = 20
var i = 0
var tamanio_mapa
signal camara
signal ejecutar
signal ver
signal deselecionar

func _ready():
	$camara/AnimationPlayer.play("planos")
	pass
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x*.5))
		$camara.rotate_x(deg2rad(-event.relative.y*.5))
		$camara.rotation.x = clamp($camara.rotation.x,deg2rad(-100),deg2rad(100))
	if event.is_action_pressed("ejecucion"):
		$camara/RayCast.force_raycast_update()
		var cosa = $camara/RayCast.get_collider()
		var ubicacion = $camara/RayCast.get_collision_point()+1*$camara/Position3D.get_global_transform().origin-get_global_transform().origin
		var espacio = $camara/RayCast.get_collision_point()-1*($camara/Position3D.get_global_transform().origin-get_global_transform().origin)
		if cosa!=null:
			if cosa.is_in_group("terreno_seleccionable"):
				emit_signal("ejecutar",instrucion,cosa,ubicacion,espacio)
			elif cosa.is_in_group("selecionable"):				
				_entrar(cosa)
	if event.is_action_pressed("cambiar"):
		instrucion+=1
		if instrucion == 4:
			instrucion=0
		_instruccion(instrucion)
	if event.is_action_pressed("opcion_1"):
		_camara(1)
	if event.is_action_pressed("opcion_2"):
		_camara(2)
	if event.is_action_pressed("opcion_3"):
		_camara(3)
		
		
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		rotate_y(-1*delta)
	if Input.is_action_pressed("ui_left"):
		rotate_y(1*delta)
	if Input.is_action_pressed("ui_up"):
		$camara.rotate_x(1*delta)
	if Input.is_action_pressed("ui_down"):
		$camara.rotate_x(-1*delta)
	$camara.rotation.x = clamp($camara.rotation.x,deg2rad(-100),deg2rad(100))
	
	var direction = Vector3.ZERO
	if Input.is_action_just_pressed("ui_cancel"):
		if cursor == 0:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			cursor = 1
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			cursor = 0
			
	if Input.is_action_pressed("adelante"):
		direction-=transform.basis.z
	if Input.is_action_pressed("atras"):
		direction+=transform.basis.z
	if Input.is_action_pressed("derecha"):
		direction+=transform.basis.x
	if Input.is_action_pressed("izquierda"):
		direction-=transform.basis.x
	if Input.is_action_pressed("subir"):
		direction-=transform.basis.y
	if Input.is_action_pressed("bajar"):
		direction+=transform.basis.y
	direction = direction.normalized()
	transform.origin+=direction*delta*10
	transform.origin.x = clamp(transform.origin.x,5,tamanio_mapa-5)
	transform.origin.z = clamp(transform.origin.z,5,tamanio_mapa-5)
	
	$camara/compas.rotation = -$camara.rotation
	$camara/compas/centro.rotation = -rotation
	
	if estado_camara == 1:
		$camara/RayCast.force_raycast_update()
		var cosa = $camara/RayCast.get_collider()
		var ubicacion = $camara/RayCast.get_collision_point()+1*$camara/Position3D.get_global_transform().origin-get_global_transform().origin
		var espacio = $camara/RayCast.get_collision_point()-1*($camara/Position3D.get_global_transform().origin-get_global_transform().origin)
		if cosa != seleccion or ubicacion.distance_squared_to(seleccion_ubicacio) > .5:
			if cosa == null or cosa.is_in_group("terreno_seleccionable"):
				emit_signal("ver",instrucion,cosa,ubicacion,espacio)
				emit_signal("deselecionar")
			elif cosa.is_in_group("selecionable"):
				_seleccionar(cosa)
				emit_signal("ver",instrucion,null,ubicacion,espacio)
			seleccion = cosa
			seleccion_ubicacio = ubicacion
			
func _camara(modo):
	if modo == 1:
		$camara.set_projection(0)
		$camara.set_zfar(100.0)
		$camara.transform.origin.z = 0
	if modo == 2:
		$camara.set_projection(0)
		$camara.set_zfar(50.0)
		$camara.transform.origin.z = 0
	if modo == 3:
		$camara.set_projection(1)
		$camara.set_zfar(150.0)
		$camara.transform.origin.z = 50
	emit_signal("camara",modo)
	estado_camara = modo

func _on_Timer_timeout():
	energia = min(energia+1,20)
	pass

func _on_edificios_edificio_nuevo(edificio):	
	edificio._construir(edificios)
	edificios.append(edificio)
	edificio._conectar(self)

func _instruccion(orden):	
	if instrucion == 0:
		$camara/Planos/romper.show()
	else:
		$camara/Planos/romper.hide()
	if instrucion == 1:
		$camara/Planos/colector.show()
	else:
		$camara/Planos/colector.hide()
	if instrucion == 2:
		$camara/Planos/repetidor.show()
	else:
		$camara/Planos/repetidor.hide()
	if instrucion == 3:
		$camara/Planos/Metralla.show()
	else:
		$camara/Planos/Metralla.hide()
		
func _on_terreno_tamanio(tamanio):
	tamanio_mapa = tamanio
	pass # Replace with function body.
	
func _seleccionar(cosa):
	if not (is_connected("deselecionar",cosa,"_deselecionar")):
		connect("deselecionar",cosa,"_deselecionar")
	pass
	
func _entrar(cosa):	
	ubicacion =  cosa._entrar()[1]
	translate(cosa._entrar()[0])
	pass
	
