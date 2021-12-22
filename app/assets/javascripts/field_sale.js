let field_sale_table

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
	field_sale_table = $("#field_sale_table").DataTable({
    'ajax':`/detalle_venta_lote/` + $('#field_sale_id').val(),
    'columns': [
    {'data': 'number'},
    {'data': 'fee_value'},
    {'data': 'due_date'},
    {'data': 'debe'},
    {'data': 'haber'},
    {'data': 'pay_status'},
    {'data': 'actions'}
    ],
    'language': {'url': "/assets/plugins/datatables_lang_spa.json"}
	})
})

