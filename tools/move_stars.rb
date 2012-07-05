Hotel.suspended_delta do
  Hotel.all.each do |h|
    stars = h.data.try(:[], 'stars')
    if stars.to_i > 0
      h.stars = stars.to_i
      h.save
    end
  end
end