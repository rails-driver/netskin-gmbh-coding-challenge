class BarcodeGeneratorService
  # This is just an example service. Please implement me.
  # Feel free to create more services as needed.
  def generate
    generate_count = rand 1..100
    generated_count = 0
    barcode_start_number = 1

    while generated_count < generate_count
      barcode = generate_from_number barcode_start_number

      unless Barcode.where(barcode: barcode).exists?
        Barcode.create barcode: barcode, source: :generator
        generated_count += 1
      end

      barcode_start_number += 1
    end

    generate_count
  end

  def generate_from_number(number)
    EAN8.complete number.to_s.rjust(7, '0')
  end
end
