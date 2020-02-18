defmodule ElonPay.Repo.Contact do
  use Ecto.Schema

  alias Ecto.Changeset

  @required_fields ~w(email)a

  @type t :: %__MODULE__{
          id: integer,
          email: String.t()
        }
  schema "contacts" do
    field(:email, :string)

    timestamps()
  end

  @spec changeset(t() | nil, map()) :: Changeset.t()
  def changeset(location, params \\ %{}) do
    (location || %__MODULE__{})
    |> Changeset.cast(params, @required_fields)
    |> Changeset.validate_required(@required_fields)
  end
end
