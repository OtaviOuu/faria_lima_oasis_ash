defmodule FariaLimaOasis.Vagas.Vaga do
  use Ash.Resource,
    otp_app: :faria_lima_oasis,
    domain: FariaLimaOasis.Vagas,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAdmin.Resource]

  admin do
    label_field :title
  end

  postgres do
    table "vagas"
    repo FariaLimaOasis.Repo
  end

  actions do
    defaults [:read, :update, :destroy]
    default_accept [:title, :text_content, :pdf_url]

    create :create do
      accept [:title, :text_content, :pdf_url]

      argument :areas, {:array, :uuid} do
        default []
      end

      change manage_relationship(:areas, type: :append_and_remove)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string
    attribute :text_content, :string
    attribute :pdf_url, :string

    timestamps()
  end

  relationships do
    many_to_many :areas, FariaLimaOasis.Vagas.Area do
      through FariaLimaOasis.Vagas.VagaArea
      source_attribute_on_join_resource :vaga_id
      destination_attribute_on_join_resource :area_id
    end
  end
end
