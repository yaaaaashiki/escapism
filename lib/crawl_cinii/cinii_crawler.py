# coding:utf-8

from bs4 import BeautifulSoup
import json
import re
import requests
import urllib.parse


class CiniiCrawler:
    def __init__(self, keyword, start):
        self.keyword = keyword  # 検索キーワード
        self.start = start  # 開始インデックス

    def _url_encode(self):
        # 検索キーワードにURLエンコーディングを行う
        return urllib.parse.quote_plus(self.keyword, encoding='utf-8')

    @staticmethod
    def crawling(url):
        # Ciniiからデータを取得する
        return requests.post(url)

    def scraping(self):
        # クローリング
        url = "http://ci.nii.ac.jp/search?q=%s&range=0&sortorder=1&count=20&start=%d" \
              % (self._url_encode(), self.start)
        response = self.crawling(url=url)

        # BeautifulSoupオブジェクトを作成
        soup = BeautifulSoup(response.text, "lxml")

        # スクレイピング
        data = []
        papers = soup.find_all(class_="paper_class")
        for paper in papers:
            # タイトル，著者，URLを取得
            title = paper.find(class_='taggedlink').string
            authors = paper.find(class_='item_subData item_authordata').string
            url = 'http://ci.nii.ac.jp' + paper.find(class_='taggedlink').get('href')

            # 著者情報を含めると，正規表現の処理により時間がかかる
            authors = re.sub("\n*\t*", "", authors.strip())
            if ',' in authors:
                authors = authors.split(",")

            # 著者情報のない文献は消去
            if authors:
                data.append({"title": title.strip(), "URL": url, "Author": authors})

        # Pythonの辞書型オブジェクトからJSONに変換する
        data_json = json.dumps(data, indent=2, ensure_ascii=False)

        return data_json


def main(keyword, start=1):
    cinii = CiniiCrawler(keyword=keyword, start=start)
    res_json = cinii.scraping()
    return res_json
