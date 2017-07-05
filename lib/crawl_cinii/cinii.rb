require 'open-uri'
require 'nokogiri'
require 'uri'
require 'json'


def url_encoding(keyword)
  # TODO: start=0で始めるかstart=変数にするかどうか検討が必要
  return URI.escape("http://ci.nii.ac.jp/search?q=#{keyword}&range=0&count=20&sortorder=1&type=0")
end

def crawling(url)
    # TODO: 取得できなかった場合のError処理をどうしようか検討が必要
    return Nokogiri::HTML.parse(open(url))
end

def scraping(html)
    data = {}
    html.css('#itemlistbox > ul > li').each_with_index do |article, i|
        title = article.at_css('div > dl > dt > a').text.strip
        url = "http://ci.nii.ac.jp" + article.at_css('div > dl > dt > a')[:href]
        author = article.at_css('p.item_subData.item_authordata')
        if not author.nil?
            author = author.text.gsub(/(\s|　)+/, '')
        end
        data[i] = {
            "title": title,
            "url": url,
            "author": author,
        }
     end
    return data.to_json
end


def main(search_keyword)
    # search_keywordは配列を想定
    keyword = search_keyword.join("+")
    html = crawling(url=url_encoding(keyword=keyword))
    json_data = scraping(html=html)
    print(json_data)
end

# テスト
test_keyword = ["Ruby", "国際化"]
main(search_keyword=test_keyword)