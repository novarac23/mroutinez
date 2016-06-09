defmodule Mroutinez.RegistrationTest do
  use Mroutinez.ModelCase
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  alias Mroutinez.User

  @valid_attrs %{email: "nik@nik.com", name: "some content", password: "abcdef"}
  @invalid_attrs %{}
end
