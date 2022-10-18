json.data @condominia do |c|
	json.name c.name
	json.description c.description

	json.actions "#{link_to '<i class="hs-admin-pencil"></i>'.html_safe, edit_condominium_path(c), 
  								 :remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-condominium', 
      							'class' => 'u-link-v5 g-color-gray-dark-v2 g-color-secondary--hover g-text-underline--none--hover g-ml-12', title: 'Editar'}
  							<a class='u-link-v5 g-color-gray-dark-v2 g-color-secondary--hover g-text-underline--none--hover g-ml-12' 
  								title='Eliminar' 
  								onclick='modal_disable_condominium( #{ c.id } )'>
									<i class='hs-admin-trash' aria-hidden='true'></i></a>"
end
