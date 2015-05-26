# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development? || Rails.env.staging?
  unless User.find_by(email: 'msjacobson@gmail.com').present?
    puts "Creating Matt User. PW: password"
    User.create(email: 'msjacobson@gmail.com',
                first_name: 'Matt',
                last_name: 'Jacobson',
                password: 'password'
                )
  end
end

creations = [
  {model: Role,
   names: ['Admin']}
]

creations.each do |creation|
  creation[:names].each do |name|
    unless creation[:model].find_by(name: name).present?
      puts "Creating #{creation[:model]}: #{name}"
      creation[:model].create!(name: name)
    end
  end
end
