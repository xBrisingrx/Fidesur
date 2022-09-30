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
					<div class="mb-2  mx-4 col-4">
						<input type="text" value="${provider_name}" class="provider-id form-control form-control-sm rounded-0 " data-id=${provider.value} disabled></input>
					</div>
					<div>
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
	get_providers(){
		let proveedores = []
		let lista = document.getElementsByClassName('provider-id')
		for (let i = lista.length - 1; i >= 0; i--) {
			proveedores.push(lista[i].dataset.id)
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
	submit(){
		event.preventDefault()
		event.stopPropagation()
		let form = new FormData()
		form.append('number', document.getElementById('project_number').value )
		form.append('name', document.getElementById('project_name').value )
		form.append('tecnical_direction', document.getElementById('project_tecnical_direction').value )
		form.append('providers[]', this.get_providers() )
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
