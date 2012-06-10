class Option < ActiveRecord::Base
  attr_accessible :key, :title, :value

  validates_presence_of :key, :value

  self.all.each do |option|
    define_singleton_method(option.key) do
      option.value
    end
  end
end
