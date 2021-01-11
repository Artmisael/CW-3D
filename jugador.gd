extends Spatial

export (PackedScene) var modelo_colector
export (PackedScene) var modelo_repetidor
var instrucion = 0
var movimiento = Vector3()
var seleccion = null
var seleccion_ubicacio = Vector3.ZERO
var estado_camara = 1
var cursor = 0
var edificios = []
signal camara
signal ejecutar
signal ver

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x*.5))
		$camara.rotate_x(deg2rad(-event.relative.y*.5))
		$camara.rotation.x = clamp($camara.rotation.x,deg2rad(-100),deg2rad(100))
	if event.is_action_pressed("ejecucion"):		
		$camara/RayCast.force_raycast_update()
		var cosa = $camara/RayCast.get_collider()
		var ubicacion = $camara/RayCast.get_collision_point()+1*$camara/Position3D.get_global_transform().origin-get_global_transform().origin
		var espacio = $camara/RayCast.get_collision_point()-1*$camara/Position3D.get_global_transform().origin-get_global_transform().origin
		if cosa!=null:
			if cosa.is_in_group("terreno_seleccionable"):
				emit_signal("ejecutar",instrucion,cosa,ubicacion,espacio)
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
	transform.origin.x = clamp(transform.origin.x,-10,110)
	transform.origin.z = clamp(transform.origin.z,-10,110)
	
	$camara/compas.rotation = -$camara.rotation
	$camara/compas/centro.rotation = -rotation
	
	if estado_camara == 1:
		$camara/RayCast.force_raycast_update()
		var cosa = $camara/RayCast.get_collider()
		var ubicacion = $camara/RayCast.get_collision_point()+1*$camara/Position3D.get_global_transform().origin-get_global_transform().origin
		if cosa != seleccion or ubicacion != seleccion_ubicacio:
			if cosa!=null:
				
				var capa = cosa.get_parent()
				var terreno = capa.get_parent()
				if terreno.is_in_group("terreno"):
					emit_signal("ver",capa,ubicacion)
					terreno._seleccionar(capa,ubicacion,"terreno")
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

func _on_Timer_timeout():
	pass
