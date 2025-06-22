defmodule MyDomain.PostTag do
  use Ash.Resource,
    otp_app: :ai_personal_chef,
    domain: MyDomain,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "post_tags"
    repo AiPersonalChef.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    attribute :position, :integer, public?: true
  end

  relationships do
    belongs_to :post, MyDomain.Post,
      allow_nil?: false,
      primary_key?: true,
      attribute_type: :integer,
      public?: true

    belongs_to :tag, MyDomain.Tag,
      allow_nil?: false,
      primary_key?: true,
      attribute_type: :string,
      public?: true
  end
end
