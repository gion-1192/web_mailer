require 'spec_helper'
require 'kconv'

RSpec.describe WebMailer do
  before do
    # サーバー情報設定
    WebMailer.configuration do |config|
      config.host = 'imap.mail.yahoo.co.jp'
      config.port = 993
      config.user = 'username'
      config.passwd = 'passwd'
      config.examine = 'inbox'
    end
  end

  it 'has a version number' do
    expect(WebMailer::VERSION).not_to be nil
  end

  it '#WebMailer.asqirer' do
    # メール受信テスト
    WebMailer.asqirer('ALL') do |mail|
      puts '送信元:' + mail.address[0]
      puts 'タイトル:' + mail.title
      puts '本文:' + mail.body
      mail.tmp_files
    end
  end
end
