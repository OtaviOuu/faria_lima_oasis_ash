defmodule FariaLimaOasisWeb.VagasLive.Index do
  use FariaLimaOasisWeb, :live_view

  on_mount {FariaLimaOasisWeb.LiveUserAuth, :live_user_optional}

  def mount(_params, _session, socket) do
    socket
    |> ok()
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <.header>
        <:actions>
          <.button
            :if={FariaLimaOasis.Vagas.can_create_vaga?(@current_user)}
            navigate={~p"/vagas/criar"}
          >
            Nova vaga
          </.button>
        </:actions>
      </.header>
      <Cinder.collection
        query={
          FariaLimaOasis.Vagas.Vaga |> Ash.Query.load([:areas, :inserted_at_humanized, :empresa])
        }
        page_size={[default: 10]}
        click={fn vaga -> JS.navigate(~p"/vagas/#{vaga.id}") end}
      >
        <:col :let={vaga} field="title" search sort>{vaga.title}</:col>
        <:col :let={vaga} field="type" sort filter={:multi_select}>{vaga.type}</:col>
        <:col :let={vaga} field="empresa.name" sort search>{vaga.empresa.name}</:col>

        <:col
          :let={vaga}
          field="areas"
          label="Areas"
          filter={[
            type: :multi_select,
            options:
              Enum.map(FariaLimaOasis.Vagas.list_areas!(), fn area ->
                {area.name, area.id}
              end)
          ]}
        >
          <div class="flex flex-row gap-1">
            <span :for={area <- vaga.areas} class="badge-sm badge">
              {area.acronym}
            </span>
          </div>
        </:col>
        <:col :let={vaga} label="Criação" field="inserted_at_humanized" sort>
          {vaga.inserted_at_humanized}
        </:col>
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
