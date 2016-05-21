defmodule Mroutinez.Routine do
  use Mroutinez.Web, :model

  schema "routines" do
    field :title, :string
    field :content, :string
    field :type, :string
    field :stars, :integer

    timestamps
  end

  @required_fields ~w(title content type)
  @optional_fields ~w(stars)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:title, min: 5)
  end
end
