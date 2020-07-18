Admin.create!(
    email: 'master@admin.com',
    password: '1234567890',
    password_confirmation: '1234567890',
    master: true
)

User.create!(
    name: "Kazuki",
    email: "test@test.com",
    password: '1234567890',
    password_confirmation: '1234567890'

)

gimei = Gimei.name
10.times do |n|
    name = gimei.kanji
    email = "example-user#{n+1}@fake.org"
    User.create!(name: name,
                 email: email,
                 password: "1234567890",
                 password_confirmation: "1234567890")
end

25.times do |n|
    email = "example-admin#{n+1}@fake.org"
    password = "1234567890"
    Admin.create!(
        email: email,
        password: password,
        password_confirmation: password
    )
end

25.times do |n|
    name = Faker::Food.unique.dish
    price = n * 1000 + n * n
    Item.create!(name: name, price: price, image: nil)
end


25.times do |n|
    user_id = 1
    status = 0
    Order.create!(user_id: user_id, status: status)
end

Order.all.each do |order|
    Item.all.each do |item|
        order.items << item
    end
end

User.all.each do |user|
    Item.all.each do |item|
        user.items << item
    end
end








