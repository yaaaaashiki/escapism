Thesis.__elasticsearch__.create_index! force: true
Thesis.__elasticsearch__.refresh_index!

ThesisImporter.upsert_all!