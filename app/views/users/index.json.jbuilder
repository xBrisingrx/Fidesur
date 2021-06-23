json.data @users do |u|
	json.username u.username
	json.name u.name
	json.email u.email
	json.actions "#{link_to '<i class="hs-admin-pencil"></i>'.html_safe, edit_user_path(u), 
  								 :remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-user', 
      							'class' => 'u-link-v5 g-color-gray-light-v6 g-color-secondary--hover g-text-underline--none--hover g-ml-12', title: 'Editar'}
  							<a class='u-link-v5 g-color-gray-light-v6 g-color-secondary--hover g-text-underline--none--hover g-ml-12' 
  								title='Eliminar' 
  								onclick='modal_disable_user( #{ u.id } )'>
									<i class='hs-admin-trash' aria-hidden='true'></i></a>"
end

