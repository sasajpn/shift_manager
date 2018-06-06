module LuminanceFormula
  extend ActiveSupport::Concern

  def rgb
    calendar_color.delete('#').scan(/../).map(&:hex)
  end

  def luminance
    0.3 * rgb[0] + 0.6 * rgb[1] + 0.1 * rgb[2]
  end

  def font_color
    if luminance > 127
      '#000000'
    else
      '#FFFFFF'
    end
  end
end
