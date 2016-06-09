defmodule Mroutinez.RegistrationController do
  use Mroutinez.Web, :controller
  alias Mroutinez.User
  plug :check_for_logged_in

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Mroutinez.Registration.create(changeset, Mroutinez.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Hell yes! You just signed up!!!")
        |> redirect(to: routine_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp check_for_logged_in(conn, _) do
    if get_session(conn, :current_user) do
      redirect conn, to: "/routines"
    end
    conn
  end
end
