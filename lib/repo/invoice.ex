defmodule ElonPay.Repo.Invoice do
  use Ecto.Schema

  alias Ecto.{Changeset, Schema}
  alias ElonPay.Repo.{Contact, Location, InvoicesLocations}

  @required_fields ~w(name receiver_id)a

  @type t :: %__MODULE__{
          id: integer,
          name: String.t(),
          locations: Schema.many_to_many(Location.t()),
          receiver_id: integer,
          receiver: Schema.belongs_to(Contact.t())
        }
  schema "invoices" do
    field(:name, :string)
    many_to_many(:locations, Location, join_through: InvoicesLocations)
    belongs_to(:receiver, Contact, foreign_key: :receiver_id)

    timestamps()
  end

  @spec changeset(t() | nil, map()) :: Changeset.t()
  def changeset(location, params \\ %{}) do
    (location || %__MODULE__{})
    |> Changeset.cast(params, @required_fields)
    |> Changeset.validate_required(@required_fields)
  end
end
