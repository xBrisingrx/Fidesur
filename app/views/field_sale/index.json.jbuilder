json.data @batch_payments do |b|
	json.number b.number
	json.money b.money
	json.due_date b.due_date.strftime('%d-%m-%y')
	json.debe b.owes
	json.haber b.payment
	if b.expired? && !b.payed
		json.pay_status "<span class='u-tags-v1 text-center g-width-100 g-brd-around g-brd-lightred-v2 g-bg-lightred-v2
											g-font-size-default g-color-white g-rounded-50 '>Cuota vencida</span>"
	else 
		json.pay_status " #{@status[b.pay_status]} "
	end
	
	if !b.payed?
		json.actions "#{link_to "<i class='hs-admin-money'></i>".html_safe, batch_payment_path(b.id), 
                   :remote => true, 'data-toggle' =>  'modal', 'data-target' => '#modal-sales', 
                    class: ' u-link-v5 g-color-gray-dark-v6 g-color-secondary--hover g-text-underline--none--hover', title: 'Pagar cuota'}"
	else
		json.actions "#{link_to "<i class='hs-admin-eye'></i>".html_safe, detalle_pago_cuota_path(b.id), 
                   :remote => true, 'data-toggle' =>  'modal', 'data-target' => '#modal-sales', 
                    class: ' u-link-v5 g-color-white g-color-gray-dark-v6 g-color-secondary--hover g-text-underline--none--hover', 
                    title: 'Detalle del pago de cuota'}"
	end
end

