defmodule MyDomain.Tag do
  use Ash.Resource,
    otp_app: :ai_personal_chef,
    domain: MyDomain,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "tags"
    repo AiPersonalChef.Repo
  end

  attributes do
    attribute :id, :string, allow_nil?: false, primary_key?: true
  end

  relationships do
    has_many :post_tags, MyDomain.PostTag
  end
end
