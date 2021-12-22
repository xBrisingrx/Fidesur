var land_fee_data = {
	valor_cuota: 0,
	recargo_sugerido: 0,
	ajuste: 0,
	total_a_pagar: 0,
	adeuda: 0,
	sumar_todo(){
		return this.valor_cuota + this.ajuste + this.adeuda + this.recargo_sugerido
	},
	sumar_sin_recargo() {
		return this.valor_cuota + this.ajuste + this.adeuda 
	},
	sumar_sin_ajuste() {
		return this.valor_cuota + this.recargo_sugerido + this.adeuda 
	}

}