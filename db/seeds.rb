# AdminUser.create!(email: 'admin@example.com', password: 'password') if Rails.env.development?
# Setting.create_or_find_by!(key: 'min_version', value: '0.0')

topic1 = Topic.new(name: 'Futbol')
topic1.image.attach(io: File.open('app/assets/images/futbol.jpg'), filename: 'futbol.jpg')
topic1.save!

topic2 = Topic.new(name: 'PC')
topic2.image.attach(io: File.open('app/assets/images/PC.png'), filename: 'PC.png')
topic2.save!
