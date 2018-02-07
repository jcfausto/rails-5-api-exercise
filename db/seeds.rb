# Creating some fake data for testing purposes
50.times do
  todo = Todo.create(title: Faker::Lorem.word, created_by: 1)
  todo.items.create(name: Faker::Lorem.word, done: false)
end
