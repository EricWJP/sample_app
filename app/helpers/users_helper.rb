module UsersHelper
  #返回用户的 avatar
  def gravatar_for(user, options = {size: 80})
    size = options[:size].to_i
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}/s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar", height: 100, width: 100)
  end
end