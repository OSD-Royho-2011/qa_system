class EmailActivationWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find_by(id: user_id)
    UserMailer.account_activation(user).deliver_now
    puts "Email Activation Worker is working..."
  end
end
