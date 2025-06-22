defmodule MyDomain.Post do
  use Ash.Resource,
    otp_app: :ai_personal_chef,
    domain: MyDomain,
    data_layer: AshPostgres.DataLayer

  require Ash.Sort

  postgres do
    table "posts"
    repo AiPersonalChef.Repo
  end

  attributes do
    integer_primary_key :id
    attribute :text, :string
  end

  relationships do
    has_many :post_tags, MyDomain.PostTag

    many_to_many :tags, MyDomain.Tag do
      public? true
      through MyDomain.PostTag
      join_relationship :post_tags
      sort [Ash.Sort.expr_sort(post_tags.position)]
    end
  end
end
