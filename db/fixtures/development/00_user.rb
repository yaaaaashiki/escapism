10.times do |i|
  i += 1
  User.seed(
    :id,
    {
      id: i,
      email: "user#{i}@exdining.com",
      username: "user#{i}",
      year: 2015, 
      salt: "asdasdastr4325234324sdfds",
      crypted_password: Sorcery::CryptoProviders::BCrypt.encrypt(
        "password", "asdasdastr4325234324sdfds"
      )
    }
  )
end
