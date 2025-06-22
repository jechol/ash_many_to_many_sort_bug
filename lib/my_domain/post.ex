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

  actions do
    defaults [:read, :destroy]

    create :create do
      accept :*
      argument :tags, {:array, :string}, allow_nil?: false

      change &manage_tags/2
    end

    update :update do
      require_atomic? false

      accept :*
      argument :tags, {:array, :string}, allow_nil?: false

      change &manage_tags/2
    end
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

  defp manage_tags(cs, _ctx) do
    tags = cs |> Ash.Changeset.get_argument(:tags)

    post_tags =
      tags
      |> Enum.with_index(1)
      |> Enum.map(fn {tag, index} -> %{tag_id: tag, position: index} end)

    cs
    |> Ash.Changeset.manage_relationship(post_tags, :post_tags, type: :direct_control)
  end
end
