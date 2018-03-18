AdminUser.seed(
  { id: 1,
    username: ENV['PRODUCTION_ADMIN_USER_NAME'],
    password_digest: BCrypt::Password.create(ENV['PRODUCTION_ADMIN_USER_PASSWORD'])
  }
)
