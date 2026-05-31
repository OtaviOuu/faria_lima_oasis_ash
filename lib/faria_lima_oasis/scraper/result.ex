defmodule FariaLimaOasis.Scraper.Result do
  use Ash.Resource,
    otp_app: :faria_lima_oasis,
    domain: FariaLimaOasis.Scraper,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "results"
    repo FariaLimaOasis.Repo
  end

  actions do
    defaults [:read, :update, :destroy]
    default_accept [:title, :text_content, :pdf_url, :type, :empresa_id]

    create :create do
      accept [:title, :text_content, :pdf_url, :type, :empresa_id]

      argument :areas, {:array, :uuid} do
        allow_nil? true
      end

      change manage_relationship(:areas, type: :append_and_remove)
    end

    update :approve do
      require_atomic? false
      transaction? true
      accept []
      change set_attribute(:status, :approved)
      change FariaLimaOasis.Scraper.Changes.ApproveResult
    end

    update :reject do
      accept []
      change set_attribute(:status, :rejected)
    end

    action :scrape_fearp, {:array, :map} do
      run FariaLimaOasis.Scraper.Actions.ScrapeFeaRp
    end
  end

  preparations do
    prepare build(load: [:areas])
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string do
      public? true
      allow_nil? false
    end

    attribute :text_content, :string do
      public? true
      allow_nil? false
    end

    attribute :pdf_url, :string do
      public? true
      allow_nil? false
    end

    attribute :type, :string do
      public? true
      allow_nil? false
    end

    attribute :status, :atom do
      default :pending
      public? true
      allow_nil? false
      constraints one_of: [:pending, :approved, :rejected]
    end

    timestamps()
  end

  relationships do
    many_to_many :areas, FariaLimaOasis.Vagas.Area do
      through FariaLimaOasis.Scraper.ResultArea
      source_attribute_on_join_resource :result_id
      destination_attribute_on_join_resource :area_id
    end

    belongs_to :empresa, FariaLimaOasis.Vagas.Empresa do
      allow_nil? true
      destination_attribute :id
      source_attribute :empresa_id
    end
  end

  calculations do
    calculate :inserted_at_humanized,
              :string,
              expr(fragment("to_char(?, 'DD/MM/YYYY')", inserted_at))
  end
end
