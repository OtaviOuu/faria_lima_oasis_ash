defmodule FariaLimaOasis.Scraper.Changes.ApproveResult do
  use Ash.Resource.Change

  def change(changeset, _opts, _context) do
    Ash.Changeset.after_action(changeset, fn _changeset, result ->
      # MÉ
      attrs =
        result
        |> Map.take([:type, :title, :areas, :empresa_id, :pdf_url, :text_content])

      case FariaLimaOasis.Vagas.create_vaga(attrs, authorize?: false) do
        {:ok, vaga} ->
          {:ok, vaga}

        {:error, error} ->
          {:error, "Failed to create vaga"}
      end
    end)
  end
end
