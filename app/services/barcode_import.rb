class BarcodeImport
  def initialize(file)
    @file = file
  end

  def errors
    @errors ||= reader.map do |data|
      barcode = Barcode.new preprocess_data(data)

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
      Barcode.create preprocess_data(data)
    end
  end

  def preprocess_data(data)
    data.merge barcode: format_barcode(data[:barcode]), source: :excel
  end

  def format_barcode(barcode)
    return barcode if barcode.blank? || barcode.length >= 8

    barcode_8 = barcode.rjust(8, '')

    return barcode_8 if EAN8.valid? barcode_8

    EAN8.complete barcode.rjust(7, '0')
  end

  def reader
    @reader ||= BarcodeReader.new @file
  end
end
