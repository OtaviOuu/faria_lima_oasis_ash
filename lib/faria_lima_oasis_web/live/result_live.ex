defmodule FariaLimaOasisWeb.ResultLive do
  use FariaLimaOasisWeb, :live_view

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <Cinder.collection resource={FariaLimaOasis.Scraper.Result} selectable page_size={[default: 10]}>
        <:col :let={result} field="title" search filter sort>{result.title}</:col>
        <:col :let={result} field="status" sort>{result.status}</:col>

        <:col :let={result} field="pdf_url">
          <a
            href={result.pdf_url}
            class="text-blue-500 hover:underline"
            target="_blank"
            rel="noopener noreferrer"
          >
            View PDF
          </a>
        </:col>
        <:bulk_action action={:approve} label="Approve ({count})" variant={:primary} />
        <:bulk_action action={:reject} label="Reject ({count})" variant={:danger} />
      </Cinder.collection>
    </Layouts.app>
    """
  end
end
