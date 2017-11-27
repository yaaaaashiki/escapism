10.times do |i|
  i += 1
  User.seed(:id) do |u|
    u.id = i
    u.email = "user#{i}@exdining.com"
    u.labo = i % 7 + 1
    u.username = "user#{i}"
    u.role = i % 2 + 1
    u.salt = "asdasdastr4325234324sdfds"
    u.crypted_password = Sorcery::CryptoProviders::BCrypt.encrypt("password", "asdasdastr4325234324sdfds")
  end
end
