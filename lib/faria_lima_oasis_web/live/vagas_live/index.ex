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
        query={FariaLimaOasis.Vagas.Vaga |> Ash.Query.load(:areas)}
        page_size={[default: 25, options: [10, 25, 50, 100]]}
        click={fn vaga -> JS.navigate(~p"/vagas/#{vaga.id}") end}
      >
        <:col :let={vaga} field="title" search sort>{vaga.title}</:col>
        <:col :let={vaga} field="vagas" sort>
          {Enum.map(vaga.areas, & &1.acronym) |> Enum.join(", ")}
        </:col>
        <:col :let={vaga} field="inserted_at" sort>{vaga.inserted_at}</:col>
      </Cinder.collection>
    </Layouts.app>
    """
  end
end
