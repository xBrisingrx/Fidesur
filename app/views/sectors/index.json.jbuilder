json.data @sectors do |s|
	json.name s.name
	json.size s.size
	json.actions "#{link_to '<i class="hs-admin-pencil"></i>'.html_safe, edit_sector_path(s), 
  								 :remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-sector', 
      							'class' => 'u-link-v5 g-color-gray-light-v6 g-color-secondary--hover g-text-underline--none--hover g-ml-12', title: 'Editar'}
  							<a class='u-link-v5 g-color-gray-light-v6 g-color-secondary--hover g-text-underline--none--hover g-ml-12' 
  								title='Eliminar' 
  								onclick='modal_disable_sector( #{ s.id } )'>
									<i class='hs-admin-trash' aria-hidden='true'></i></a>"
end

