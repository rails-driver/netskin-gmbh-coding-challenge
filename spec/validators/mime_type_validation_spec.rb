describe MimeTypeValidator do
  context '#validate_each' do
    let(:mime_type) { 'mime_type_example' }

    let(:valid_file) do
      OpenStruct.new content_type: mime_type
    end

    let(:wrong_file) do
      OpenStruct.new content_type: "wrong_#{mime_type}"
    end

    let(:model_class) do
      valid_mime_type = mime_type

      Class.new do
        include ActiveModel::Model

        attr_accessor :file

        validates :file, mime_type: [valid_mime_type]
      end
    end

    it 'should validate fil mime type' do
      model = model_class.new file: valid_file

      assert model.valid?

      model = model_class.new file: wrong_file

      assert_equal model.valid?, false
      assert_equal model.errors.to_h, file: 'wrong mime type'
    end
  end
end
