defmodule FariaLimaOasisWeb.VagasLive.Index do
  use FariaLimaOasisWeb, :live_view

  def mount(_params, _session, socket) do
    socket
    |> ok()
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <Cinder.collection
        query={FariaLimaOasis.Vagas.Vaga |> Ash.Query.load(:areas)}
        page_size={[default: 25, options: [10, 25, 50, 100]]}
      >
        <:col :let={vaga} field="title" search sort search>{vaga.title}</:col>
        <:col :let={vaga} field="vagas" sort>
          {Enum.map(vaga.areas, & &1.acronym) |> Enum.join(", ")}
        </:col>
        <:col :let={vaga} field="insert_at" sort>{vaga.inserted_at}</:col>
      </Cinder.collection>
    </Layouts.app>
    """
  end
end
