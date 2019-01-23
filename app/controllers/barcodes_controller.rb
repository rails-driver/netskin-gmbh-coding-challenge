class BarcodesController < ApplicationController
  include ActionView::Helpers::TextHelper

  before_action :build_new_form, only: %i(import create)

  def import
    if request.post? && @form.submit
      redirect_to :root, notice: "#{pluralize @form.imported_count, 'barcode'} imported!"
    end
  end

  def generate
    generated_count = barcode_generator.generate

    redirect_to :root, notice: "#{pluralize generated_count, 'barcode'} generated!"
  end

  protected

  def build_new_form
    @form = Barcodes::ImportForm.new params[:form]
  end

  def barcode_generator
    @barcode_generator ||= BarcodeGeneratorService.new
  end
end
