defmodule Things.Todo do
  use Things.Web, :model

  schema "todos" do
    field :text, :string
    field :complete, :boolean, default: false

    timestamps
  end

  @required_fields ~w(text complete)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def sorted(query \\ __MODULE__) do
    from t in query, order_by: [desc: t.inserted_at]
  end

  def filtered(query \\ Todo, _)
  def filtered(query, "complete") do
    from t in query, where: t.complete == true
  end

  def filtered(query, "incomplete") do
    from t in query, where: t.complete == false
  end

  def filtered(query, _) do
    query
  end
end
