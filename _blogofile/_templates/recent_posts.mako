  <div id="recent_posts">			
    <h1>Recent posts</h1>
    <ul>
% for post in bf.config.blog.posts[:8]:
      <li><a href="${post.path}" title="${post.title}"><p>${post.title}</a><span style="font-size: 80%;">(${post.date.strftime("%B %d, %Y at %I:%M %p")})</span></li>
% endfor
    </ul>
  </div>
