<% if current_user != user%>
  <% if current_user.following?(user) %>
    <%= link_to "フォロー外す", user_relationships_path(user.id), method: :delete, class: "btn btn-info" %>
  <% else %>
    <%= link_to "フォローする", user_relationships_path(user.id), method: :post, class: "btn btn-success" %>
  <% end %>
<% end %>
