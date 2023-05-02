# Blog

ブログシステム

## Ruby version

- See `.ruby-version`.

## Rails version

- See `Gemfile`.

## System dependencies

- SQLite3
- Redis
- Node.js = 15.14.0  
- Yarn >= 0.20.1

## Project initiation

- Gemのインストール

```bash
$ bundle install --path vendor/bundle
```

- npmのインストール

```bash
$ yarn install
```

### Configuration

*ファイルの中身はご自身の環境に合わせて適宜変更してください*

- データベースの設定

```bash
$ cp config/database.yml.default config/database.yml
```

- 環境変数の設定

```bash
$ cp .env.default .env
```

### Database creation

```bash
$ bundle exec rails db:setup
```

### Database initialization

```bash
$ bundle exec rails db:seed_fu
```

## Run rails server

```bash
$ bundle exec rails server
```

## Webpacker

webpack-dev-serverの起動

```
$ ./bin/webpack-dev-server
```

## Development controller

### Force login

- See `app/controllers/development/sessions_controller.rb`

```
/login_as/[user_id]
```

## Testing

```bash
$ bundle exec rspec spec/[対象ファイル]
```
