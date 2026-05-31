defmodule FariaLimaOasis.Scraper.ResultArea do
  use Ash.Resource,
    otp_app: :faria_lima_oasis,
    domain: FariaLimaOasis.Scraper,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "result_areas"
    repo FariaLimaOasis.Repo
  end

  resource do
    require_primary_key? false
  end

  actions do
    defaults [:read, :update, :destroy, :create]
    default_accept [:result_id, :area_id]
  end

  relationships do
    belongs_to :result, FariaLimaOasis.Scraper.Result
    belongs_to :area, FariaLimaOasis.Vagas.Area
  end
end
