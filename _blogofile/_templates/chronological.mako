<%inherit file="site.mako" />
<div id="maincontent2" class="bodywidth">
<div id="blogleft">
% for post in posts:
  <%include file="post.mako" args="post=post" />
% if bf.config.blog.disqus.enabled:
  <div class="after_post"><a href="${post.permalink}#disqus_thread">Read and Post Comments</a></div>
% endif
  <hr class="interblog" />
% endfor
<div style="text-align: right;">
% if prev_link:
 <a href="${prev_link}">« Previous</a>
% endif
% if prev_link and next_link:
  <span style="margin: 0px 3px 0px 3px">...</span>  
% endif
% if next_link:
 <a href="${next_link}">Next »</a>
% endif
</div>

</div>
<section id="blogright">
<%include file="recent_posts.mako" />
<hr />
<%include file="categories.mako" />
<hr />
<%include file="archives.mako" />
<hr />
<%include file="feed.mako" />
</section>
</div>
