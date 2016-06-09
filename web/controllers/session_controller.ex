defmodule Mroutinez.SessionController do
  use Mroutinez.Web, :controller
  alias Mroutinez.User
  plug :check_for_logged_in when action in [:new, :create]
  
  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
    case Mroutinez.Session.login(session_params, Mroutinez.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "WOHOOOO logged in mate!")
        |> redirect(to: routine_path(conn, :index))
      :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render "new.html"
    end
  end

  def delete(conn, _) do
    conn
    |> clear_session
    |> redirect(to: session_path(conn, :new))
  end

  defp check_for_logged_in(conn, _) do
    if get_session(conn, :current_user) do
      redirect conn, to: "/routines"
    end
    conn
  end
end
