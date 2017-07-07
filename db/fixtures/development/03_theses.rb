Thesis.__elasticsearch__.create_index! force: true
Thesis.__elasticsearch__.refresh_index!

ThesisImporter.upsert_all!(Thesis.LABO_2015_THESES)
ThesisImporter.upsert_all!(Thesis.LABO_2016_THESES)

