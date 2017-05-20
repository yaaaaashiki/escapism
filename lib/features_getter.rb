require 'find'

module FeaturesGetter
  LABO_NAMES = %w(duerst harada komiyama lopez ohara sakuta sumi tobe ) # yamaguchi)
  THESIS_ROOT_PATH = 'thesis_data/ignore/'

  def fetch(number_of_feature)
    thesis_wakati_array_per_labo = create_thesis_wakati_array_per_labo
    tf_idf_array_per_labo = create_tf_idf_array(thesis_wakati_array_per_labo)
    extract_labo_fatures(tf_idf_array_per_labo, number_of_feature)
  end

  def create_thesis_wakati_array_per_labo
    thesis_wakati_array_per_labo = []
    LABO_NAMES.each do |labo_name|
      labo_thesis_wakati_array = create_labo_thesis_wakati_array(labo_name)
      thesis_wakati_array_per_labo.push(labo_thesis_wakati_array)
    end

    thesis_wakati_array_per_labo
  end
  
  def create_labo_thesis_wakati_array(labo_name)
    labo_dir = Rails.root.join(THESIS_ROOT_PATH + labo_name)
    labo_thesis_wakati_array = []
    Find.find(labo_dir) do |path|
      if path =~ /.*\.pdf/
        thesis_wakati_array = create_wakati_array(path)
        labo_thesis_wakati_array.concat(thesis_wakati_array)
        puts 'have read: ' + path 
      end
    end

    labo_thesis_wakati_array
  end

  def create_wakati_array(text_path)
    data = Yomu.new(text_path)
    wakati_text = parse_wakati(data.text)
    cleaned_wakati_text = clean_wakati_text(wakati_text)
    cleaned_wakati_text.split(' ')
  end

  def parse_wakati(text)
    natto = Natto::MeCab.new(output_format_type: :wakati)
    natto.parse(text)
  end

  def clean_wakati_text(wakati_text)
    wakati_text.gsub!(/[\sθ�…ɽ!"#$%&'=~^`@;:,<>_、。．，\(\)\[\]\{\}\.\?\+\*\|\\\-\/]/u, " ")
    
    # SlothLibの日本語ストップワード(http://svn.sourceforge.jp/svnroot/slothlib/CSharp/Version1/SlothLib/NLP/Filter/StopWord/word/Japanese.txt)
    stop_words = %w(あそこ あたり あちら あっち あと あな あなた あれ いくつ いつ いま いや いろいろ うち おおまか おまえ おれ がい かく かたち かやの から がら きた くせ ここ こっち こと ごと こちら ごっちゃ これ これら ごろ さまざま さらい さん しかた しよう すか ずつ すね すべて ぜんぶ そう そこ そちら そっち そで それ それぞれ それなり たくさ たち たび ため だめ ちゃ ちゃん てん とおり とき どこ どこか ところ どちら どっか どっち どれ なか なかば なに など なん はじめ はず はるか ひと ひとつ ふく ぶり べつ へん ぺん ほう ほか まさ まし まとも まま みたい みつ みなさん みんな もと もの もん やつ う よそ わけ わたし ハイ 彼女 下記 上記 時間 前回 場合 一つ 年生 自分 ヶ所 ヵ所 カ所 箇所 ヶ月 ヵ月 カ月 箇月 名前 本当 確か 時点 全部 関係 近く 方法 我々 違い 多く 扱い 新た その後 半ば 結局 様々 以前 以後 以降 未満 以上 以下 幾つ 毎日 自体 向こう 何人 手段 同じ 感じ)
    stop_words.each do |s|
      wakati_text.gsub!(/\p{blank}#{s}\p{blank}/u, " ")
    end

    my_stop_words = %w(ある いる する ない よう コード ソース 研究 実験 プロパティ メソッド 処理 使用 可能 クラス その として 削減 れる できる この データ 10 手法 また なる 領域 プログラム 結果 :// the システム 生成 of 追加 情報 is 評価 辞書 被験者 表示 平均 操作 項目 について という られ 用い 示す より による この 利用 れる 行う られる and 論文 必要 作成 on における ます 機能 to 青山 学院 大学 青山学院大学 情報テクノロジー 学科 なっ コマンド 入力 行っ に対する により 参加 用いる in 理工学部 優位 比較 考え Fig co Un ng Ra en an th Facto nt Jo HF LF CR cle F Ref tter 有意 nect 考察 目的 序論 結果 因子 でき フォン 間隔 において 隆)
    my_stop_words.each do |s|
      wakati_text.gsub!(/\p{blank}#{s}\p{blank}/u, " ")
    end
    
    wakati_text.gsub!(/\p{blank}.\p{blank}/u, " ")

    wakati_text
  end

  def create_tf_idf_array(wakati_array)
    tfidf = TfIdf.new(wakati_array)
    tfidf.tf_idf
  end

  def extract_labo_fatures(tf_idf_array_per_labo, number_of_feature)
    labo_features = {}
    tf_idf_array_per_labo.zip(LABO_NAMES) do |tf_idf, labo_name|
      labo_features[labo_name] = extract_feature(tf_idf, number_of_feature)
    end

    labo_features
  end

  def extract_feature(tf_idf, number_of_feature)
    sorted_tf_idf = tf_idf.sort_by{ |key, value| -value }
    Hash[*sorted_tf_idf.to_a.shift(number_of_feature).flatten!]
  end
  
  module_function :fetch
  module_function :create_thesis_wakati_array_per_labo, :create_labo_thesis_wakati_array, :create_wakati_array
  module_function :parse_wakati, :clean_wakati_text
  module_function :create_tf_idf_array, :extract_labo_fatures, :extract_feature 
end
