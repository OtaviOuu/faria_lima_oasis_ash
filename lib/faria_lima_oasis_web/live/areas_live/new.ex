defmodule FariaLimaOasisWeb.AreasLive.New do
  use FariaLimaOasisWeb, :live_view

  on_mount {FariaLimaOasisWeb.LiveUserAuth, :live_admin_required}

  def mount(_params, _session, socket) do
    socket
    |> assign_new_area_form()
    |> ok()
  end

  def assign_new_area_form(socket) do
    form =
      FariaLimaOasis.Vagas.form_to_create_area(actor: socket.assigns.current_user) |> to_form()

    socket
    |> assign(:area_form, form)
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <.header>
        Criar nova area
      </.header>
      <.form for={@area_form} phx-submit="create_area">
        <.input field={@area_form[:name]} label="Nome" />
        <.input field={@area_form[:acronym]} label="Sigla" />
        <.button class="btn btn-primary">
          Criar Área
        </.button>
      </.form>
    </Layouts.app>
    """
  end

  def handle_event("create_area", %{"form" => area_attrs}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.area_form, params: area_attrs) do
      {:ok, _area} ->
        socket
        |> put_flash(:info, "Área criada com sucesso!")
        |> push_navigate(to: ~p"/adm")

      {:error, form} ->
        socket
        |> assign(:area_form, form)
        |> put_flash(:error, "Erro ao criar área. Verifique os dados e tente novamente.")
        |> noreply()
    end
  end
end
