defmodule ElonPay.Repo.Location do
  use Ecto.Schema

  alias Ecto.{Changeset, Schema}
  alias ElonPay.Repo.Company

  @required_fields ~w(name company_id)a
  @optional_fields ~w(cost)a

  @type t :: %__MODULE__{
          id: integer,
          name: String.t(),
          cost: integer,
          company_id: integer,
          company: Schema.belongs_to(Company.t())
        }
  schema "locations" do
    field(:name, :string)
    field(:cost, :integer)
    belongs_to(:company, Company, foreign_key: :company_id)

    timestamps()
  end

  @spec changeset(t() | nil, map()) :: Changeset.t()
  def changeset(location, params \\ %{}) do
    (location || %__MODULE__{})
    |> Changeset.cast(params, @required_fields ++ @optional_fields)
    |> Changeset.validate_required(@required_fields)
  end
end
