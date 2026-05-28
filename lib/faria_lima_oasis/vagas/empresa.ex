defmodule FariaLimaOasis.Vagas.Empresa do
  use Ash.Resource,
    otp_app: :faria_lima_oasis,
    domain: FariaLimaOasis.Vagas,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAdmin.Resource]

  admin do
    label_field :name
  end

  postgres do
    table "empresas"
    repo FariaLimaOasis.Repo
  end

  actions do
    defaults [:read, :create, :update, :destroy]
    default_accept [:name, :logo_url]
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      public? true
      allow_nil? false
    end

    attribute :logo_url, :string do
      public? true
      allow_nil? true
    end

    timestamps()
  end

  relationships do
    has_many :vagas, FariaLimaOasis.Vagas.Vaga do
      destination_attribute :empresa_id
      source_attribute :id
    end
  end
end
