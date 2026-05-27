defmodule FariaLimaOasisWeb.VagasLive.New do
  use FariaLimaOasisWeb, :live_view

  def mount(_params, _session, socket) do
    socket
    |> assign_new_vaga_form()
    |> ok()
  end

  def assign_new_vaga_form(socket) do
    form = FariaLimaOasis.Vagas.form_to_create_vaga() |> to_form()
    areas_options = FariaLimaOasis.Vagas.list_areas!() |> Enum.map(&{&1.name, &1.id})

    socket
    |> assign(:vaga_form, form)
    |> assign(:areas_options, areas_options)
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <.form for={@vaga_form} phx-submit="create_vaga">
        <.input field={@vaga_form[:title]} label="Título" />
        <.input field={@vaga_form[:text_content]} label="Conteúdo" />
        <.input field={@vaga_form[:pdf_url]} label="URL do PDF" />
        <.input
          field={@vaga_form[:areas]}
          type="select"
          multiple
          options={@areas_options}
          label="Áreas"
        />
        <.button>Criar Vaga</.button>
      </.form>
    </Layouts.app>
    """
  end

  def handle_event("create_vaga", %{"form" => vaga_attrs}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.vaga_form, params: vaga_attrs) do
      {:ok, _vaga} ->
        socket
        |> assign_new_vaga_form()
        |> put_flash(:info, "Vaga criada com sucesso!")
        |> noreply()

      {:error, form} ->
        socket
        |> assign(:vaga_form, form)
        |> put_flash(:error, "Erro ao criar vaga. Verifique os erros abaixo.")
        |> noreply()
    end
  end
end
