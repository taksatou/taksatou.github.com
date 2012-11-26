<%page args="post"/>
<div class="blog_post">
  <a name="${post.slug}"></a>
  <h2 class="blog_post_title"><a href="${post.permalink}" rel="bookmark" title="Permanent Link to ${post.title}">${post.title}</a></h2>
  <small>${post.date.strftime("%B %d, %Y at %I:%M %p")} | categories:
<%
   category_links = []
   for category in post.categories:
       if post.draft:
           #For drafts, we don't write to the category dirs, so just write the categories as text
           category_links.append(category.name)
       else:
           category_links.append("<a href='%s'>%s</a>" % (category.path, category.name))
%>
${", ".join(category_links)}
% if bf.config.blog.disqus.enabled:
 | <a href="${post.permalink}#disqus_thread"></a>
% endif
</small>
<p/>
  <div class="post_prose">
    ${self.post_prose(post)}
  </div>
</div>

<div class="shr_rd"></div>
<!-- <div class="linkwithin_div"></div> -->

<%def name="post_prose(post)">
<div class="blogbody">
  ${post.content}
</div>
</%def>
<div id="prev_next_link">
  % if post.prev_post:
  <a href="${post.prev_post.permalink}"> previous post </a>
  %endif
  % if post.prev_post and post.next_post:
    |
  %endif
  % if post.next_post:
  <a href="${post.next_post.permalink}"> next post </a>
  %endif
</div>
<hr class="intersocial">
<%include file="social_buttons.mako" args="post=post" />
