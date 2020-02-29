class Story < ApplicationRecord
  belongs_to :user, dependent: :destroy
  validates :title, presence: true
end
