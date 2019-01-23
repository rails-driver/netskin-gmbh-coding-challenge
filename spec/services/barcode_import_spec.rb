describe BarcodeImport do
  let(:file) { "#{Rails.root}/spec/etc/barcodes.xlsx" }

  let(:valid_file) { "#{Rails.root}/spec/etc/valid_barcodes.xlsx" }

  context '#import' do
    context 'when import invalid file' do
      it 'should return errors' do
        importer = BarcodeImport.new file

        assert_equal importer.import, false
        assert_equal importer.errors, '12345678' => { barcode: 'is not an ean8' }
      end
    end

    context 'when import valid file' do
      it 'should import data' do
        importer = BarcodeImport.new valid_file

        importer.import

        assert_equal Barcode.count, 2
        assert_equal Barcode.last.source, 'excel'
      end
    end
  end
end
