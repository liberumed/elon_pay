defmodule ElonPay.Repo.Customer do
  use Ecto.Schema

  alias Ecto.Changeset
  alias ElonPay.Repo.Contact

  @required_fields ~w(name contact_id)a

  @type t :: %__MODULE__{
          id: integer,
          name: String.t(),
          contact_id: integer,
          contact: Schema.belongs_to(Contact.t())
        }
  schema "customers" do
    field(:name, :string)
    belongs_to(:contact, Contact, foreign_key: :contact_id)

    timestamps()
  end

  @spec changeset(t() | nil, map()) :: Changeset.t()
  def changeset(customer, params \\ %{}) do
    (customer || %__MODULE__{})
    |> Changeset.cast(params, @required_fields)
    |> Changeset.validate_required(@required_fields)
  end
end
