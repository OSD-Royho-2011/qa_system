# Create admin user.
User.create!(
    name: "Manager",
    email: "manager@gmail.com",
    password: "@bc12354",
    password_confirmation: "@bc12354",
    activated: true,
    activated_at: Time.zone.now,
    role: Role.find_by_name("Member")
)

# Create member user.
dean = User.create!(
    name: "Dean",
    email: "dean@gmail.com",
    password: "@bc12354",
    password_confirmation: "@bc12354",
    activated: true,
    activated_at: Time.zone.now,
    role: Role.find_by_name("Member")
)

# Create category & its sub-category.
Category.create(
    name: "Benifit",
    description: Faker::Dessert.topping
) do |benifit|
    SubCategory.create!(
        name: "Salary",
        description: Faker::Dessert.topping,
        category: benifit
    )

    SubCategory.create!(
        name: "Monthly Evaluation",
        description: Faker::Dessert.topping,
        category: benifit
    )

    benifitQA = Question.create!(
        content: "Does the company offer health insurance?",
        status: 1,
        private_token: "",
        user: dean
    )

    CategoryQuestion.create!(
        category: benifit,
        question: benifitQA
    )
end

Category.create(
    name: "Environment",
    description: Faker::Dessert.topping
) do |environment|
    SubCategory.create!(
        name: "Equipment",
        description: Faker::Dessert.topping,
        category: environment
    )

    SubCategory.create!(
        name: "Air-conditioner",
        description: Faker::Dessert.topping,
        category: environment
    )

    environmentQA = Question.create!(
        content: "Will it cover members or my family as well as myself?",
        status: 0,
        private_token: "",
        user: dean
    )

    CategoryQuestion.create!(
        category: environment,
        question: environmentQA
    )
end

Category.create!(
    name: "Others",
    description: Faker::Dessert.topping
) do |others|
    SubCategory.create!(
        name: "Love story",
        description: Faker::Dessert.topping,
        category: others
    )

    SubCategory.create!(
        name: "Funny story",
        description: Faker::Dessert.topping,
        category: others
    )
end
