module ApplicationHelper
  def cart_count_over_one
    if @cart.line_items.count.positive?
      "<span class='tag-is-dark'>#{@cart.line_items.count}</span>".html_safe
    end
  end

  def cart_has_items
    @cart.line_items.count.positive?
  end

  def user_avatar(user)
    user.image.url(:thumb)
  end

  def get_total(line_item)
    number_to_currency(line_item.total_price)
  end

  def grand_total
    number_to_currency(@cart.total_price)
  end
end
