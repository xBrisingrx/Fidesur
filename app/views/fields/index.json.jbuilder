json.data @fields do |f|
	json.code f.code
	json.measures f.measures
	json.surface "#{f.surface} m²"
	json.space_not_available "#{f.space_not_available} m²"
	json.ubication f.ubication
	json.price "$ #{f.price}"
	json.is_green_space (f.is_green_space)? 'Si' : 'No'
	json.status "#{@status[f.status]}"
	if f.blueprint.attached?
		json.blueprint "#{link_to "<i class= 'hs-admin-file'></i>".html_safe, f.blueprint, target: '_blank', class: 'btn u-btn-indigo', title: 'Ver plano'}"
	else
		json.blueprint "<button class='btn u-btn-orange' disabled title='No se adjunto ningun plano'><i class= 'hs-admin-file'></i></button>"
	end

	if f.free?
		json.actions "#{link_to '<i class="hs-admin-pencil"></i>'.html_safe, edit_apple_field_path(apple_id:f.apple_id, id: f.id), 
  								 :remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-field', 
      							'class' => 'u-link-v5 g-color-gray-light-v6 g-color-secondary--hover g-text-underline--none--hover g-ml-12', title: 'Editar'}
									#{link_to '<i class="hs-admin-money"></i>'.html_safe, start_field_sale_path(f.id), 
  								 :remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-field', 
      							'class' => 'u-link-v5 g-color-gray-light-v6 g-color-secondary--hover g-text-underline--none--hover g-ml-12', title: 'Vender'}
  							<a class='u-link-v5 g-color-gray-light-v6 g-color-secondary--hover g-text-underline--none--hover g-ml-12' 
  								title='Eliminar' 
  								onclick='modal_disable_field( #{ f.id } )'>
									<i class='hs-admin-trash' aria-hidden='true'></i></a>"
	else 
		json.actions "#{link_to '<i class="hs-admin-pencil"></i>'.html_safe, edit_apple_field_path(apple_id:f.apple_id, id: f.id), 
  								 :remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-field', 
      							'class' => 'u-link-v5 g-color-gray-light-v6 g-color-secondary--hover g-text-underline--none--hover g-ml-12', title: 'Editar'}
  							<a class='u-link-v5 g-color-gray-light-v6 g-color-secondary--hover g-text-underline--none--hover g-ml-12' 
  								title='Eliminar' 
  								onclick='modal_disable_field( #{ f.id } )'>
									<i class='hs-admin-trash' aria-hidden='true'></i></a>"
	end
end

