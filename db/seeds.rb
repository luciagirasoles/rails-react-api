# Creating users
User.destroy_all
User.create(name: 'Josh Anderson', email: 'josh@delivery.pe', password: '123456')
User.create(name: 'Eva Azucena', email: 'eva@delivery.pe', password: '123456')

MenuItem.destroy_all
Restaurant.destroy_all
restaurant = Restaurant.create(name: 'restaurant example', latitud: 0.12, longitud: 1.233, address: 'Av. sSS 123', price_type: 'low')
restaurant.menu_items.create(name: 'dessert1', price: 700)
restaurant.menu_items.create(name: 'dessert2', price: 750)

Restaurant.create(name: 'restaurant example', latitud: 0.12, longitud: 1.233, address: 'Av. sSS 123', price_type: 'low')
