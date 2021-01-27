defmodule QualitasWeb.SessionController do
  use QualitasWeb, :controller

  def login(conn, _params) do
    render(conn, "login.html",
    layout: {QualitasWeb.LayoutView, "user.html"})
  end

  def create(conn, %{"session" => session_params}) do
    case Qualitas.CRM.get_user_by_credentials(session_params) do
      :error ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("login.html",
        layout: {QualitasWeb.LayoutView, "user.html"})
      user ->
        conn
        |> assign(:current_user, user)
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> put_flash(:info, "Login successful")
        |> redirect(to: Routes.page_path(conn, :policies))
    end
  end

  def logout(conn, _) do
    clear_session(conn)
    |> put_flash(:info, "You have been logged out")
    |> redirect(to: Routes.session_path(conn, :login))
   end

end
