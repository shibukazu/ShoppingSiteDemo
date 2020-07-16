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