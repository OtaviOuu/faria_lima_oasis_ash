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
    defaults [:read, :update, :destroy]

    create :create do
      accept [:vaga_id, :area_id]

      change manage_relationship(:vaga, type: :append)
      change manage_relationship(:area, type: :append)
    end
  end

  relationships do
    belongs_to :vaga, FariaLimaOasis.Vagas.Vaga do
      destination_attribute :id
      source_attribute :vaga_id
    end

    belongs_to :area, FariaLimaOasis.Vagas.Area do
      destination_attribute :id
      source_attribute :area_id
    end
  end
end
