source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'

gem 'bootstrap-sass'

gem 'devise'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#中文翻译
gem "rails-i18n"

# devise中文翻译
gem "devise-i18n"

# 添加jquery plugin：select2
gem "select2-rails"

# ui动态新增
gem "nested_form_fields"

# 日历控件
gem 'bootstrap-datepicker-rails'

# rich editor 富文本
gem 'ckeditor'

# 自定义排序
gem 'ranked-model'

# 在页面拖拽调整顺序
gem 'jquery-ui-rails'

# 分页
gem 'kaminari'

# 搜索关键字
gem 'ransack'

# 上传和存储图片
gem 'carrierwave'
gem "mini_magick"

# 版本控制
gem 'paper_trail'

# 安装excel
gem 'rubyzip'
gem 'axlsx'
gem 'axlsx_rails'

# 邮件按照自定义css显示
gem 'premailer-rails'

# 异步处理任务
gem 'sidekiq'

group :development, :test do
  gem 'rspec-rails'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  gem 'faker'

  # 添加开发中邮件发送
  gem  'letter_opener'

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
