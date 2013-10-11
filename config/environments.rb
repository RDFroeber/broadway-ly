configure :production, :development do
   # db remote path                                         # db local path
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://RaleighD@localhost/broadway_db')

  ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end