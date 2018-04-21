module OwnerDecorator
  def name
    last_name + ' ' + first_name
  end

  def name_kana
    last_name_kana + ' ' + first_name_kana
  end

end
