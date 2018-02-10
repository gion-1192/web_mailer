require 'spec_helper'

RSpec.describe WebMailer do
  def imap_config
    # IMAPサーバー情報設定
    WebMailer.configuration do |config|
      config.host = 'imap_domain'
      config.port = 993
      config.user = 'username'
      config.passwd = 'password'
      config.examine = 'inbox'
    end
  end

  def smtp_config
    # SMTPサーバー情報設定
    WebMailer.configuration do |config|
      config.user = 'account_name'
      config.passwd = 'account_password'
    end
  end

  it 'has a version number' do
    expect(WebMailer::VERSION).not_to be nil
  end

  it '#WebMailer.asqirer' do
    imap_config
    # メール受信テスト
    WebMailer.asqirer('ALL') do |mail|
      puts '送信元:' + mail.address[0]
      puts 'タイトル:' + mail.title
      puts '本文:' + mail.body
      mail.tmp_files
    end
  end

  it '#WebMailer.distributor' do
    smtp_config
    WebMailer.distributor(:yahoo) do |mail|
      mail.to = 'post_mail_address'
      mail.subject = 'subject'
      mail.body = 'body'
    end
  end
end
