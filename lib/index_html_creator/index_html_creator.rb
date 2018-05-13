class IndexHtmlCreator
  def self.create(year, labo_id, number_of_registration, theses_information)
    labo = Labo.find labo_id
    
    template_path = Rails.root.join('lib', 'index_html_creator', 'index.html.slim')
    scope = {labo: labo, year: year, number_of_registration: number_of_registration, theses_information: theses_information};
    contents = Slim::Template.new(template_path).render(self, scope)

    thesis_absolute_pash = Thesis.LABO_THESIS_ROOT_DIRECTORY + year + 'contents' + Labo.LABO_HASH[labo.name] + 'index.html'
    File.open(thesis_absolute_pash, "w") do |f| 
      f.puts contents
    end

    thesis_absolute_pash
  end
end