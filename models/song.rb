class Song < ActiveRecord::Base
   belongs_to :show

   # requires input at ruby level
   validates :title, :embed_url, presence: true
end