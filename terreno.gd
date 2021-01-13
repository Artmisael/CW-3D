extends Spatial

var size = (60)# Vector3(60,60,20)
var noise = []
var espacios = .2
var recursos = .5
onready var terranos = [$Tierra_0,$Tierra_1]
onready var camaras = [$Tierra_0/camara,$Tierra_1/camara]
onready var sismicas = [$Tierra_0/sismica,$Tierra_1/sismica]
onready var radares = [$Tierra_0/radar,$Tierra_1/radar]
onready var selecciones = [$Tierra_0/seleccion,$Tierra_1/seleccion]
var dx=0
var dy=0
var dz=0
			
func _ready():
	for i in (3):
		noise.append(OpenSimplexNoise.new())
		noise[i].seed = randi()
		noise[i].octaves = 2+i
		noise[i].period = 20-i*5
	make_terreno(noise)	
	
func make_terreno(noises):
	for Tierra in (2):
		var dx=0;var dy=0;var dz=0
		if Tierra == 1:
			dx=.5;	dy=.5;	dz=.5
		for x in size:
			for y in size:
				var altura = noises[0].get_noise_2d(x+dx,y+dy)
				var z=altura*10-dz
				for i in (z+10):
					var Z = i-11
					var dencidad = noises[1].get_noise_3d(x,Z,y)
					var cueva = noises[2].get_noise_3d(x,Z,y)
					if cueva*cueva > (1-recursos)*(1-recursos):
						if dencidad < (espacios-1):
							sismicas[Tierra].set_cell_item(x,Z,y,11)
						elif .5 < dencidad:#Piedra
							radares[Tierra].set_cell_item(x,Z,y,5)
						elif dencidad < 0:#Tierra
							camaras[Tierra].set_cell_item(x,Z,y,3)
						elif dencidad < recursos:#Recurso
							if Z<-6:
								radares[Tierra].set_cell_item(x,Z,y,10)
							else:
								radares[Tierra].set_cell_item(x,Z,y,6)
					elif cueva > espacios-.5:
						if .5 < dencidad: #Piedra
							radares[Tierra].set_cell_item(x,Z,y,5)
						elif (espacios-1) < dencidad :#Tierra
							camaras[Tierra].set_cell_item(x,Z,y,3)
						else:
							sismicas[Tierra].set_cell_item(x,Z,y,11)
					else:
						sismicas[Tierra].set_cell_item(x,Z,y,11)
							
				radares[Tierra].set_cell_item(x,z,y,-1)
				if sismicas[Tierra].get_cell_item(x,z-1,y)!=11 or 2<randi()*5:
					if z<-3:					
						camaras[Tierra].set_cell_item(x,z,y,4)	#foza
						camaras[Tierra].set_cell_item(x,z-1,y,4)
					elif z*z<1.5*1.5:
						camaras[Tierra].set_cell_item(x,z,y,0)#planicie
						camaras[Tierra].set_cell_item(x,z-1,y,0)
					elif z<3:
						camaras[Tierra].set_cell_item(x,z,y,1)#pasto seco
						camaras[Tierra].set_cell_item(x,z-1,y,1)
					else:
						camaras[Tierra].set_cell_item(x,z,y,2)#montaña
						camaras[Tierra].set_cell_item(x,z-1,y,-1)
						camaras[Tierra].set_cell_item(x,z-2,y,-1)
						radares[Tierra].set_cell_item(x,z-1,y,5)
						radares[Tierra].set_cell_item(x,z-2,y,5)
					
func _coordenada(ubicacion):
	var coord_0 = $Tierra_0.world_to_map($Tierra_0.to_local(ubicacion))
	var coord_1 = $Tierra_1.world_to_map($Tierra_1.to_local(ubicacion))
	var ubic_0 = $Tierra_0.to_global($Tierra_0.map_to_world(coord_0.x,coord_0.y,coord_0.z))
	var ubic_1 = $Tierra_1.to_global($Tierra_1.map_to_world(coord_1.x,coord_1.y,coord_1.z))
	if (ubic_0).distance_squared_to(ubicacion)<(ubic_1).distance_squared_to(ubicacion):
		return [0,coord_0,ubic_0]
	else:
		return [1,coord_1,ubic_1]
		
