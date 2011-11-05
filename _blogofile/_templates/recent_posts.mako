<h1 style="margin: 0 0 5px 0;">Recent posts</h1>
% for post in bf.config.blog.posts[:5]:
    <article>
      <a href="${post.path}" title="${post.title}"><p>${post.title} ... <span style="font-size: 80%;">${post.date.strftime("%B %d, %Y at %I:%M %p")}</span></p></a>
      </article>
% endfor
