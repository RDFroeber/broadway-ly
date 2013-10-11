require "active_record"
require "pry"

ActiveRecord::Base.establish_connection(
    :adapter => "postgresql",
    :host     => "localhost",
    :username => "RaleighD",
    :password => "",
    :database => "broadway_db"
)

class Show < ActiveRecord::Base
   has_many :songs

   # requires inputs at ruby level
   validates :title, :year, :composer, :img_url, presence: true
end

class Song < ActiveRecord::Base
   belongs_to :show

   # requires input at ruby level
   validates :title, :embed_url, presence: true
end

binding.pry