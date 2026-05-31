defmodule FariaLimaOasisWeb.ResultLive do
  use FariaLimaOasisWeb, :live_view

  on_mount {FariaLimaOasisWeb.LiveUserAuth, :live_admin_required}

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <Cinder.collection
        query={FariaLimaOasis.Scraper.Result |> Ash.Query.load([:inserted_at_humanized])}
        selectable
        page_size={[default: 10]}
      >
        <:col :let={result} field="title" search sort>{result.title}</:col>
        <:col :let={result} field="status" sort>{result.status}</:col>
        <:col :let={result} field="inserted_at_humanized" label="data coleta">
          {result.inserted_at_humanized}
        </:col>

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

        <:controls :let={controls}>
          <div class="flex flex-col gap-3">
            <div class="w-full">
              <Cinder.Controls.render_search
                search={controls.search}
                theme={controls.theme}
                target={controls.target}
              />
            </div>

            <div class="flex flex-wrap gap-2">
              <Cinder.Controls.render_filter
                :for={{_name, filter} <- controls.filters}
                filter={filter}
                theme={controls.theme}
                target={controls.target}
              />
            </div>
          </div>
        </:controls>
      </Cinder.collection>
    </Layouts.app>
    """
  end
end
