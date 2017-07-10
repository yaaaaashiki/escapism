require 'find'

module CSVCreator
  # pdf形式が悪いと途中で例外や警告が出るが無視して良い
  def create()
    puts('creating...')

    outFileName = Rails.root.join('lib/select_lab/thesis_data.csv')
    file = File.open(outFileName,'w')
    
    file.puts('text,labName')

    # 以下の配列は論文がまとめられているディレクトリ名に対応
    # 例) /thesis_data/ignore/labName[0]以下にduerst研の論文がある
    labNames = %w(duerst harada komiyama lopez ohara sakuta sumi tobe) # yamaguchi)
    labNames.each do |labName|
      labDir = Rails.root.join('thesis_data/ignore/' + labName)
      Find.find(labDir) do |path|
        if path =~ /.*\.pdf/
          data = ThesisData.new(path, labName)
          file.puts(data.text + "," + data.labName)
          puts('have written: ' + path)
        end
      end
    end

    file.close()

    puts('created!!')
  end

  module_function :create
end