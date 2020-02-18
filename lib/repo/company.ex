defmodule ElonPay.Repo.Company do
  use Ecto.Schema

  alias Ecto.{Changeset, Schema}
  alias ElonPay.Repo.{Customer, Contact}

  @required_fields ~w(name customer_id contact_id)a

  @type t :: %__MODULE__{
          id: integer,
          name: String.t(),
          customer_id: integer,
          customer: Schema.belongs_to(Customer.t()),
          contact_id: integer,
          contact: Schema.belongs_to(Contact.t())
        }
  schema "companies" do
    field(:name, :string)
    belongs_to(:customer, Customer, foreign_key: :customer_id)
    belongs_to(:contact, Contact, foreign_key: :contact_id)

    timestamps()
  end

  @spec changeset(t() | nil, map()) :: Changeset.t()
  def changeset(company, params \\ %{}) do
    (company || %__MODULE__{})
    |> Changeset.cast(params, @required_fields)
    |> Changeset.validate_required(@required_fields)
  end
end
