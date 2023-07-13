module TagsHelper
  def tag_from_param(post)
    return post.all_tags if post.id
    return if params[:tags].blank?

    tag = Tag.find(params[:tags])
    return if tag.blank?

    tag.name
  end
end
