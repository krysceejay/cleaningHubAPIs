defmodule CleaningHub.AccountTest do
  use CleaningHub.DataCase

  alias CleaningHub.Account

  describe "users" do
    alias CleaningHub.Account.User

    import CleaningHub.AccountFixtures

    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, password: nil, phone_number: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "someemail@gmail.com", first_name: "some first_name", last_name: "some last_name", password: "some password", phone_number: "some phone_number"}

      assert {:ok, %User{} = user} = Account.create_user(valid_attrs)
      assert user.email == "someemail@gmail.com"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.phone_number == "some phone_number"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", password: "some updated password", phone_number: "some updated phone_number"}

      assert {:ok, %User{} = user} = Account.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.phone_number == "some updated phone_number"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end
end
