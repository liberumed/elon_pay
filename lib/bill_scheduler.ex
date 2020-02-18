defmodule ElonPay.BillScheduler do
  use GenServer

  import Ecto.Query

  alias ElonPay.Repo
  alias ElonPay.Repo.{Company, Contact, Customer, Location, Invoice, InvoicesLocations}

  def start_link(_args) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    current_date = DateTime.utc_now()
    IO.puts("INIT DAY: " <> DateTime.to_string(current_date))
    schedule_monthly_run(current_date)
    {:ok, state}
  end

  def handle_info(:bill, state) do
    current_date = DateTime.utc_now()
    IO.puts("BILLING DAY: " <> DateTime.to_string(current_date))
    send_invoices()
    schedule_monthly_run(current_date)
    {:noreply, state}
  end

  defp schedule_monthly_run(%{day: day, month: month, year: year}) do
    days_in_month = :calendar.last_day_of_the_month(year, month)
    days_to_next_bill = days_in_month - day + 1
    Process.send_after(self(), :bill, days_to_next_bill * 24 * 60 * 60 * 1000)
  end

  def send_invoices() do
    Invoice
    |> preload([:receiver, :locations])
    |> Repo.all()
    |> Enum.each(fn invoice ->
        items =
          Enum.map(invoice.locations, fn location ->
            %{
              text: "#{location.name} - #{location.cost}",
              cost: location.cost
            }
          end)

        item_string = Enum.map_join(items, "\n", &(&1.text))
        total_string = items |> Enum.map(&(&1.cost)) |> Enum.sum()

        IO.puts("Sending invoice: [#{invoice.name}] to #{invoice.receiver.email} with items:")
        IO.puts(item_string)
        IO.puts("____________________")
        IO.puts("Total: #{total_string}\n")
    end)

  end
end
