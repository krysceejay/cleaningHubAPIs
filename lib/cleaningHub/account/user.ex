defmodule CleaningHub.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias CleaningHub.Account.Encryption

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string
    field :phone_number, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :phone_number, :password])
    |> validate_required([:first_name, :last_name, :email, :phone_number, :password])
    |> unique_constraint(:email)
  end

  def create_changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :phone_number, :password])
    |> validate_required([:first_name, :last_name, :email, :phone_number, :password])
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:password, min: 6, max: 100)
    |> unique_constraint(:email)
    |> encrypt_user_password
  end

  defp encrypt_user_password(changeset) do
    case fetch_field!(changeset, :password) do
      nil -> changeset
      password ->  encrypted_password = Encryption.hash_password(password)
                  put_change(changeset, :password, encrypted_password)
    end
  end

end
