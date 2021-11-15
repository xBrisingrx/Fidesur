json.data @clients do |c|
	json.code c.code
	json.last_name c.last_name
	json.name c.name
	json.dni c.dni
	json.direction c.direction
	json.email c.email
	json.phone c.phone
	if c.client_sales.count > 0
		json.actions "#{link_to '<i class="hs-admin-pencil"></i>'.html_safe, edit_client_path(c), 
  								 :remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-client', 
      							'class' => 'u-link-v5 g-color-gray-light-v6 g-color-secondary--hover g-text-underline--none--hover g-ml-12', title: 'Editar'}
  							<a class='u-link-v5 g-color-gray-light-v6 g-color-secondary--hover g-text-underline--none--hover g-ml-12' 
  								title='Eliminar' 
  								onclick='modal_disable_client( #{ c.id } )'>
									<i class='hs-admin-trash' aria-hidden='true'></i></a>"
	else 
		json.actions "#{link_to '<i class="hs-admin-pencil"></i>'.html_safe, edit_client_path(c), 
  								 :remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-client', 
      							'class' => 'u-link-v5 g-color-gray-light-v6 g-color-secondary--hover g-text-underline--none--hover g-ml-12', title: 'Editar'}
      						#{link_to '<i class="hs-admin-home"></i>'.html_safe, lotes_cliente_path(c.id), 
  								 :remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-client', 
      							'class' => 'u-link-v5 g-color-gray-light-v6 g-color-secondary--hover g-text-underline--none--hover g-ml-12', title: 'Ver lotes comprados'}
  							<a class='u-link-v5 g-color-gray-light-v6 g-color-secondary--hover g-text-underline--none--hover g-ml-12' 
  								title='Eliminar' 
  								onclick='modal_disable_client( #{ c.id } )'>
									<i class='hs-admin-trash' aria-hidden='true'></i></a>"
	end
end

