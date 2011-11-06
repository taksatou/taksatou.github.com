<%inherit file="site.mako" />
<div id="maincontent2" class="bodywidth">
<div id="blogleft">
<%include file="post.mako" args="post=post" />
<div id="disqus_thread"></div>
<script type="text/javascript">
  var disqus_url = "${post.permalink}";
</script>
% if bf.config.blog.disqus.enabled:
<script type="text/javascript" src="http://disqus.com/forums/${bf.config.blog.disqus.name}/embed.js"></script>
<noscript><a href="http://${bf.config.blog.disqus.name}.disqus.com/?url=ref">View the discussion thread.</a></noscript><a href="http://disqus.com" class="dsq-brlink">blog comments powered by <span class="logo-disqus">Disqus</span></a>
% endif

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
