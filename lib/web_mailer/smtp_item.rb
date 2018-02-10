module WebMailer
  class WebSmtpService
    private

    def yahoo
      { address: 'smtp.mail.yahoo.co.jp',
        port: 587,
        domain: 'yahoo.co.jp',
        user_name: @user,
        password: @passwd,
        authentication: :login,
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
