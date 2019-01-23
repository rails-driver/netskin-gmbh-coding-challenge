class BarcodeReader
  include Enumerable

  def initialize(file)
    @file = file
  end

  def each
    worksheet.each_with_index do |row, index|
      next if index == 0
      data_arr = row.cells.map { |cell| cell&.value&.to_s }
      next if data_arr.reject(&:blank?).empty?

      data = headers.each_with_index.map do |header, header_index|
        [header, data_arr[header_index]]
      end.to_h

      yield data
    end
  end

  def headers
    @header ||= %i(barcode)
  end

  def worksheet
    @worksheet ||= RubyXL::Parser.parse(@file)[0]
  end
end
