let apples_table

function modal_disable_apple(id) {
  $('#modal-disable-apple #apple_id').val(id)
  $('#modal-disable-apple').modal('show')
}

$(document).ready(function(){
	apples_table = $("#apples-table").DataTable({
    'ajax':'apples',
    'columns': [
	    {'data': 'code'},
	    {'data': 'hectares'},
	    {'data': 'location'},
	    {'data': 'value'},
	    {'data': 'sector'},
	    {'data': 'actions'}
    ],
    'language': {'url': "/assets/plugins/datatables_lang_spa.json"}
	})

  $("#form-disable-apple").on("ajax:success", function(event) {
    apple_table.ajax.reload(null,false)
    let msj = JSON.parse(event.detail[2].response)
    noty_alert(msj.status, msj.msg)
    $("#modal-disable-apple").modal('hide')
  }).on("ajax:error", function(event) {
    let msj = JSON.parse( event.detail[2].response )
    console.log(event.detail[2].response)
    $.each( msj, function( key, value ) {
      $(`#form-apple #apple_${key}`).addClass('is-invalid')
      $(`#form-apple .apple_${key}`).text( value ).show('slow')
    })
  })

}) // End $(document).ready()
