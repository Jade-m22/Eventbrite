# db/seeds.rb

# Suppression des anciennes données
Attendance.delete_all
Event.delete_all
User.delete_all

# Création de 10 utilisateurs avec des données aléatoires
10.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.sentence(word_count: 15)
  )
end

puts "10 utilisateurs créés avec succès !"

# Création de 10 événements
users = User.all
10.times do
  event_creator = users.sample # Choisir un utilisateur au hasard pour organiser l'événement
  Event.create!(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.sentence(word_count: 30),
    start_date: Faker::Time.forward(days: 5, period: :morning),
    duration: rand(1..5),
    price: Faker::Commerce.price(range: 0..1000),
    location: "Marseille",
    user_id: event_creator.id
  )
end

puts "10 événements créés avec succès !"

# Création de 30 participations
events = Event.all
30.times do
  user = users.sample
  event = events.sample
  Attendance.create!(
    user_id: user.id,
    event_id: event.id,
    stripe_customer_id: Faker::Alphanumeric.alpha(number: 10)
  )
end

puts "30 participations créées avec succès !"
