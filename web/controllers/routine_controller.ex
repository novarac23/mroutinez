defmodule Mroutinez.RoutineController do
  use Mroutinez.Web, :controller
  
  alias Mroutinez.Routine
  
  plug :scrub_params, "routine" when action in [:create, :update]
  
  def index(conn, _params) do
    routines = Repo.all(Routine)
    render(conn, "index.html", routines: routines)
  end

  def new(conn, _params) do
    changeset = Routine.changeset(%Routine{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"routine" => routine_params}) do
    changeset = Routine.changeset(%Routine{}, routine_params)
    
    case Repo.insert(changeset) do
      {:ok, _routine} ->
        conn
        |> put_flash(:info, "WOOT WOOT! Just share a habit :)")
        |> redirect(to: routine_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    routine = Repo.get!(routine, id)
    render(conn, "show.html", routine: routine)
  end

  def edit(conn, %{"id" => id}) do
    routine = Repo.get!(routine, id)
    changeset = Routine.changeset(routine)
    render(conn, "edit.html", changeset: changeset)
  end

  def update(conn, %{"id" => id, "routine" => routine_params}) do
    routine = Repo.get!(routine, id)
    changeset = Routine.changeset(routine)

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
end
