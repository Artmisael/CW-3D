extends Spatial

export (PackedScene) var modelo_colector
export (PackedScene) var modelo_repetidor
export (PackedScene) var modelo_metralla
signal edificio_nuevo

func _ready():
	pass # Replace with function body.

func _on_terreno_construir(edificio,ubicacion,direccion):
	if edificio == 1:
		var colector = modelo_colector.instance()
		add_child(colector)
		emit_signal("edificio_nuevo",colector)
		colector.translate(ubicacion)
	if edificio == 2:
		var repetidor = modelo_repetidor.instance()		
		add_child(repetidor)
		emit_signal("edificio_nuevo",repetidor)
		repetidor.translate(ubicacion)
		var direcciones=[Vector3(-1,1,1),Vector3(1,-1,1),Vector3(1,1,-1),Vector3(1,1,1),
						Vector3(1,-1,-1),Vector3(-1,1,-1),Vector3(-1,-1,1),Vector3(-1,-1,-1),
						Vector3(2,0,0),Vector3(-2,0,0),Vector3(0,0,2),Vector3(0,0,-2),Vector3(0,-2,0),Vector3(0,2,0)]
		var angulos=[Vector3(52,-45,0),Vector3(128,45,0),Vector3(52,135,0),Vector3(52,45,0),
						Vector3(128,135,0),Vector3(52,225,0),Vector3(128,-45,0),Vector3(128,225,0),
						Vector3(90,90,0),Vector3(90,270,0),Vector3(90,0,0),Vector3(90,180,0),Vector3(180,0,0),Vector3(0,0,0)]
		repetidor.set_rotation_degrees(angulos[direcciones.find(direccion)])
	if edificio == 3:
		var metralla = modelo_metralla.instance()		
		add_child(metralla)
		emit_signal("edificio_nuevo",metralla)
		metralla.translate(ubicacion)
		var direcciones=[Vector3(-1,1,1),Vector3(1,-1,1),Vector3(1,1,-1),Vector3(1,1,1),
						Vector3(1,-1,-1),Vector3(-1,1,-1),Vector3(-1,-1,1),Vector3(-1,-1,-1),
						Vector3(2,0,0),Vector3(-2,0,0),Vector3(0,0,2),Vector3(0,0,-2),Vector3(0,-2,0),Vector3(0,2,0)]
		var angulos=[Vector3(52,-45,0),Vector3(128,45,0),Vector3(52,135,0),Vector3(52,45,0),
						Vector3(128,135,0),Vector3(52,225,0),Vector3(128,-45,0),Vector3(128,225,0),
						Vector3(90,90,0),Vector3(90,270,0),Vector3(90,0,0),Vector3(90,180,0),Vector3(180,0,0),Vector3(0,0,0)]
		metralla.set_rotation_degrees(angulos[direcciones.find(direccion)])
	pass # Replace with function body.
