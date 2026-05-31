defmodule FariaLimaOasis.Scraper do
  use Ash.Domain,
    otp_app: :faria_lima_oasis,
    extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource FariaLimaOasis.Scraper.Result
    resource FariaLimaOasis.Scraper.ResultArea
  end
end
