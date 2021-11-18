namespace :database do
  desc "Create roles, permissions and users"
  task create_base_data: :environment do
    puts "Create roles"
    Role.create! name: "Super Admin"

    Role.create! name: "Manager"

    Role.create! name: "Member"

    puts "Create a universal permission"
    Permission.create! subject_class: "all", action: "manage"

    puts "Assign super admin the permission to manage all the models and controllers"
    role = Role.find_by_name("Super Admin")
    role.permissions << Permission.find_by(subject_class: 'all', action: "manage")

    puts "Create a user and assign the super admin role to him"
    user = User.new(name: "Administrator", email: "admin@gmail.com", password: "@admin12354", password_confirmation: "@admin12354", activated: true, activated_at: Time.zone.now)
    user.role = role
    user.save!

    User.create(name: "Tôm", email: "tomoke@gmail.com", password: "@tom12354", password_confirmation: "@tom12354", activated: true, activated_at: Time.zone.now, role_id: Role.find_by_name("Member").id)
  end

end
