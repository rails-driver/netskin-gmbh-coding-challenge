class BarcodeImport
  def initialize(file)
    @file = file
  end

  def errors
    @errors ||= reader.map do |data|
      barcode = Barcode.new data

      if barcode.valid?
        nil
      else
        [data[:barcode], barcode.errors.to_h]
      end
    end.compact.to_h
  end

  def import
    return false if errors.present?

    reader.each do |data|
      Barcode.create data.merge source: :excel
    end
  end

  def reader
    @reader ||= BarcodeReader.new @file
  end
end
