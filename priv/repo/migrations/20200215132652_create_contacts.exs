defmodule ElonPay.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add(:email, :string, null: false)

      timestamps()
    end

    alter table(:customers) do
      add(:contact_id, references(:contacts))
    end

    alter table(:companies) do
      add(:contact_id, references(:contacts))
    end

    alter table(:invoices) do
      add(:receiver_id, references(:contacts))
    end
  end
end
