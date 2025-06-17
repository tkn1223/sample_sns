# rubyのバージョン固定
FROM ruby:3.2.8-slim

# パッケージのインストール
RUN apt-get update -qq && \
    # 指定したパッケージをインストール
    apt-get install --no-install-recommends -y curl \
    # MYSQLサーバー
    # default-libmysqlclient-dev \
    libmariadb-dev \
    g++ \
    make \
    libyaml-dev \
    tzdata \
    git && \
    # APTで使用したキャッシュファイルやメタデータを削除して、イメージサイズを小さく保つ
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# コンテナ起動時の作業ディレクトリを指定
WORKDIR /app

# PC上のファイルを.（/app）にコピー
COPY Gemfile Gemfile.lock ./

RUN bundle install

