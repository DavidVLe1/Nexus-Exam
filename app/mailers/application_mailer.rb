class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  after_action :log_email

  private

  def log_email
    Rails.logger.info("Sent email to: #{mail.to}")
  end
end
