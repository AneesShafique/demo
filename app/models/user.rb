class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_attached_file :image, styles: { medium: '300x300>', thumb: '50x50>' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_associated :reviews, :products
end
