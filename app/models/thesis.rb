class Thesis < ApplicationRecord
  belongs_to :author

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks # elasticsearchとMYSQLとの自動同期に必要

  # 以下の参考ページ(http://ruby-rails.hatenadiary.com/entry/20151018/1445142266)

  # Elasticsearchへの接続時の設定
  index_name "thesis_#{Rails.env}" # インデックス名
  # document_type # ドキュメントタイプ，フォルトでクラス名

  settings do
    mappings dynamic: 'false' do # デフォルトでマッピングが自動作成されるがそれを無効にする
      # マッピングの公式ドキュメント
      # https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-core-types.html
      indexes :year
      indexes :comment, analyzer: 'kuromoji'
      indexes :url
      indexes :pdf_text, analyzer: 'kuromoji'

      # date型として定義
      # formatは日付のフォーマットを指定(2015-10-16T19:26:03.679Z)
      # 詳細: https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-date-format.html
      indexes :created_at, type: 'date', format: 'date_time'

      indexes :author do
        indexes :name, analyzer: 'keyword', index: 'not_analyzed'
      end
    end
  end

  # importメソッドのコールバックメソッド
  # マッピングのデータを返すようにする
  def as_indexed_json(options = {})
    attributes
      .symbolize_keys
      .slice(:year, :comment, :url, :pdf_text, :created_at)
      .merge(author: { name: author.name })
  end

  # Elasticsearchからのレスポンスを返す
  def self.search(params = {})
    keyword = params[:q]

    # 検索クエリを作成（Elasticsearch::DSLを利用）
    # 参考: https://github.com/elastic/elasticsearch-ruby/tree/master/elasticsearch-dsl
    search_definition = Elasticsearch::DSL::Search.search {
      query {
        if keyword.present?
          multi_match {
            query keyword
            fields %w{ author.name year address comment url pdf_text }
          }
        else
          match_all
        end
      }
    }

    # 検索クエリをなげて結果を表示
    __elasticsearch__.search(search_definition)
  end
end
