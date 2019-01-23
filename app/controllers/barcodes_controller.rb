class BarcodesController < ApplicationController
  include ActionView::Helpers::TextHelper

  before_action :build_new_form, only: %i(import create)

  def import
    if request.post? && @form.submit
      redirect_to :root, notice: "#{pluralize @form.imported_count, 'barcode'} generated"
    end
  end

  protected

  def build_new_form
    @form = Barcodes::ImportForm.new params[:form]
  end
end
