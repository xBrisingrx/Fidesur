User.create( name: 'Fidesur', username: 'fidesur', password: 'fidesur', password_confirmation: 'fidesur', email: 'info@fidesur.com.ar' )
User.create( name: 'Administración', username: 'administracion', password: 'administracion', password_confirmation: 'administracion', email: 'administracion@fidesur.com.ar' )
20.times do 
	name = Faker::Movies::HowToTrainYourDragon.character
	Client.create(
		name: name,
		last_name: Faker::Movies::HowToTrainYourDragon.dragon,
		email: Faker::Internet.email(name: name)
	)
end