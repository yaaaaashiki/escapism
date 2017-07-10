require 'find'

module CSVCreator
  # pdf形式が悪いと途中で例外や警告が出るが無視して良い
  def create()
    puts('creating...')

    outFileName = Rails.root.join('lib/select_lab/thesis_data.csv')
    file = File.open(outFileName,'w')
    
    file.puts('text,labName')

    Thesis.YHESIS_DIRECTORY_PAR_YEAR.each do |year|
      Labo.ARRAY_LABO_DIRECTORY_NAMES.each do |labName|
        labDir = Thesis.LABO_THESIS_ROOT_DIRECTORY.join(year, 'contents', labName)
        Find.find(labDir) do |path|
          if path =~ /.*\.pdf/
            data = ThesisData.new(path, labName)
            file.puts(data.text + "," + data.labName)
            puts('have written: ' + path)
          end
        end
      end
    end

    file.close()

    puts('created!!')
  end

  module_function :create
end