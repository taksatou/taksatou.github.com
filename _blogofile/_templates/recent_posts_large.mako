  <div id="archives">			
    <h1>Recent posts</h1>
% for post in bf.config.blog.posts[:3]:
    <article>
      <figure> <img src="images/articleimage.jpg" alt="Article Image" /> </figure>
      <header><a href="${post.path}" title="${post.title}"><h5>${post.title}</h5></a></header>
      <p style="word-break: break-all; word-wrap: break-word; overflow: hidden;" >${post.excerpt[0:140]} ...  <%include file="hatebu2.mako" args="post=post" /></p>
      <a href="${post.path}" title="Read More" class="readmore">Read more</a> </article>
% endfor
</div>