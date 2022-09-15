let fee_data = {
	valor_cuota: 0,
	recargo_sugerido: 0,
	ajuste: 0,
	total_a_pagar: 0,
	adeuda: 0,
	payment: 0.0,
	tomado_en: 0.0,
	valor_en_pesos: 0.0,
	name_pay:'',
	form_data: '',
	id: '',
	sumar_todo(){
		return this.valor_cuota + this.ajuste + this.adeuda + this.recargo_sugerido
	},
	sumar_sin_recargo() {
		return this.valor_cuota + this.ajuste + this.adeuda 
	},
	sumar_sin_ajuste() {
		return this.valor_cuota + this.recargo_sugerido + this.adeuda 
	},
	convertir_a_pesos() {
		if ( (this.payment > 0.0) && ( this.tomado_en > 0.0 )  && ( !isNaN(this.payment) ) && ( !isNaN(this.tomado_en) ) ) {
			return this.payment * this.tomado_en
		}
		return 0.0
	},
	reset() {
		this.payment = 0.0
		this.tomado_en = 0.0
		this.name_pay = ''
		this.valor_en_pesos = 0.0
	},
	calc_valor_en_pesos(name){
		let currency = document.getElementById('currency_id').value
		if (currency == 2 || currency == 3) {
			this.valor_en_pesos = this.convertir_a_pesos()
			document.getElementById(`${name}_calculo_en_pesos`).value = this.valor_en_pesos
		} else {
			let fee_payment_value = document.getElementById(`${name}_payment`).value
			document.getElementById(`${name}_value_in_pesos`).value = 1
			document.getElementById(`${name}_calculo_en_pesos`).value = ( !isNaN( fee_payment_value ) ) ? fee_payment_value : 0.0
		}
	}
}