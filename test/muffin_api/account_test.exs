defmodule MuffinApi.AccountTest do
  use MuffinApi.DataCase

  alias MuffinApi.Account

  describe "users" do
    alias MuffinApi.Account.User

    @valid_attrs %{date_of_birth: ~D[2010-04-17], email: "some email", first_name: "some first_name", last_name: "some last_name", middle_name: "some middle_name", password: "some password", profile_picture: "some profile_picture", username: "some username"}
    @update_attrs %{date_of_birth: ~D[2011-05-18], email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", middle_name: "some updated middle_name", password: "some updated password", profile_picture: "some updated profile_picture", username: "some updated username"}
    @invalid_attrs %{date_of_birth: nil, email: nil, first_name: nil, last_name: nil, password: nil, profile_picture: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()

      user
    end

    def user_without_password(attrs \\ %{}) do
      %{user_fixture(attrs) | password: nil}
    end

    test "list_users/0 returns all users" do
      user = user_without_password()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_without_password()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert user.date_of_birth == ~D[2010-04-17]
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.middle_name == "some middle_name"
      assert user.profile_picture == "some profile_picture"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Account.update_user(user, @update_attrs)
      assert user.date_of_birth == ~D[2011-05-18]
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.middle_name == "some updated middle_name"
      assert user.profile_picture == "some updated profile_picture"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_without_password()
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
