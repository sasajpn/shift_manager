class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         reconfirmable: true

  has_one :line_connection, as: :account

  has_many :approval_members, -> { where(approve: true) }, dependent: :destroy, class_name: 'Member'
  has_many :unapproval_members, -> { where(approve: false) }, dependent: :destroy, class_name: 'Member'
  has_many :teams, through: :approval_members
  has_many :shift_submissions, through: :members
  has_many :shift_adjustments, through: :shift_submissions

  validates :last_name_kana, :first_name_kana, :last_name, :first_name,
    presence: true
  validates :last_name_kana, katakana_format: true
  validates :first_name_kana, katakana_format: true

  before_destroy :remain_future_shift_adjustment, prepend: true

  def name
    last_name + ' ' + first_name
  end

  private

  def remain_future_shift_adjustment
    if self.shift_adjustments.futures.any?
      errors.add(:base, '未来に調整済みのシフトが残っているため、退会できません')
      throw :abort
    end
  end
end