func _on_jugador_ver(instrucion,cosa,ubicacion,espacio):
	$Tierra_0/seleccion.clear()
	$Tierra_1/seleccion.clear()
	if cosa == null:
		return
	var coordenadas = Vector3.ZERO
	var Tierra = 0
	if instrucion == 0:
		coordenadas = cosa.world_to_map(cosa.to_local(ubicacion))
		if cosa.get_parent() == $Tierra_1:
			Tierra = 1
		selecciones[Tierra].set_cell_item(coordenadas.x,coordenadas.y,coordenadas.z,9)		
	elif instrucion == 1:
		coordenadas = cosa.world_to_map(cosa.to_local(ubicacion))
		if cosa.get_parent() == $Tierra_1:
			Tierra = 1
		var simiento=camaras[Tierra].get_cell_item(coordenadas.x,coordenadas.y,coordenadas.z)
		var lugar=camaras[Tierra].get_cell_item(coordenadas.x,coordenadas.y+1,coordenadas.z)
		if simiento != -1 and simiento != 3 and lugar == -1:
			selecciones[Tierra].set_cell_item(coordenadas.x,coordenadas.y+1,coordenadas.z,8)
		else:
			selecciones[Tierra].set_cell_item(coordenadas.x,coordenadas.y+1,coordenadas.z,12)
	elif instrucion == 2:
		var eje = _coordenada(ubicacion)
		var ubic_1 = _coordenada(espacio)
		var ubic_2 = _coordenada(ubic_1[2]*2-eje[2])
		selecciones[eje[0]].set_cell_item(eje[1].x,eje[1].y,eje[1].z,9)
		selecciones[ubic_1[0]].set_cell_item(ubic_1[1].x,ubic_1[1].y,ubic_1[1].z,8)
		var tierra = camaras[Tierra].get_cell_item(ubic_2[1].x,ubic_2[1].y,ubic_2[1].z)
		var piedra = radares[Tierra].get_cell_item(ubic_2[1].x,ubic_2[1].y,ubic_2[1].z)
		if tierra == -1 and piedra == -1:
			selecciones[ubic_2[0]].set_cell_item(ubic_2[1].x,ubic_2[1].y,ubic_2[1].z,8)
		else:
			selecciones[ubic_2[0]].set_cell_item(ubic_2[1].x,ubic_2[1].y,ubic_2[1].z,12)

func _on_jugador_camara(estado):	
	$Tierra_0/seleccion.clear()
	$Tierra_1/seleccion.clear()
	if estado == 1:
		$Tierra_0/camara.show()
		$Tierra_0/sismica.hide()
		$Tierra_1/camara.show()
		$Tierra_1/sismica.hide()
	elif estado == 2:
		$Tierra_0/camara.hide()
		$Tierra_0/sismica.show()
		$Tierra_1/camara.hide()
		$Tierra_1/sismica.show()
	elif estado == 3:
		$Tierra_0/camara.hide()
		$Tierra_0/sismica.hide()
		$Tierra_1/camara.hide()
		$Tierra_1/sismica.hide()

func _on_jugador_ejecutar(instrucion,cosa,ubicacion,espacio):
	#print(ubicacion)
	var Tierra=0
	var coordenadas = cosa.world_to_map(cosa.to_local(ubicacion))
	if instrucion == 0:		
		#if cosa.get_parent() == $Tierra_0:
			#cosa.set_cell_item(coordenadas.x,coordenadas.y,coordenadas.z,-1)
		if cosa.get_parent() == $Tierra_1:
			Tierra = 1
			#cosa.set_cell_item(coordenadas.x,coordenadas.y,coordenadas.z,-1)
		camaras[Tierra].set_cell_item(coordenadas.x,coordenadas.y,coordenadas.z,-1)
	#print(cosa.to_global(cosa.map_to_world(coordenadas.x,coordenadas.y,coordenadas.z)))
	print(Tierra)
	print(_coordenada(ubicacion)[0])
	print()
