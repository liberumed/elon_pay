defmodule ElonPay.Repo.Migrations.CreateInvoices do
  use Ecto.Migration

  def change do
    create table(:invoices) do
      add(:name, :string, null: false)

      timestamps()
    end
  end
end
