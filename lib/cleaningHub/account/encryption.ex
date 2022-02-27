defmodule CleaningHub.Account.Encryption do

  def hash_password(password), do: Bcrypt.Base.hash_password(password, Bcrypt.Base.gen_salt(12, true))
  def validate_password(password, hash), do: Bcrypt.verify_pass(password, hash)

end
