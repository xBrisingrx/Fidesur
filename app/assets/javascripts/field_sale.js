let field_sale_table

$(document).ready(function(){
	field_sale_table = $("#field_sale_table").DataTable({
    'ajax':`/detalle_venta_lote/` + $('#field_sale_id').val(),
    'columns': [
    {'data': 'number'},
    {'data': 'money'},
    {'data': 'due_date'},
    {'data': 'debe'},
    {'data': 'haber'},
    {'data': 'pay_status'},
    {'data': 'actions'}
    ],
    'language': {'url': "/assets/plugins/datatables_lang_spa.json"}
	})

  // $("#form-disable-field").on("ajax:success", function(event) {
  //   fields_table.ajax.reload(null,false)
  //   let msg = JSON.parse(event.detail[2].response)
  //   noty_alert(msg.status, msg.msg)
  //   $("#modal-disable-field").modal('hide')
  // }).on("ajax:error", function(event) {
  //   let msg = JSON.parse( event.detail[2].response )
  //   console.log(event.detail[2].response)
  //   $.each( msg, function( key, value ) {
  //     $(`#form-field #field_${key}`).addClass('is-invalid')
  //     $(`#form-field .field_${key}`).text( value ).show('slow')
  //   })
  // })
})