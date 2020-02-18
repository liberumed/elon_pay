defmodule ElonPay.Repo.Migrations.CreateInvoicesLocations do
  use Ecto.Migration

  def change do
    create table(:invoices_locations) do
      add(:invoice_id, references(:invoices), null: false)
      add(:location_id, references(:locations), null: false)

      timestamps()
    end
  end
end
