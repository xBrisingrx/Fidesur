let fields_table

function modal_disable_field(id) {
  $('#modal-disable-field #field_id').val(id)
  $('#modal-disable-field').modal('show')
}

$(document).ready(function(){
  const apple_id = document.getElementById('apple_id').value 
	fields_table = $("#fields_table").DataTable({
    'ajax':`lotes`,
    'columns': [
    {'data': 'code'},
    {'data': 'measures'},
    {'data': 'surface'},
    {'data': 'space_not_available'},
    {'data': 'ubication'},
    {'data': 'price'},
    {'data': 'is_green_space'},
    {'data': 'status'},
    {'data': 'blueprint'},
    {'data': 'actions'}
    ],
    'language': {'url': "/assets/plugins/datatables_lang_spa.json"}
	})

  $("#form-disable-field").on("ajax:success", function(event) {
    fields_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    $("#modal-disable-field").modal('hide')
  }).on("ajax:error", function(event) {
    let msg = JSON.parse( event.detail[2].response )
    console.log(event.detail[2].response)
    $.each( msg, function( key, value ) {
      $(`#form-field #field_${key}`).addClass('is-invalid')
      $(`#form-field .field_${key}`).text( value ).show('slow')
    })
  })
})