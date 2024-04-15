# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


  Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
    admin.password = ENV['ADMIN_PASSWORD']
  end

  User.find_or_create_by!(email: ENV['USER1_EMAIL']) do |user|
    user.password = ENV['USER1_PASSWORD']
    user.last_name = "山田"
    user.first_name = "太郎"
    user.last_name_kana = "ヤマダ"
    user.first_name_kana = "タロウ"
    user.handle_name = "太郎（test1）"
    user.birth_date = "19920301"
    user.postal_code = "1112222"
    user.address = "XX県XX市XX町"
    user.telephone_number = "09011111111"
    user.status = 0
  end