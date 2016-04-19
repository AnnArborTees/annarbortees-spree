# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
if Rails.env.production? || Figaro.env['secret_key_base'].present?
  ShopAnnarborteesCom::Application.config.secret_key_base = Figaro.env['secret_key_base']
else
  ShopAnnarborteesCom::Application.config.secret_key = '1cf662b2e438452e1dd01beffa2f1a3fea9e1c665b1c459ab5469e7defa7f0d0b25c347d989bd7e37a1e93c1a41c7c1ad005878f855d82887d2d11b23a4a76f1'
  ShopAnnarborteesCom::Application.config.secret_key_base = '2cf662b2e438452e1dd01beffa2f1a3fea9e1c665b1c459ab5469e7defa7f0d0b25c347d989bd7e37a1e93c1a41c7c1ad005878f855d82887d2d11b23a4a76f1'
end
