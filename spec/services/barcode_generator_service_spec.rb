describe BarcodeGeneratorService do
  context '#generate' do
    before do
      Barcode.create [{ barcode: '00000017' }, { barcode: '00000024' }, { barcode: '00000055' }]
    end

    it 'should generate data' do
      service = BarcodeGeneratorService.new
      expect(service).to receive(:rand).and_return(3)

      assert_equal service.generate, 3

      assert_equal Barcode.count, 6

      generated_barcodes = Barcode.order(id: :desc).take(3)

      expect(generated_barcodes).to include(
                                      have_attributes(barcode: '00000031'),
                                      have_attributes(barcode: '00000048'),
                                      have_attributes(barcode: '00000062')
                                    )
    end
  end
end
