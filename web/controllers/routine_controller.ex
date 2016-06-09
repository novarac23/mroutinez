defmodule Mroutinez.RoutineController do
  use Mroutinez.Web, :controller
  
  alias Mroutinez.Routine
  
  plug :scrub_params, "routine" when action in [:create, :update]
  plug :check_for_logged_out
  
  def index(conn, _params) do
    routines = Routine |> Repo.all |> Repo.preload([:user])
    render(conn, "index.html", routines: routines)
  end

  def new(conn, _params) do
    changeset = Routine.changeset(%Routine{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"routine" => routine_params}) do
    user_id = get_current_user(conn)
    routine_params = Map.put(routine_params, "user_id", user_id)
    changeset = Routine.changeset(%Routine{}, routine_params)
    
    case Repo.insert(changeset) do
      {:ok, _routine} ->
        conn
        |> put_flash(:info, "WOOT WOOT! Just shared a habit :)")
        |> redirect(to: routine_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    routine = Routine |> Repo.get!(id) |> Repo.preload([:user]) 
    render(conn, "show.html", routine: routine)
  end

  def edit(conn, %{"id" => id}) do
    routine = Repo.get!(Routine, id)
    changeset = Routine.changeset(routine)
    render(conn, "edit.html", routine: routine, changeset: changeset)
  end

  def update(conn, %{"id" => id, "routine" => routine_params}) do
    routine = Repo.get!(Routine, id)
    changeset = Routine.changeset(routine, routine_params)
    
    case Repo.update(changeset) do
      {:ok, _routine} ->
        conn
        |> put_flash(:info, "Just updated your routine")
        |> redirect(to: routine_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", routine: routine, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    routine = Repo.get!(Routine, id)
    Repo.delete!(routine)

    conn
    |> put_flash(:info, "Deleted a routine!")
    |> redirect(to: routine_path(conn, :index))
  end

  defp check_for_logged_out(conn, _) do
    if !get_session(conn, :current_user) do
      redirect conn, to: "/registrations/new"
    end
    conn
  end

  defp get_current_user(conn) do
    get_session(conn, :current_user)
  end
end
