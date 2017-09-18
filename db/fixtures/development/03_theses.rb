Thesis.__elasticsearch__.create_index! force: true
# elasticsearchの処理終了を待つ
sleep(3)
Thesis.__elasticsearch__.refresh_index!
# elasticsearchの処理終了を待つ
sleep(3)

#ThesisImporter.upsert_all!(Thesis.LABO_2014_THESES)
#ThesisImporter.upsert_all!(Thesis.LABO_2015_THESES)
ThesisImporter.upsert_all!(Thesis.LABO_2016_THESES)

