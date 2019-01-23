describe Ean8Validator do
  context '#validate_each' do
    let(:valid_ean8) { '00000079' }

    let(:invalid_ean8) { '12345678' }

    let(:model_class) do
      Class.new do
        include ActiveModel::Model

        attr_accessor :barcode

        validates :barcode, ean8: true
      end
    end

    it 'should validate fil mime type' do
      model = model_class.new barcode: valid_ean8

      assert model.valid?

      model = model_class.new barcode: invalid_ean8

      assert_equal model.valid?, false
      assert_equal model.errors.to_h, barcode: 'is not an ean8'
    end
  end
end
