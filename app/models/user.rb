class User < ApplicationRecord

  scope(:search, -> (search) {
    where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", 
      "%#{search}%", "%#{search}%", "%#{search}%")
  })

  scope(:created_after, -> (date) {
    # where(created_at: [date, Time.now])
    where("created_at > ?", date)
  })

  scope(:not_john, -> {
    where("first_name NOT ILIKE ? AND last_name NOT ILIKE ?", "john", "john")
  })

end



