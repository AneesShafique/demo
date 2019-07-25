class LineItemsController < ApplicationController
  include CurrentCart
  include ActionView::Helpers::NumberHelper
  before_action :set_line_item, only: %i[show edit update destroy]
  before_action :set_cart, only: %i[create decrease]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)
    respond_to do |format|
      if @line_item.save
        format.js { render :show, locals: { action: 'create' } }
        format.html { redirect_to cart_path(@line_item.cart), notice: 'Item added to cart.' }
      else
        format.html { render :new }
      end
    end
  end

  def decrease
    product = Product.find(params[:product_id])
    @line_item = @cart.decrease_product(product)

    respond_to do |format|
      if @line_item.save
        format.js { render :show, locals: { action: 'decrease' } }
        format.html { redirect_to cart_path(@line_item.cart) }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @cart = Cart.find(session[:cart_id])

    @line_item.destroy
    @grand_total = number_to_currency(@cart.total_price)
    respond_to do |format|
      format.js { render :remove}
      format.html { redirect_to cart_path(@cart), notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def line_item_params
    params.require(:line_item).permit(:products_id)
  end
end
