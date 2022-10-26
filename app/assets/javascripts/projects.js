let inputaso
let project = {
	materials_list:[],
	providers_list:[],
	price: '',
	final_price: 0,
	apples:[],
	cant_lands:0,
	form: new FormData(),
	add_provider(){
		event.preventDefault()
		let table_body = document.querySelector('#provider-list')
		let provider_id = parseInt( document.getElementById('project_provider_id').value )
		let role_id = parseInt( document.getElementById('project_provider_role').value )
		let payment_method_id = parseInt( document.getElementById('project_payment_method').value )
		let provider_price = parseFloat(document.getElementById('project_provider_price').value)
		let provider_iva = parseFloat( document.getElementById('provider_iva').value )

		if ( this.provider_validations(provider_id, role_id,payment_method_id,provider_price, provider_iva) ) {
			let provider_name =  $('#project_provider_id option:selected').text()
			let role_name =  $('#project_provider_role option:selected').text()
			let payment_method_name =  $('#project_payment_method option:selected').text()
			let provider_price_text = (payment_method_id == 1 ) ? `$${provider_price}` : `${provider_price}%`
			let precio_proveedor_calculado = this.calcular_precio_proveedor( parseInt(payment_method_id), provider_price )
			let porcentaje_representa_proveedor = this.calcular_porcentaje_representa( this.price, precio_proveedor_calculado )
			let data = {
				provider_id: provider_id,
				provider_role: role_id,
				payment_method_id: payment_method_id,
				provider_price: provider_price,
				provider_iva: provider_iva,
				provider_price_calculate: precio_proveedor_calculado,
				provider_porcent: porcentaje_representa_proveedor
			}
			this.providers_list.push( data )
			this.calculate_final_price()
			table_body.innerHTML += `
				<tr id="row-${provider_id}">
					<td>${provider_name}</td>
					<td>${role_name}</td>
					<td>${payment_method_name}</td>
					<td>${provider_iva}</td>
					<td>${provider_price_text}</td>
					<td> $${precio_proveedor_calculado} </td>
					<td> ${porcentaje_representa_proveedor} </td>
					<td><button type="button" class="btn u-btn-red remove-provider" onclick="project.remove_provider(${provider_id})" 
					title="Quitar interviniente"> <i class="fa fa-trash"></i> </button></td>
				</tr>
			`
			this.disabled_and_reset_select('project_provider_id' , 'select-2-project-provider')
			$(`.select-2-provider-role`).val('').trigger('change')
			$(`.select-2-payment-method`).val('').trigger('change')
			document.getElementById('project_provider_price').value = ''
		}
	},
	remove_provider( id ) {
		event.preventDefault()
		this.providers_list = this.providers_list.filter( p => p.provider_id != id )
		this.calculate_final_price()
		let element = document.querySelector(`#provider-list #row-${id}`)
		element.remove()
		$(`#project_provider_id option[value='${id}']`).attr('disabled', false)
	},
	change_method_cobro(){
		const selected = event.target.value
		const nodo = event.target.parentElement.parentElement
		const provider_selected_id = nodo.getElementsByClassName('provider-id').item(0).dataset.id
		const delete_btn = event.target.parentElement.parentElement.querySelector(`#delete_provider_${provider_selected_id}`)
		this.remove_inputs(nodo, provider_selected_id)
		if (selected === 'porcent') {
			const providers = this.get_name_providers(provider_selected_id)
			let options_generate = ''
			if (providers.length == 0 ) {
				noty_alert('warning', 'No hay otros proveedores seleccionados')
				return
			}
			providers.forEach( function(p) {
				options_generate += `<option value="${p}">${p}</option>`
			})
			// options_generate += providers.map( p => `<option>${p}</option>` )
			let select_providers = document.createElement("select")
			select_providers.id = "list_providers_generate"
			select_providers.className = 'ml-2 mr-2'
			nodo.insertBefore(select_providers, delete_btn )

			this.add_number_input(nodo,delete_btn, false, 'col-2', 'porcent_input')

			nodo.querySelector('#list_providers_generate').innerHTML += options_generate
			this.add_number_input(nodo,delete_btn, true, 'col-4', 'provider_price', 'Calculo segun %')
		} else if (selected === 'fix_number') {
			this.add_number_input(nodo,delete_btn, false, 'col-4', 'provider_price')
		} else {
			console.log('valor invalido')
		}
	},
	get_id_providers(){
		let proveedores = []
		let lista = document.getElementsByClassName('provider-id')
		for (let i = lista.length - 1; i >= 0; i--) {
			proveedores.push(lista[i].dataset.id)
		}
		return proveedores
	},
	get_name_providers(provider_id){
		let proveedores = []
		let lista = document.getElementsByClassName('provider-id')
		for (let i = lista.length - 1; i >= 0; i--) {
			if (lista[i].dataset.id != provider_id) {
				proveedores.push(lista[i].value)
			}
		}
		return proveedores
	},
	add_material(){
		event.preventDefault()
		let material = document.getElementById('project_material_id')
		let units = parseInt( document.getElementById('material_units').value )
		let material_price = parseFloat( document.getElementById('material_price').value )

		if (material.value == null || material.value == '') {
			noty_alert('error', 'Error al agregar el material a la lista')
			return
		}
		if ( units == null || isNaN(units)) {
			noty_alert('error', 'Las unidades deben ser un numero')
			return
		}
		if ( material_price == null || isNaN(material_price) ) {
			noty_alert('error', 'El precio debe ser un numero')
			return
		}

		let material_name =  $('#project_material_id option:selected').text()
		$('.project-material-body').append(`
			<tr id="row-${material.value}">
				<td>${material_name}</td>
				<td>${units}</td>
				<td>${material_price}</td>
				<td>${material_price * units}</td>
				<td><button type="button" class="btn u-btn-red remove-material" onclick="project.remove_material(${material.value})" 
					title="Quitar material"> <i class="fa fa-trash"></i> </button></td>
			</tr>
		`)

		let data = {
			id: parseInt(material.value),
			units: units,
			price: material_price
		}
		this.materials_list.push( data )
		$('#project_material_id option:selected').attr('disabled', 'disabled')
		$('.select-2-project-material').val('').trigger('change')
	},
	remove_material(material_id){
		event.preventDefault()
		let element = document.getElementById(`row-${material_id}`)
		element.remove()
		$(`#project_material_id option[value='${material_id}']`).attr('disabled', false)
		this.materials_list = this.materials_list.filter( m => m.id != material_id )
	},
	add_number_input(nodo,delete_btn, disabled, className, input_id, placeholder = ''){
		let newNode = document.createElement("input");
		newNode.type = 'number'
		newNode.id = input_id
		newNode.disabled = disabled
		newNode.placeholder = placeholder
		newNode.className = `form-control form-control-sm rounded-0 ${className} col-md-2 ml-2 mr-2`
		
		nodo.insertBefore(newNode, delete_btn )

		if (input_id == 'porcent_input') {
			inputaso = nodo
			nodo.querySelector('#porcent_input').onchange = function(e){
				console.info('un cosito')
			}
		}
	},
	calcular_segun_porcentaje(){
		console.log('calculando')
	},
	remove_inputs(nodo) {
		if (nodo.querySelector(`#provider_price`) != null) {
			nodo.querySelector(`#provider_price`).remove()
		}
		if (nodo.querySelector('#list_providers_generate') != null) {
			nodo.querySelector('#list_providers_generate').remove()
		}
		if (nodo.querySelector('#porcent_input') != null) {
			nodo.querySelector('#list_providers_generate').remove()
		}
	},
	submit(){
		event.preventDefault()
		event.stopPropagation()
		this.form.append('number', document.getElementById('project_number').value )
		this.form.append('name', document.getElementById('project_name').value )
		this.form.append('price', project.price )
		this.form.append('final_price', this.final_price )
		this.form.append('description', document.getElementById('project_description').value )
		this.form.append('project_type_id', document.getElementById('project_project_type_id').value )
		this.form.append('apple_id', document.getElementById('apple_list').value )
		this.form.append('apply_corner', document.getElementById('project_apply_corner').checked )
		this.add_providers()
		this.add_materials()
		fetch('/projects/', {
      method: 'POST',
      headers: {           
        'X-CSRF-Token': document.getElementsByName('csrf-token')[0].content,
      },
      body: this.form
    })
	  .then( response => response.json() )
	  .then( response => {
	  	if (response.status === 'success') {
	  		// lands_table.ajax.reload(null,false)
		    // $("#modal-land").modal('hide')
		    // $("#modal-land-sale-confirm").modal('hide')
	  	}
	  	noty_alert(response.status, response.msg)
	  } )
	  .catch( error => noty_alert('error', 'Ocurrio un error, no se pudo registrar la venta') )
	},
	charge_apples(){
		const node = event.target
		const sector_id = parseInt(node.value)
		fetch(`/manzanas/filter_for_sector/${sector_id}.json`).then( response => response.json() ).then( r => {
			let apple_list = document.querySelector('#apple_list')
			apple_list.innerHTML = '<option value=""> Elegir manzana </option>'
			this.apples = r.data
			for (let lote in this.apples){
			  apple_list.innerHTML += `
			  	<option value='${this.apples[lote].id}' data-cant='${this.apples[lote].lands}'> ${this.apples[lote].code} </option>
			  `
			} 
		})
	},
	provider_validations(provider, role,payment_method,provider_price, provider_iva){
		if (isNaN(provider)) {
			noty_alert('error', 'Debe seleccionar un proveedor')
			provider.classList.add('g-brd-pink-v2--error')
			return false
		}
		if ( isNaN(role) ) {
			noty_alert('error', 'Debe seleccionar funcion')
			return false
		}
		if ( isNaN(payment_method) ) {
			noty_alert('error', 'Debe seleccionar metodo de pago')
			return false
		}
		if ( isNaN( provider_price ) ) {
			noty_alert('error', 'Debe ingresar monto valido')
			return false
		}
		if ( isNaN( provider_iva ) ) {
			noty_alert('error', 'Debe seleccionar el IVA')
			return false
		}

		if ( !this.validate_price() ) {
			noty_alert('warning', 'Por favor, vuelva a ingresar el valor del proyecto')
			return false
		}

		return true
	},
	disabled_and_reset_select(select_id, select_class){
		$(`#${select_id} option:selected`).attr('disabled', 'disabled')
		$(`.${select_class}`).val('').trigger('change')
	},
	calcular_precio_proveedor(payment_method, provider_price){
		if (payment_method == 2) {
			// porcentaje
			const project_price = parseFloat( document.querySelector('#form-project #project_price').value )
			const porcent = provider_price/100
			return (project_price*porcent)
		} else {
			return provider_price
		}
	},
	validate_price(){
		this.price = parseFloat( document.querySelector('#form-project #project_price').value )
		if (isNaN(this.price)) {
			noty_alert('warning', 'El valor ingresado del proyecto no es valido')
			document.querySelector('#form-project #add-provider').disabled = true
			return false
		} else {
			document.querySelector('#form-project #add-provider').disabled = false
			this.calculate_final_price()
			return true
		}
	},
	calcular_porcentaje_representa(project_price, provider_value){
		console.log(project_price, provider_value)
		let porcentaje_representa = (provider_value*100) / project_price
		porcentaje_representa = porcentaje_representa.toFixed(2)
		return `${porcentaje_representa}%`
	},
	add_providers(){
		this.form.append(`cant_providers`, this.providers_list.length)
		for (let i = 0; i < this.providers_list.length; i++){
			this.form.append(`provider_id_${i}`, this.providers_list[i].provider_id)
			this.form.append(`provider_role_id_${i}`, this.providers_list[i].provider_role)
			this.form.append(`payment_method_id_${i}`, this.providers_list[i].payment_method_id)
			this.form.append(`provider_price_${i}`, this.providers_list[i].provider_price)
			this.form.append(`provider_iva_${i}`, this.providers_list[i].provider_iva)
			this.form.append(`provider_price_calculate_${i}`, this.providers_list[i].provider_price_calculate)
			this.form.append(`provider_porcent_${i}`, this.providers_list[i].provider_porcent)
		}
	},
	add_materials(){
		this.form.append(`cant_materials`, this.materials_list.length)
		for (let i = 0; i < this.materials_list.length; i++){
			this.form.append(`material_id_${i}`, this.materials_list[i].id)
			this.form.append(`material_units_${i}`, this.materials_list[i].units)
			this.form.append(`material_price_${i}`, this.materials_list[i].material_price)
		}
	},
	calculate_final_price(){
		this.final_price = this.price 
		for (let i = 0; i < this.providers_list.length; i++){
			this.final_price += this.providers_list[i].provider_price_calculate
		}
		document.getElementById('project_final_price').value = this.final_price
		this.calculate_price_lands()
	},
	select_apple(){
		let apple_selected = this.apples.filter( apple => apple.id == document.getElementById('apple_list').value )
		this.cant_lands = apple_selected[0].lands
	},
	calculate_price_lands(){
		if (!isNaN(this.cant_lands) && this.cant_lands > 0 ) {
			document.getElementById('project_land_price').value = (this.final_price/this.cant_lands).toFixed(2)
		}
	}
}

$(document).ready(function(){
	$('.select-2-project-provider').select2({ width: '100%',theme: "bootstrap4" })	
	$('.select-2-provider-role').select2({ width: '100%',theme: "bootstrap4" })	
	$('.select-2-payment-method').select2({ width: '100%',theme: "bootstrap4" })	
	$('.select-2-project-material').select2({ width: '100%',theme: "bootstrap4" })	
	$('.select-2-project-type').select2({ width: '30%',theme: "bootstrap4" })	
	$('.select-2-apple-list').select2({ width: '100%',theme: "bootstrap4" })
})
