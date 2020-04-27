class JsonWebToken
  def self.encode(payload, auth_secret)
    JWT.encode(payload, auth_secret, 'HS256')
  end

  def self.decode(token, auth_secret)
    return HashWithIndifferentAccess.new(JWT.decode(token, auth_secret,  true, { algorithm: 'HS256' })[0])
  rescue
    nil
  end
end
