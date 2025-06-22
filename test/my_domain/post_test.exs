defmodule MyDomain.PostTest do
  use AiPersonalChef.DataCase

  alias MyDomain.{Post, Tag}

  setup do
    ["tag1", "tag2", "tag3", "tag4", "tag5", "tag6", "tag7", "tag8", "tag9", "tag10"]
    |> Enum.each(fn tag ->
      Ash.Changeset.for_create(Tag, :create, %{id: tag})
      |> Ash.create!()
    end)
  end

  describe "When no PostTag exists" do
    test "Post.tags are sorted" do
      post =
        Ash.Changeset.for_create(Post, :create,
          text: "post",
          tags: ["tag1", "tag3", "tag5", "tag4", "tag2"]
        )
        |> Ash.create!(load: [:post_tags, :tags])

      assert [
               %{position: 1, tag_id: "tag1"},
               %{position: 2, tag_id: "tag3"},
               %{position: 3, tag_id: "tag5"},
               %{position: 4, tag_id: "tag4"},
               %{position: 5, tag_id: "tag2"}
             ] = post.post_tags

      assert [%{id: "tag1"}, %{id: "tag3"}, %{id: "tag5"}, %{id: "tag4"}, %{id: "tag2"}] =
               post.tags
    end
  end

  describe "When PostTag exists" do
    setup do
      Ash.Changeset.for_create(Post, :create,
        text: "post",
        tags: ["tag1", "tag2", "tag3", "tag4", "tag5", "tag6", "tag7", "tag8", "tag9", "tag10"]
      )
      |> Ash.create!()

      :ok
    end

    test "Post.tags are sorted" do
      post =
        Ash.Changeset.for_create(Post, :create,
          text: "post",
          tags: ["tag1", "tag3", "tag5", "tag4", "tag2"]
        )
        |> Ash.create!(load: [:post_tags, :tags])

      assert [
               %{position: 1, tag_id: "tag1"},
               %{position: 2, tag_id: "tag3"},
               %{position: 3, tag_id: "tag5"},
               %{position: 4, tag_id: "tag4"},
               %{position: 5, tag_id: "tag2"}
             ] = post.post_tags

      assert [%{id: "tag1"}, %{id: "tag3"}, %{id: "tag5"}, %{id: "tag4"}, %{id: "tag2"}] =
               post.tags
    end
  end
end
