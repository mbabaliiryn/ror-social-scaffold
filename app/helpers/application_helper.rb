module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete, class: 'dislike')
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post, class: 'like')
    end
  end

  def upvote_or_downvote_btn(post)
    vote = Vote.find_by(post: post, user: current_user)
    if vote
      link_to('Downvote!', post_vote_path(id: vote.id, post_id: post.id), method: :delete, class: 'dislike')
    else
      link_to('Upvote!', post_votes_path(post_id: post.id), method: :post, class: 'like')
    end
  end


end
