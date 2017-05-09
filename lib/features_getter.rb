require 'find'

module FeaturesGetter
  def fetch(feature_num)
    lab_names = %w(duerst harada komiyama lopez ohara sakuta sumi tobe yamaguchi)
    feature_hash = {}
    lab_names.each do |lab_name|
      feature_hash[lab_name] = fetch_lab_feature(lab_name, feature_num)
    end
    
    feature_hash
  end
  
  def fetch_lab_feature(lab_name, feature_num)
    lab_dir = Rails.root.join('thesis_data/ignore/' + lab_name)
    cleaned_all_wakati_array = []
    Find.find(lab_dir) do |path|
      if path =~ /.*\.pdf/
        data = Yomu.new(path)
        wakati_text = parse_wakati(data.text)
        cleaned_wakati_text = clean_wakati_text(wakati_text)
        cleaned_wakati_array = parse_wakati_array(cleaned_wakati_text)
        cleaned_all_wakati_array.concat(cleaned_wakati_array)
        puts 'have read: ' + path 
      end
    end

    tf_idf_hash = create_tf_idf_hash(cleaned_all_wakati_array)
    tf_idf_sorted = tf_idf_hash.sort_by{ |k, v| -v }
    Hash[*tf_idf_sorted.to_a.shift(feature_num).flatten!] 
  end

  def parse_wakati(text)
    natto = Natto::MeCab.new(output_format_type: :wakati)
    natto.parse(text)
  end
  
  def clean_wakati_text(wakati_text)
    wakati_text.gsub!(/[θsdi�…ɽ!"#$%&'=~^`@;:,<>_\r\n、。．，０-９0-9\(\)\[\]\{\}\.\?\+\*\|\\\-\/]/, " ")
    wakati_text.gsub!(/\p{blank}.\p{blank}/, " ")
    wakati_text.gsub!(/\p{blank}[あ-ん]\p{blank}/, " ")
    
    # SlothLibの日本語ストップワード(http://svn.sourceforge.jp/svnroot/slothlib/CSharp/Version1/SlothLib/NLP/Filter/StopWord/word/Japanese.txt)
    stop_words = %w(あそこ あたり あちら あっち あと あな あなた あれ いくつ いつ いま いや いろいろ うち おおまか おまえ おれ がい かく かたち かやの から がら きた くせ ここ こっち こと ごと こちら ごっちゃ これ これら ごろ さまざま さらい さん しかた しよう すか ずつ すね すべて ぜんぶ そう そこ そちら そっち そで それ それぞれ それなり たくさ たち たび ため だめ ちゃ ちゃん てん とおり とき どこ どこか ところ どちら どっか どっち どれ なか なかば なに など なん はじめ はず はるか ひと ひとつ ふく ぶり べつ へん ぺん ほう ほか まさ まし まとも まま みたい みつ みなさん みんな もと もの もん やつ う よそ わけ わたし ハイ 上 中 下 字 年 月 日 時 分 秒 週 火 水 木 金 土 都 道 府 県 市 区 町 村 各 第 方 何 的 度 文 者 性 体 人 他 今 部 課 係 外 類 達 気 室 口 誰 用 界 会 首 男 女 別 話 私 屋 店 家 場 等 見 際 観 段 略 例 系 論 形 間 地 員 線 点 書 品 力 法 感 作 元 手 数 彼 彼女 子 内 楽 喜 怒 哀 輪 頃 化 境 俺 奴 高 校 婦 伸 紀 誌 レ 行 列 事 士 台 集 様 所 歴 器 名 情 連 毎 式 簿 回 匹 個 席 束 歳 目 通 面 円 玉 枚 前 後 左 右 次 先 春 夏 秋 冬 一 二 三 四 五 六 七 八 九 十 百 千 万 億 兆 下記 上記 時間 回 前回 場合 一つ 年生 自分 ヶ所 ヵ所 カ所 箇所 ヶ月 ヵ月 カ月 箇月 名前 本当 確か 時点 全部 関係 近く 方法 我々 違い 多く 扱い 新た その後 半ば 結局 様々 以前 以後 以降 未満 以上 以下 幾つ 毎日 自体 向こう 何人 手段 同じ 感じ)
    stop_words.each do |s|
      wakati_text.gsub!(/\p{blank}#{s}\p{blank}/, " ")
    end

    my_stop_words = %w(ある いる する ない よう コード ソース 研究 実験 プロパティ メソッド 処理 使用 可能 クラス その として 削減 れる できる この データ 10 手法 また なる 領域 プログラム 結果 :// the システム 生成 of 追加 情報 is 評価 辞書 被験者 表示 平均 操作 項目 について という られ 用い 示す より による この 利用 れる 行う られる and 論文 必要 本 作成 on における ます 機能 to 青山 学院 大学 青山学院大学 情報テクノロジー 学科 表 なっ コマンド 入力 行っ 「 」 に対する により 参加 用いる in 理工学部 図 優位 比較 考え Fig co Un ng t Ra en an th Facto nt Jo HF LF CR cle F Ref tter 有意 nect 考察 目的 序論 結果 e 因子 でき フォン 間隔 において)
    my_stop_words.each do |s|
      wakati_text.gsub!(/\p{blank}#{s}\p{blank}/, " ")
    end
    
    wakati_text
  end

  def parse_wakati_array(wakati_text)
    wakati_text.split(' ')
  end

  def create_tf_idf_hash(wakati_array)
    tfidf_input = [wakati_array, []] # 配列が2つ以上ないと正常に動かない
    tfidf = TfIdf.new(tfidf_input)
    tfidf.tf_idf[0]
  end

  module_function :fetch, :fetch_lab_feature, :parse_wakati, :clean_wakati_text, :parse_wakati_array, :create_tf_idf_hash
end
