defmodule QualitasWeb.AuthController do
  use QualitasWeb, :controller

  def signup(conn, _params) do
    changeset = Qualitas.CRM.build_user()
    render(conn, "signup.html", changeset: changeset,
    layout: {QualitasWeb.LayoutView, "user.html"})
  end

  def create(conn, %{"auth" => auth_params}) do
    case Qualitas.CRM.create_user(auth_params) do
      {:ok, user} ->
        conn
        |> assign(:current_user, user)
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> put_flash(:info, "Registration successful")
        |> redirect(to: Routes.page_path(conn, :policies))
      {:error, changeset} ->
        conn
        |> render(:signup, changeset: changeset)
    end
  end

end
