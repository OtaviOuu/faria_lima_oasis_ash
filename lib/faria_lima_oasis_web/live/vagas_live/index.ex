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
        query={FariaLimaOasis.Vagas.Vaga |> Ash.Query.load([:areas, :inserted_at_humanized])}
        page_size={[default: 25, options: [10, 25, 50, 100]]}
        click={fn vaga -> JS.navigate(~p"/vagas/#{vaga.id}") end}
      >
        <:filter field="text_content" />

        <:col :let={vaga} field="title" search sort>{vaga.title}</:col>
        <:col :let={vaga} field="vagas" sort label="Areas">
          <div class="flex flex-wrap gap-2">
            <span :for={area <- vaga.areas} class="badge">
              {area.acronym}
            </span>
          </div>
        </:col>
        <:col :let={vaga} label="Criação" field="inserted_at_humanized" sort>
          {vaga.inserted_at_humanized}
        </:col>
      </Cinder.collection>
    </Layouts.app>
    """
  end
end
