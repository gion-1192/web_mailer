module WebMailer
  class WebSmtpService
    def initialize(options)
      @user, @passwd = options.values_at(:user, :passwd)
    end

    def post_mail(to_addr, to_subject, to_body, type)
      options = send(type.to_sym)
      mail = Mail.new do
        from options[:from_addr]
        to to_addr
        subject to_subject
        body to_body
      end

      mail.charset = 'utf-8'
      mail.delivery_method(:smtp, options)
      mail.deliver
    end

    private

    def yahoo
      { address: 'smtp.mail.yahoo.co.jp',
        port: 587,
        domain: 'yahoo.co.jp',
        user_name: @user,
        password: @passwd,
        authentication: :plain,
        enable_starttls_auto: true,
        from_addr: "#{@user}@yahoo.co.jp" }
    end

    def google
      { address: 'smtp.gmail.com',
        port: 587,
        domain: 'gmail.com',
        user_name: "#{@user}@gmail.com",
        password: @passwd,
        authentication: :login,
        enable_starttls_auto: true,
        from_addr: "<#{@user}@gmail.com>" }
    end
  end
end
