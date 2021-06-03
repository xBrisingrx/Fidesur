let clients_table

function modal_disable_client(id) {
  $('#modal-disable-client #client_id').val(id)
  $('#modal-disable-client').modal('show')
}

$(document).ready(function(){
	clients_table = $("#clients_table").DataTable({
    'ajax':'clients',
    'columns': [
    {'data': 'code'},
    {'data': 'last_name'},
    {'data': 'name'},
    {'data': 'dni'},
    {'data': 'cuil'},
    {'data': 'email'},
    {'data': 'phone'},
    {'data': 'actions'}
    ],
    'language': {'url': "/assets/plugins/datatables_lang_spa.json"}
	})

  $("#form-disable-client").on("ajax:success", function(event) {
    clients_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-client").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    console.log(event.detail[2].response)
    $.each( msj, function( key, value ) {
      $(`#form-client #client_${key}`).addClass('is-invalid')
      $(`#form-client .client_${key}`).text( value ).show('slow')
    })
  })
})

