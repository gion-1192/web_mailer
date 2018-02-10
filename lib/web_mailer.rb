require 'web_mailer/version'
require 'web_mailer/web_imap_service'
require 'web_mailer/web_smtp_service'

module WebMailer
  # Your code goes here...
  class << self
    class NoConfigError < StandardError; end

    class Config
      attr_accessor :host, :port, :user, :passwd, :examine

      def configer
        { host: host, port: port, user: user, passwd: passwd, examine: examine }
      end
    end

    def configuration
      @config ||= Config.new
      yield @config
    end

    def asqirer(key, &block)
      raise NoConfigError 'Please configure config.' if @config.nil?

      imap = WebImapService.new(@config.configer)
      imap.fetched_mail(key, &block)
    end

    def distributor(type, &block)
      raise NoConfigError 'Please configure config.' if @config.nil?

      smtp = WebSmtpService.new(@config.configer)
      smtp.post_mail(type, &block)
    end
  end
end
