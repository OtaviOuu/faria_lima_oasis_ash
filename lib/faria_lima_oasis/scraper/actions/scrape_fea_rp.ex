defmodule FariaLimaOasis.Scraper.Actions.ScrapeFeaRp do
  use Ash.Resource.Actions.Implementation
  require Logger
  @domain "https://www.fearp.usp.br"
  @main_url @domain <> "/estagio.html"
  def run(_input, _opts, _context) do
    with {:ok, html_tree} <- get_html_tree(@main_url) do
      vagas =
        html_tree
        |> get_vagas_hrefs()
        |> Enum.map(&parse_vaga/1)
        |> Ash.bulk_create!(FariaLimaOasis.Scraper.Result, :create,
          return_records?: true,
          authorize?: false,
          stop_on_error?: false
        )

      {:ok, vagas}
    else
      _ -> {:ok, []}
    end
  end

  def parse_vaga(href) do
    title = parse_title_from_href(href)

    %{
      pdf_url: @domain <> href,
      title: title,
      text_content: "tem n fí",
      type: "estagio",
      areas: [],
      empresa_id: nil
    }
  end

  defp parse_title_from_href(href) do
    href
    |> String.split("/")
    |> List.last()
    |> String.replace("_", " ")
    |> String.replace(".pdf", "")
  end

  def get_vagas_hrefs(html_tree) do
    html_tree
    |> Floki.find("a[href*='/images/estagio/Vagas']")
    |> Floki.attribute("href")
    |> dbg
  end

  defp get_html_tree(url) do
    with {:ok, response} <- Req.get(url),
         {:ok, html_tree} <- Floki.parse_document(response.body) do
      {:ok, html_tree}
    else
      _ -> :error
    end
  end
end
