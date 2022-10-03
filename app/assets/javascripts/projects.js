let inputaso
let project = {
	materials_list:[],
	providers_list:[],
	add_provider(){
		event.preventDefault()
		let provider = document.getElementById('project_provider_id')
		if (provider.value != null && provider.value != '') {
			let provider_name =  $('#project_provider_id option:selected').text()
			$('.provider-list').append(`
				<div class="row mb-2" id="${provider.value}">
					<div class="mb-2  mx-4 col-2">
						<input type="text" value="${provider_name}" class="provider-id form-control form-control-sm rounded-0 " data-id=${provider.value} disabled></input>
					</div>
					<div class="col-2">
            <select class="" required="required" onchange="project.change_method_cobro()">
              <option value="0" selected>Metodo de cobro</option>
              <option value="fix_number">Ingresar monto</option>
              <option value="porcent">Porcentaje</option>
            </select>
          </div>
					<div id="delete_provider_${provider.value}">
						<button type="button" class="btn u-btn-red remove-provider" onclick="project.remove_provider(${provider.value})" title="Quitar comprador"> <i class="fa fa-trash"></i> </button>
					</div>
				</div>
			`)
			$('#project_provider_id option:selected').attr('disabled', 'disabled')
			$('.select-2-project-provider').val('').trigger('change')
		} else {
			noty_alert('error', 'Error al agregar el proveedor a la lista')
		}
	},
	remove_provider( id ) {
		event.preventDefault()
		let element = document.getElementById(id)
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
			noty_alert('error', 'Error al agregar el proveedor a la lista')
			return
		}
		if ( units == null || isNaN(units)) {
			noty_alert('error', 'Las unidades deben ser un numero')
			return
		}
		if ( material_price == null || isNaN(material_price) ) {
			noty_alert('error', 'El precio es un numero')
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
		$('#project_material_id option:selected').attr('disabled', 'disabled')
		$('.select-2-project-material').val('').trigger('change')
		let data = {
			id: material.value,
			units: units,
			price: material_price
		}
		this.materials_list.push( data )
	},
	remove_material(material_id){
		event.preventDefault()
		let element = document.getElementById(`row-${material_id}`)
		element.remove()
		$(`#project_material_id option[value='${material_id}']`).attr('disabled', false)
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
		let form = new FormData()
		form.append('number', document.getElementById('project_number').value )
		form.append('name', document.getElementById('project_name').value )
		form.append('tecnical_direction', document.getElementById('project_tecnical_direction').value )
		form.append('providers[]', this.get_id_providers() )
		form.append('materials[]', this.materials_list)

		fetch('/projects/', {
      method: 'POST',
      headers: {           
        'X-CSRF-Token': document.getElementsByName('csrf-token')[0].content,
      },
      body: form
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
	}
}

$(document).ready(function(){
	$('.select-2-project-provider').select2({ width: '30%',theme: "bootstrap4" })	
	$('.select-2-project-material').select2({ width: '100%',theme: "bootstrap4" })	
	$('.select-2-project-type').select2({ width: '30%',theme: "bootstrap4" })	
})
