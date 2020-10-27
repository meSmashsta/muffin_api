defmodule MuffinApiWeb.UserView do
  use MuffinApiWeb, :view
  alias MuffinApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      first_name: user.first_name,
      middle_name: user.middle_name,
      last_name: user.last_name,
      date_of_birth: user.date_of_birth,
      profile_picture: user.profile_picture}
  end

  def render("sign_in.json", %{user: user, token: token}) do
    %{
      data: %{
        user: %{
          id: user.id,
          token: token
        }
      }
    }
  end
end
