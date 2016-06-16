class Intersection < ActiveRecord::Base
  has_many :posts

  scope :find_all_by_address, -> (search1, search2) {
    where('street1 LIKE :search1 AND street2 LIKE :search2',
          search1: "%#{search1}%", search2: "%#{search2}%")
  }
end
