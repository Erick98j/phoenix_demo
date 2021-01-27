defmodule Qualitas.CRM do

  def build_user(params \\ %{}) do
    %Qualitas.User{}
    |> Qualitas.User.changeset(params)
  end

  def create_user(params) do
    params
    |> build_user
    |> Qualitas.Repo.insert
  end

  def get_user_by_email(email), do: Qualitas.Repo.get_by(Qualitas.User, email: email)

  def get_user_by_credentials(%{"email" => email, "password" => pass} ) do
  user = get_user_by_email(email)

    cond do
      user && Comeonin.Bcrypt.checkpw(pass, user.password) -> user
      true -> :error
    end

  end
  def get_user(id), do: Qualitas.Repo.get(Qualitas.User, id)

end
