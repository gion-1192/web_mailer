require 'web_mailer/smtp_item'

module WebMailer
  class WebSmtpService
    def initialize(options)
      @user, @passwd = options.values_at(:user, :passwd)
    end

    def post_mail(type, &block)
      options = send(type)

      mail = Mail.new
      mail.from = options[:from_addr]
      yield mail

      mail.charset = 'utf-8'
      mail.delivery_method(:smtp, options)
      mail.deliver
    end
  end
end
