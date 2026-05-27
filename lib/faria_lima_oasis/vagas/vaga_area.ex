defmodule FariaLimaOasis.Vagas.VagaArea do
  use Ash.Resource,
    otp_app: :faria_lima_oasis,
    domain: FariaLimaOasis.Vagas,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "vaga_areas"
    repo FariaLimaOasis.Repo
  end

  actions do
    defaults [:read, :update, :destroy, :create]
    default_accept [:vaga_id, :area_id]
  end

  relationships do
    belongs_to :vaga, FariaLimaOasis.Vagas.Vaga
    belongs_to :area, FariaLimaOasis.Vagas.Area
  end
end
