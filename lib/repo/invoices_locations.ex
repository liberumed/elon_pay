defmodule ElonPay.Repo.InvoicesLocations do
  use Ecto.Schema

  alias Ecto.{Changeset, Schema}
  alias ElonPay.Repo.{Invoice, Location}

  @required_fields ~w(invoice_id location_id)a

  @type t :: %__MODULE__{
          invoice_id: integer,
          invoice: Schema.belongs_to(Invoice.t()),
          location_id: integer,
          location: Schema.belongs_to(Location.t())
        }

  @primary_key false
  schema "invoices_locations" do
    belongs_to(:invoice, Invoice)
    belongs_to(:location, Location)

    timestamps()
  end

  @spec changeset(t() | nil, map()) :: Changeset.t()
  def changeset(struct, params \\ %{}) do
    (struct || %__MODULE__{})
    |> Changeset.cast(params, @required_fields)
    |> Changeset.validate_required(@required_fields)
  end
end
