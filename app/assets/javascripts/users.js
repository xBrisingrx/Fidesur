let users_table

function modal_disable_user(id) {
  $('#modal-disable-user #user_id').val(id)
  $('#modal-disable-user').modal('show')
}

$(document).ready(function(){
	users_table = $("#users_table").DataTable({
    'ajax':'/en/users',
    'columns': [
    {'data': 'username'},
    {'data': 'name'},
    {'data': 'email'},
    {'data': 'actions'}
    ],
    'language': {'url': "/assets/plugins/datatables_lang_spa.json"}
	})

  $("#form-disable-user").on("ajax:success", function(event) {
    users_table.ajax.reload(null,false)
    let msg = JSON.parse(event.detail[2].response)
    noty_alert(msg.status, msg.msg)
    $("#modal-disable-user").modal('hide')
  }).on("ajax:error", function(event) {
    let msg = JSON.parse( event.detail[2].response )
    console.log(event.detail[2].response)
    $.each( msg, function( key, value ) {
      $(`#form-user #user_${key}`).addClass('is-invalid')
      $(`#form-user .user_${key}`).text( value ).show('slow')
    })
  })
})

