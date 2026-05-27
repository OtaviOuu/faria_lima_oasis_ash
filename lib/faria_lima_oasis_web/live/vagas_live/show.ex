defmodule FariaLimaOasisWeb.VagasLive.Show do
  use FariaLimaOasisWeb, :live_view

  on_mount {FariaLimaOasisWeb.LiveUserAuth, :live_user_optional}

  def mount(%{"vaga_id" => vaga_id}, _session, socket) do
    socket
    |> assign_vaga(vaga_id)
    |> ok()
  end

  def assign_vaga(socket, vaga_id) do
    vaga = FariaLimaOasis.Vagas.get_vaga!(vaga_id, load: [:areas])

    socket
    |> assign(:vaga, vaga)
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <.header>
        header
      </.header>
    </Layouts.app>
    """
  end
end
