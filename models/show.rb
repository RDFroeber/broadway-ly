class Show < ActiveRecord::Base
   has_many :songs

   # requires inputs at ruby level
   validates :title, :year, :composer, :img_url, presence: true
end