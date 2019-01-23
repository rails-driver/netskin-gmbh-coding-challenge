class Barcodes::ImportForm < Form
  attr_accessor :imported_count
  attr_accessor :import_errors

  attribute :file

  validates :file, presence: true
  validates :file, mime_type: %w(application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)

  def process
    unless generator_service.import
      self.import_errors = generator_service.errors
      return false
    end

    self.imported_count = generator_service.reader.count

    true
  end

  def generator_service
    @generator_service ||= BarcodeImport.new file.to_io
  end
end
