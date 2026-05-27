defmodule FariaLimaOasis.Vagas.Area do
  use Ash.Resource,
    otp_app: :faria_lima_oasis,
    domain: FariaLimaOasis.Vagas,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "areas"
    repo FariaLimaOasis.Repo
  end

  actions do
    defaults [:read, :create, :update, :destroy]
    default_accept [:name, :acronym]
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string
    attribute :acronym, :string

    timestamps()
  end
end
