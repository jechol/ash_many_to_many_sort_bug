alias MyDomain.{Post, Tag}

# Insert tags
["tag1", "tag2", "tag3", "tag4", "tag5", "tag6", "tag7", "tag8", "tag9", "tag10"]
|> Enum.each(fn tag ->
  Ash.Changeset.for_create(Tag, :create, %{id: tag})
  |> Ash.create!()
end)

# Noise post
Ash.Changeset.for_create(Post, :create,
  text: "post",
  tags: ["tag1", "tag2", "tag3", "tag4", "tag5", "tag6", "tag7", "tag8", "tag9", "tag10"]
)
|> Ash.create!()

# Target post
Ash.Changeset.for_create(Post, :create,
  text: "post",
  tags: ["tag1", "tag3", "tag5", "tag4", "tag2"]
)
|> Ash.create!()
|> tap(fn post ->
  require Logger
  Logger.warning("Target post id is #{post.id}.")
  Logger.error("Below query is not working as expected.")
  Logger.configure(level: :debug)

  Ash.load!(post, :tags)
end)
