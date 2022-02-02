defmodule CleaningHub.Account.Encryption do

  def hash_password(password), do: Bcrypt.Base.hash_password(password, Bcrypt.Base.gen_salt(12, true))
  #def dummy_check_password(), do: Argon2.no_user_verify()
  #def validate_password(password, hash), do: Argon2.verify_pass(password, hash)

end
