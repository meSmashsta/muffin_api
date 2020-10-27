defmodule MuffinApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :username, :string
      add :email, :string
      add :first_name, :string
      add :middle_name, :string
      add :last_name, :string
      add :date_of_birth, :date
      add :password_hash, :string
      add :profile_picture, :string

      timestamps()
    end

    create unique_index(:users, [:username])
    create unique_index(:users, [:email])
  end
end
