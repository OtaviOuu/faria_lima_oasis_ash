defmodule FariaLimaOasis.Vagas.Area do
  use Ash.Resource,
    otp_app: :faria_lima_oasis,
    domain: FariaLimaOasis.Vagas,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAdmin.Resource]

  admin do
    label_field :name
  end

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

    attribute :name, :string do
      public? true
      allow_nil? false
    end

    attribute :acronym, :string do
      public? true
      allow_nil? false
    end

    timestamps()
  end

  relationships do
    many_to_many :vagas, FariaLimaOasis.Vagas.Vaga do
      through FariaLimaOasis.Vagas.VagaArea
      source_attribute_on_join_resource :area_id
      destination_attribute_on_join_resource :vaga_id
    end
  end
end
