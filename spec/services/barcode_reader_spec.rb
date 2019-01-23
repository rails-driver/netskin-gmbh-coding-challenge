describe BarcodeReader do
  let(:file) { "#{Rails.root}/spec/etc/barcodes.xlsx" }

  it 'should read data from file' do
    reader = BarcodeReader.new file

    assert_equal reader.entries, [
      { barcode: '00000079' }, { barcode: '00000093' }, { barcode: '12345678' }
    ]
  end
end
