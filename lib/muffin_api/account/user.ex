defmodule MuffinApi.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :date_of_birth, :date
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :middle_name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :profile_picture, :string
    field :username, :string
    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :first_name, :middle_name, :last_name, :date_of_birth, :password, :profile_picture])
    |> validate_required([:username, :email, :first_name, :last_name, :date_of_birth, :password])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(
    %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
  ) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset) do
    changeset
  end
end
