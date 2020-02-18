defmodule ElonPay.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add(:name, :string, null: false)
      add(:customer_id, references(:customers), null: false)

      timestamps()
    end
  end
end
