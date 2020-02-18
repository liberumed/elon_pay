defmodule ElonPay.Repo.Migrations.CreateCustomer do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add(:name, :string, null: false)

      timestamps()
    end
  end
end
