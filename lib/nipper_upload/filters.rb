require 'fastercsv'

module NipperUpload  
  private
  @@logger=nil

  public
  
  # This method will be called by the framework when the user selects your 
  # plugin from the drop down list of the 'Import from file' dialog
  def self.import(params={})
    file_path = params[:file]
    file_content = File.read( params[:file] )
    @@logger = params.fetch(:logger, Rails.logger)

    # get the "nipper output" category instance or create it if it does not exist
    category = Category.find_or_create_by_name( Configuration.category )
    # every note we create will be assigned to this author
    author = Configuration.author
    # create the parent early so we can use it to provide feedback on errors
    parent = Node.find_or_create_by_label( Configuration.parent_node)

    # Parse the contents of the CSV file
    @@logger.info("Parsing Nipper output")
    FasterCSV.foreach(file_path, options = { :headers => true }) do |row|
      # TODO: write a Nipper class in which to encapsulate import of a Nipper output file
      title = row[0].gsub(/^\d\.\d+\s/,'')
      devices = row[1]
      impact = row[3]
      likelihood = row[4]
      description = row[2]
      recommendation = row[5]

      note_text = ''
      note_text << "#[Title]#\n"
      note_text << "#{title}\n\n"  
      note_text << "#[Devices]#\n"
      note_text << "#{devices}\n\n"
      note_text << "#[Impact]#\n"
      note_text << "#{impact}\n\n"
      note_text << "#[Likelihood]#\n"
      note_text << "#{likelihood}\n\n"
      note_text << "#[Description]#\n"
      note_text << "#{description}\n\n"
      note_text << "#[Recommendation]#\n"
      note_text << "#{recommendation}\n\n"
      @@logger.info("Parsing item: #{title} for devices: #{devices}")
      
      item_node = parent.children.find_or_create_by_label(title)
      item_node.notes.create(
        :author => author,
        :category => category,
        :text => note_text
      )
    end    

    @@logger.info("Done")
  end
end
