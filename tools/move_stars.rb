Hotel.suspended_delta do
  Hotel.all.each do |h|
    stars = h.data.try(:[], 'stars')
    unless (stars.blank? || stars.to_i.zero?)
      h.stars = stars.to_i
      h.save
    end
  end
end