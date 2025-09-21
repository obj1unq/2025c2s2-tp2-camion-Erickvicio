object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method bultos() { return 1 }
	method accidente() {}
}

object arenaAGanel {
	var property pesoNeto = 0 
	method peso() { return pesoNeto }
	method nivelPeligrosidad() { return 1 }
	method bultos() { return 1 }
	method accidente() {
		pesoNeto += 20	
	}
}

object bumblebee {
	var property esAuto = true 
	method peso() { return 800 }
	method nivelPeligrosidad() {
		if(esAuto){
			return 15
		}else{
			return 30
		}
	}
	method bultos() { return 2 }
	method accidente() {
		esAuto = not esAuto
	}
}

object paqueteDeLadrillos {
	const pesoNeto = 2
	var property cantidad = 0 
	method peso() { return cantidad * pesoNeto }
	method nivelPeligrosidad() { return 2 }
	method bultos() {
		if(cantidad <= 100){
			return 1
		}else if(cantidad <= 300){
			return 2
		}else{
			return 3
		}
	}
	method accidente() {
		if(cantidad > 12){
			cantidad -= 12
		}else{
			cantidad = 0
		}
	}
}

object bateriaAntiaerea {
	var property tieneMisiles = false 
	method peso() {
		if(tieneMisiles){
			return 300
		}else{
			return 200
		}
	}
	method nivelPeligrosidad() {
		if(tieneMisiles){
			return 100
		}else{
			return 0
		}
	}
	method bultos() {
		if(tieneMisiles){
			return 2
		}else{
			return 1
		}
	}
	method accidente() {
		tieneMisiles = false	
	}
}

object residuosRadiactivos {
	var property pesoNeto = 0
	method peso() { return pesoNeto }
	method nivelPeligrosidad() { return 200 }
	method bultos() { return 1 }
	method accidente() { pesoNeto += 15	}
}

object contenedorPortuario {
	var property contenedor = []

	method peso() { return 100 + contenedor.sum({obj => obj.peso()}) }
	method nivelPeligrosidad(){
		if(contenedor.isEmpty()){
			return 0
		}else{
			return contenedor.map({obj => obj.nivelPeligrosidad()}).max() 
		}
	}
	method bultos() {
		if(contenedor.isEmpty()){
			return 1
		}else{
			return 1 + contenedor.sum({obj => obj.bultos()}) 
		}
	}
	method accidente() {
		contenedor.forEach({obj => obj.accidente()})	
	}
}

object embalajeDeSeguridad {
	var property contenedor = []
	method peso() { return contenedor.head().peso() }
	method nivelPeligrosidad() { return contenedor.head().nivelPeligrosidad() / 2 }
	method bultos() { return 2 }
	method accidente() {}
}
