class BroadcastProductJob < ApplicationJob
  queue_as :default

  def perform(product)
    ActionCable.server.broadcast 'product_channel', render_product(product)
  end

  private

  def render_product(product)
    ApplicationController.renderer.render partial: 'products/product', locals: { product: product }
  end
end
