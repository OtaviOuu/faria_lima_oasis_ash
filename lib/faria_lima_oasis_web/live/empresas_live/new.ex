defmodule FariaLimaOasisWeb.EmpresasLive.New do
  use FariaLimaOasisWeb, :live_view

  on_mount {FariaLimaOasisWeb.LiveUserAuth, :live_admin_required}

  def mount(_params, _session, socket) do
    socket
    |> assign_new_empresa_form()
    |> ok()
  end

  def assign_new_empresa_form(socket) do
    form =
      FariaLimaOasis.Vagas.form_to_create_empresa(actor: socket.assigns.current_user) |> to_form()

    socket
    |> assign(:empresa_form, form)
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <.header>
        Criar nova empresa
      </.header>
      <.form for={@empresa_form} phx-submit="create_empresa">
        <.input field={@empresa_form[:name]} label="Nome" />
        <.input field={@empresa_form[:logo_url]} label="URL do Logo" />

        <.button class="btn btn-primary">
          Criar Empresa
        </.button>
      </.form>
    </Layouts.app>
    """
  end

  def handle_event("create_empresa", %{"form" => empresa_attrs}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.empresa_form, params: empresa_attrs) do
      {:ok, _empresa} ->
        socket
        |> put_flash(:info, "Empresa criada com sucesso!")
        |> push_navigate(to: ~p"/adm")
        |> noreply()

      {:error, form} ->
        socket
        |> assign(:empresa_form, form)
        |> put_flash(:error, "Erro ao criar empresa. Verifique os dados e tente novamente.")
        |> noreply()
    end
  end
end
