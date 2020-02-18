defmodule ElonPay.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add(:name, :string, null: false)
      add(:cost, :integer, default: 0)
      add(:company_id, references(:companies), null: false)

      timestamps()
    end
  end
end
