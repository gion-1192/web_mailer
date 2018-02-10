# WebMailer

メール受信、送信をシンプルに行うgem

yahooメール、Gmailのみ実装済み

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'web_mailer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install web_mailer

## Usage

・受信手順

IMAPのサーバーデータの登録
```ruby
WebMailer.configuration do |config|
  config.host = 'imap_domain'
  config.port = 993
  config.user = 'username'
  config.passwd = 'password'
  config.examine = 'inbox'
end
```

登録後、asqirerメソッドにて受信
送信先アドレス、タイトル、本文、添付ファイル形式にはgetterメソッドよりアクセス可能
```ruby
WebMailer.asqirer('ALL') do |mail|
  puts '送信元:' + mail.address[0]
  puts 'タイトル:' + mail.title
  puts '本文:' + mail.body
  mail.tmp_files
end
```

・送信手順
Webメールアカウントの登録

```ruby
WebMailer.configuration do |config|
  config.user = 'account_name'
  config.passwd = 'account_password'
end
```

登録後、distributorメソッドにて送信
```ruby
WebMailer.distributor(:yahoo) do |mail|
  mail.to = 'post_mail_address'
  mail.subject = 'subject'
  mail.body = 'body'
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/web_mailer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
