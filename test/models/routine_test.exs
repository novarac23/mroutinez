defmodule Mroutinez.RoutineTest do
  use Mroutinez.ModelCase

  alias Mroutinez.Routine

  @valid_attrs %{content: "Do 5 squats and drink 20oz of water", stars: 42, title: "Space Shooter Routine", type: "morning", user_id: 2}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Routine.changeset(%Routine{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Routine.changeset(%Routine{}, @invalid_attrs)
    refute changeset.valid?
  end
  
  test "stars are not required" do
    changset = Routine.changeset(%Routine{}, Map.delete(@valid_attrs, :stars))

    assert changset.valid?
  end

  test "title must be at least 5 characters long" do
    attrs = %{@valid_attrs | title: "MM"}

    assert {:title, {"should be at least %{count} character(s)", [count: 3]}} in errors_on(%Routine{}, attrs)
  end
end
