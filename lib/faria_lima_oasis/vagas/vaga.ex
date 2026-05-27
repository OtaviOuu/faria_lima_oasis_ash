defmodule FariaLimaOasis.Vagas.Vaga do
  use Ash.Resource,
    otp_app: :faria_lima_oasis,
    domain: FariaLimaOasis.Vagas,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "vagas"
    repo FariaLimaOasis.Repo
  end

  actions do
    defaults [:read, :create, :update, :destroy]
    default_accept [:title, :text_content, :pdf_url]
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string
    attribute :text_content, :string
    attribute :pdf_url, :string

    timestamps()
  end
end
