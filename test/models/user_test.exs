defmodule Mroutinez.UserTest do
  use Mroutinez.ModelCase

  alias Mroutinez.User

  @valid_attrs %{email: "nik@nik.com", name: "some content", password: "abcdefg"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "email has to have a proper format" do
    attrs = %{@valid_attrs | email: "nik"}
    changeset = User.changeset(%User{}, attrs)
    refute changeset.valid?
  end

  test "name must be at least 2 chars long" do
    attrs = %{@valid_attrs | name: "n"}

    assert {:name, {"should be at least %{count} character(s)", [count: 2]}} in errors_on(%User{}, attrs)
  end

  test "name must be at least 2 chars long" do
    attrs = %{@valid_attrs | password: "abcd"}

    assert {:password, {"should be at least %{count} character(s)", [count: 5]}} in errors_on(%User{}, attrs)
  end
end
