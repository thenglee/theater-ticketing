class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 0, vip: 1, admin: 2 }

  has_many :tickets

  def tickets_in_cart
    tickets.waiting.all.to_a
  end
end
