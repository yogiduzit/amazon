class User < ApplicationRecord

  scope(:search, -> (search) {
    where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", 
      "%#{search}%", "%#{search}%", "%#{search}%")
  })

end



