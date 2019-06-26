# Creating users
User.destroy_all
User.create(name: 'Josh Anderson', email: 'josh@delivery.pe', password: '123456')
User.create(name: 'Eva Azucena', email: 'eva@delivery.pe', password: '123456')

Restaurant.destroy_all
Restaurant.create(name: 'restaurant example', latitud: 0.12, longitud: 1.233, address: 'Av. sSS 123', price_type: 'low')
Restaurant.create(name: 'restaurant example', latitud: 0.12, longitud: 1.233, address: 'Av. sSS 123', price_type: 'low')
