class LineConnection < ApplicationRecord
  belongs_to :account, polymorphic: true
end
