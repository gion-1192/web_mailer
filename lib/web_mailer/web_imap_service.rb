require 'mail'
require 'net/imap'
require 'kconv'

module WebMailer
  class WebImapService
    class SimpleMail
      attr_accessor :address, :title, :body, :tmp_files

      def initialize(data)
        mail = Mail.new(data)
        @address = mail.from
        @title = mail.subject ? mail.subject : ''

        if mail.multipart?
          if mail.text_part
            @body = mail.text_part.decoded.toutf8
          elsif mail.html_part
            @body = mail.html_part.decoded.toutf8
          end
          @tmp_files = []
          mail.attachments.each do |file|
            @tmp_files.push(filename: file.filename,
                            content_type: file.content_type,
                            body: file.body.decoded)
          end
        else
          @body = mail.body.decoded.toutf8
        end
      end
      @body ||= ''
    end

    def initialize(options)
      @host, @port, @user, @passwd = options.values_at(:host, :port,
                                                       :user, :passwd)
      @imap = Net::IMAP.new(@host, @port, true, nil, false)
      examine(options[:examine]) unless options[:examine].nil?
    end

    def examine(target = 'inbox')
      @examine_target = imap.examine(target)
    rescue Net::IMAP::NoResponseError
      puts 'Wrong target change to different'
    end

    def fetched_mail(key, &block)
      list = []
      imap.search([key]).each do |id|
        mail = SimpleMail.new(imap.fetch(id, 'RFC822').first.attr['RFC822'])
        yield mail if block_given?
        list.push(mail)
      end
      list
    end

    private

    def imap
      unless logging_in?
        login
        examine if @examine_target.nil?
        at_exit { logout }
      end
      @imap
    end

    def login
      res = @imap.login(@user, @passwd)
      @logging_in = true if res && res.name == 'OK'
    end

    def logout
      res = @imap.logout if logging_in?
      @logging_in = false if res && res.name == 'OK'
    end

    def logging_in?
      @logging_in
    end
  end
end
