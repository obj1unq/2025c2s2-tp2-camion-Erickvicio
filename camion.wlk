import cosas.*

object camion {
	const cosas = #{}
	const pesoTara = 1000
	const pesoMaxAceptable = 2500
	const peligrosidadMaxPermitida = 20

	method cosas() { return cosas }
	method cargar(unaCosa) {
		self.validarCargar(unaCosa)
		cosas.add(unaCosa)
	}
	method descargar(unaCosa) {
		self.validarDescargar(unaCosa)
		cosas.remove(unaCosa)
	}
	method validarCargar(unaCosa) {
		if(cosas.contains(unaCosa)){
			self.error("Ya se encuentra cargado en el camion")
	  	}
	}
	method validarDescargar(unaCosa) {
		if(not cosas.contains(unaCosa)){
			self.error("No se encuentra cargado en el camion para realizar la descarga")
	  	}
	}
	method esTodoPesoPar() {
		return (cosas.sum({carga => carga.peso()}) % 2) == 0
	}
	method hayAlgoConPeso(unPeso) {
		return cosas.any({carga => carga.peso() == unPeso})
	}
	method peso() {
		return cosas.sum({carga => carga.peso()}) + pesoTara
	}
	method estaExcedido() {
		return self.peso() > pesoMaxAceptable
	}
	method deNivel(unLvl) {
		self.validarBusquedaDeNivel(unLvl)
		return cosas.find({carga => carga.nivelPeligrosidad() == unLvl})
	}
	method validarBusquedaDeNivel(unLvl) {
		if(not cosas.contains(cosas.find({carga => carga.nivelPeligrosidad() == unLvl}))){
			self.error("No se cuenta con ningun articulo con "+ unLvl + " de Nivel de Peligrosidad")
		}
	}
	method superanPeligrosidad(unLvl) {
		self.validarSuperanPeligrosidad(unLvl)
		return cosas.filter({carga => carga.nivelPeligrosidad() > unLvl})
	}
	method masPeligrosoQue(unaCosa) {
		self.validarMasPeligrosoQue(unaCosa)
		return cosas.filter({carga => carga.nivelPeligrosidad() > unaCosa.nivelPeligrosidad()})
	}
	method validarSuperanPeligrosidad(unLvl) {
		if(unLvl > self.mayorNivelDePeligrosidad()){
			self.error("No existe nada que supere una peligrosidad de "+ unLvl)
		}
	}
	method mayorNivelDePeligrosidad() {
		return cosas.map({carga => carga.nivelPeligrosidad()}).max()
	}
	method validarMasPeligrosoQue(unaCosa) {
		if(unaCosa.nivelPeligrosidad() >= self.mayorNivelDePeligrosidad()){
			self.error("No existe nada que supere la peligrosidad de "+ unaCosa)
		}
	}
	method puedeCircularEnRuta() {
		return (not self.estaExcedido()) && (not self.superaPeligrosidadPermitida())
	}
	method superaPeligrosidadPermitida() {
		return cosas.sum({carga => carga.nivelPeligrosidad()}) > peligrosidadMaxPermitida
	}
	method tienePesoEntre(min, max) {
		return cosas.any({carga => carga.peso() >= min}) && cosas.any({carga => carga.peso() <= max})
	}
	method cosaMasPesada() {
		self.validarCosaMasPesada()
		return cosas.max({carga => carga.peso()})
	}
	method validarCosaMasPesada() {
		if(cosas.isEmpty()){
			self.error("No existen elementos en el conjunto")
		}
	}
	method pesosTotales() {
		return cosas.map({carga => carga.peso()})
	}
	method totalBultos() {
		return cosas.sum({carga => carga.bultos()})
	}
	method accidentarse() {
		cosas.forEach({carga => carga.accidente()})
	}
	method transportar(destino, camino) {
		camino.validacionDePase()
		destino.añadirCosas(cosas)
		cosas.clear()
	}	
}
//rutas
object almacen {
	const property contenedor = #{} 
	method contenido() { return contenedor }

	method cargar(unaCosa) {
		self.validarCargar(unaCosa)
		contenedor.add(unaCosa)
	}
	method validarCargar(unaCosa) {
		if(contenedor.contains(unaCosa)){
			self.error("Ya se encuentra cargado en el almacen")
	  	}
	}
	method añadirCosas(unConj) {
		contenedor.addAll(unConj)
	}
}

object ruta9 {
	var vehiculo = camion

	method validacionDePase() {
		if(not vehiculo.puedeCircularEnRuta()){
			self.error("No puede pasar por Ruta9")
		}
	}
}

object caminosVecinales {
	var vehiculo = camion
	var property maxSoporte = 0  

	method validacionDePase() {
		if(vehiculo.peso() > maxSoporte){
			self.error("No puede pasar por Caminos Vecinales")
		}
	}
}