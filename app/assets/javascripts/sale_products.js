let sale_product_table

async function get_totales_cuota(id) {
  let data = await fetch('/get_totales_cuota/' + id)
  let totales = await data.json()

  $('#total_debe').html(`Debe <b> ($${totales.debe}) </b>`)
  $('#total_haber').html(`Haber <b> ($${totales.haber}) </b>`)
  $('#monto_adeudado').html(`$${totales.total_adeudado}`)
  $('#monto_pagado').html(`$${totales.total_pagado}`)
  $('#cant_cuotas_pagadas').html(`Cuotas pagadas: ${totales.cuotas_pagadas}/${totales.cant_cuotas}`)
}

$(document).ready(function(){
	sale_product_table = $("#sale_product_table").DataTable({
    'ajax':`/fees/${$('#sale_id').val()}`,
    'columns': [
    {'data': 'number'},
    {'data': 'value'},
    {'data': 'adjust'},
    {'data': 'due_date'},
    {'data': 'debe'},
    {'data': 'haber'},
    {'data': 'pay_status'},
    {'data': 'actions'}
    ],
    'language': {'url': "/assets/plugins/datatables_lang_spa.json"}
	})
})