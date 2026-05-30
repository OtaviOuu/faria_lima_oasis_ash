defmodule FariaLimaOasisWeb.EmpresasLive.Index do
  use FariaLimaOasisWeb, :live_view

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <.header>
        Empresas
      </.header>

      <Cinder.collection
        resource={FariaLimaOasis.Vagas.Empresa}
        layout={:grid}
        grid_columns={1}
        click={fn empresa -> JS.navigate(~p"/empresas/#{empresa.id}") end}
      >
        <:col field="name" search sort />
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
        <:item :let={empresa}>
          <div class="stats shadow w-full">
            <div class="stat flex items-center">
              <div class="stat-figure order-1">
                <div class="avatar">
                  <div class="w-24 rounded-xl bg-base-200 flex items-center justify-center">
                    <img src={empresa.logo_url} alt={empresa.name} />
                  </div>
                </div>
              </div>

              <div class="order-2 ml-4">
                <div class="stat-title">Empresa</div>
                <div class="stat-value text-primary text-lg">
                  {empresa.name}
                </div>
              </div>
            </div>

            <div class="stat flex items-center">
              <div class="order-2 ml-4">
                <div class="stat-title">Vagas</div>
                <div class="stat-value text-secondary">
                  10
                </div>
                <div class="stat-desc">
                  Total cadastradas
                </div>
              </div>
            </div>
          </div>
        </:item>
      </Cinder.collection>
    </Layouts.app>
    """
  end
end
