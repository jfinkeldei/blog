class Article < ApplicationRecord
  include Visible
  has_many :comments, dependent: :destroy
  belongs_to :user

  has_rich_text :content

  validates :title, presence: true
  validates :body, presence: true, length: {minimum: 10}
end
