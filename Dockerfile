# rubyのバージョン固定
FROM ruby:3.2.8-slim

# パッケージのインストール
RUN apt-get update -qq && \
    # 指定したパッケージをインストール
        apt-get install --no-install-recommends -y curl \
        # MYSQLサーバー
        # default-libmysqlclient-dev \
        curl \
        g++ \
        git \
        libmariadb-dev \
        libpq-dev \
        libssl-dev \
        libyaml-dev \
        make \
        tzdata \
    # APTで使用したキャッシュファイルやメタデータを削除して、イメージサイズを小さく保つ
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

# ---- Bundler 設定 ----
# 本番用だけインストール（development と test を除外）
ENV BUNDLE_WITHOUT="development test"

# ---- アプリケーション ----
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

