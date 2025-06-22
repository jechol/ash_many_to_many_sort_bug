defmodule MyDomain.PostTag do
  use Ash.Resource,
    otp_app: :ai_personal_chef,
    domain: MyDomain,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "post_tags"
    repo AiPersonalChef.Repo
  end

  attributes do
    attribute :position, :integer
  end

  relationships do
    belongs_to :post, MyDomain.Post,
      allow_nil?: false,
      primary_key?: true,
      attribute_type: :integer

    belongs_to :tag, MyDomain.Tag,
      allow_nil?: false,
      primary_key?: true,
      attribute_type: :string
  end
end
