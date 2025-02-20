# db/seeds.rb

# Suppression des anciennes données
Attendance.delete_all
Event.delete_all
User.delete_all

10.times do
  first_name = Faker::Name.unique.first_name.downcase.gsub(/[^a-z]/, '')
  last_name = Faker::Name.unique.last_name.downcase.gsub(/[^a-z]/, '')

  email = "#{first_name}.#{last_name}@yopmail.com"

  User.create!(
    email: email,
    password: 'password',
    first_name: first_name.capitalize,
    last_name: last_name.capitalize,
    description: Faker::Lorem.sentence(word_count: 15)
  )
end
puts "10 utilisateurs créés avec succès !"

event_titles = [
  "Conférence sur l'IA et l'avenir du travail",
  "Festival du film indépendant",
  "Startup Weekend Marseille",
  "Salon du Livre et de l'Innovation",
  "Atelier de photographie urbaine",
  "Concert acoustique sous les étoiles",
  "Hackathon : Code for Good",
  "Journée bien-être et méditation",
  "Masterclass cuisine méditerranéenne",
  "Exposition d'art contemporain",
  "Salon du chocolat",
  "Salon du mariage",
  "Festival international du théâtre",
  "Nuit des musées et patrimoine",
  "Biennale de l’art numérique",
  "Projection spéciale : Grands classiques du cinéma",
  "Atelier d’écriture créative",
  "Rencontre avec un auteur à succès",
  "Festival de musique électro en plein air",
  "Découverte de la calligraphie japonaise"
]

users = User.all

10.times do
  event_creator = users.sample
  Event.create!(
    title: event_titles.sample,
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
