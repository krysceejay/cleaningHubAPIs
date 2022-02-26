defmodule CleaningHub.AccountFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CleaningHub.Account` context.
  """

  # @doc """
  # Generate a unique user email.
  # """
  # def unique_user_email, do: "someemail#{System.unique_integer([:positive])}@gmail.com"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "someemail@gmail.com",
        first_name: "some first_name",
        last_name: "some last_name",
        password: "some password",
        phone_number: "some phone_number"
      })
      |> CleaningHub.Account.create_user()

    user
  end
end
