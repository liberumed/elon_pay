defmodule SeedCase1 do
  import Ecto.Query

  alias ElonPay.Repo
  alias ElonPay.Repo.{Company, Contact, Customer, Location, Invoice, InvoicesLocations}

  def run do
    customer = Repo.get_by!(Customer, name: "Elon Musk")

    companies =
      Company
      |> where(customer_id: ^customer.id)
      |> preload(:contact)
      |> Repo.all()

    Enum.each(companies, fn company ->
      locations =
        Location
        |> where(company_id: ^company.id)
        |> Repo.all()

      invoice =
      nil
      |> Invoice.changeset(
        %{
          name: "Invoice - " <> company.name,
          receiver_id: company.contact.id
        }
      )
      |> Repo.insert!()

      Enum.each(locations, fn location ->
        nil
        |> InvoicesLocations.changeset(
          %{
            invoice_id: invoice.id,
            location_id: location.id
          }
        )
        |> Repo.insert!()
      end)

    end)
  end

end

SeedCase1.run()
