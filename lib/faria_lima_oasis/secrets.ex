defmodule FariaLimaOasis.Secrets do
  use AshAuthentication.Secret

  def secret_for(
        [:authentication, :tokens, :signing_secret],
        FariaLimaOasis.Accounts.User,
        _opts,
        _context
      ) do
    Application.fetch_env(:faria_lima_oasis, :token_signing_secret)
  end
end
