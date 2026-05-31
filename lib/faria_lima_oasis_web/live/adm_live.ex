defmodule FariaLimaOasisWeb.AdmLive do
  use FariaLimaOasisWeb, :live_view

  on_mount {FariaLimaOasisWeb.LiveUserAuth, :live_user_required}
  on_mount {FariaLimaOasisWeb.LiveUserAuth, :live_admin_required}

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <.header>
        Admin
        <:actions>
          <.link navigate={~p"/vagas/criar"} class="btn btn-primary">
            Criar vaga
          </.link>
          <.link navigate={~p"/areas/criar"} class="btn btn-primary">
            Criar Area
          </.link>
          <.link navigate={~p"/empresas/criar"} class="btn btn-primary">
            Criar Empresa
          </.link>
          <.link navigate={~p"/scraper/results"} class="btn btn-primary">
            Scraper Results
          </.link>
        </:actions>
      </.header>
    </Layouts.app>
    """
  end
end
