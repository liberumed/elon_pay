defmodule Seeds do
  alias ElonPay.Repo
  alias ElonPay.Repo.{Company, Contact, Customer, Location}

  @data [
    %{
      customer: %{
        name: "Elon Musk"
      },
      customer_contact: %{
        email: "elon.mask@example.com"
      },
      companies: [
        %{
          company: %{
            name: "Space X"
          },
          contact: %{
            email: "space.x@example.com"
          },
          locations: [
            %{
              name: "Florida office",
              cost: 40_000
            },
            %{
              name: "SF office",
              cost: 30_000
            },
            %{
              name: "Hawaii office",
              cost: 30_000
            }
          ]
        },
        %{
          company: %{
            name: "Tesla"
          },
          contact: %{
            email: "tesla@example.com"
          },
          locations: [
            %{
              name: "Paolo Alto",
              cost: 100_000
            },
            %{
              name: "Detroit",
              cost: 100_000
            }
          ]
        },
        %{
          company: %{
            name: "SolarCity"
          },
          contact: %{
            email: "solar.city@example.com"
          },
          locations: [
            %{
              name: "San Mateo",
              cost: 300_000
            }
          ]
        }
      ]
    }
  ]

  def run do
    Enum.each(@data, fn customer_data ->
      customer_contact =
        nil
        |> Contact.changeset(customer_data.customer_contact)
        |> Repo.insert!()

      customer =
        nil
        |> Customer.changeset(Map.put(customer_data.customer, :contact_id, customer_contact.id))
        |> Repo.insert!()

      Enum.each(customer_data.companies, fn company_data ->
        company_contact =
          nil
          |> Contact.changeset(company_data.contact)
          |> Repo.insert!()

        company =
          nil
          |> Company.changeset(Map.merge(company_data.company, %{customer_id: customer.id, contact_id: company_contact.id}))
          |> Repo.insert!()

        Enum.each(company_data.locations, fn location ->
          nil
          |> Location.changeset(Map.put(location, :company_id, company.id))
          |> Repo.insert!()
        end)
      end)
    end)
  end

end

Seeds.run()
