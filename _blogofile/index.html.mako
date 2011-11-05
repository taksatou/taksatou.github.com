<%inherit file="_templates/site.mako" />
<aside id="introduction" class="bodywidth">
  <div id="introleft">
    <h2>Welcome to <span class="blue">mojavy.com</span></h2>
    <p><a href="/blog" title="Blog" class="findoutmore" style="margin: 0 10px 0 10px;">Blog</a>
      <a href="/" title="" class="findoutmore" style="margin: 0 10px 0 10px;">todo</a></p>
  </div>
  <blockquote id="introquote">
    <p>
1 Mississippi
2 Mississippi
3 Mississippi
4 Mississippi
5 Mississippi
6 Mississippi
7 Mississippi...</p>
    <p class="quotename">Jane Doe, <span class="bold">somewhere</span></p>
  </blockquote>

</aside>
<br />
<br />
<br />
<br />
<br />
<br />
<div id="maincontent" class="bodywidth">
  <div id="aboutleft">
    <h3>Awesome Title</h3>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse quis molestie sapien. Proin elit quam, commodo ut aliquet vel, elementum ut odio. Praesent semper tincidunt magna, sed sagittis elit congue sed. Mauris malesuada, elit ut luctus tristique, lectus libero rutrum mauris, ac tristique justo ligula sit amet metus.</p>
    <p>Etiam a magna vitae diam elementum dignissim. Donec eget justo ut eros fermentum sodales. Donec eleifend sodales gravida. Nulla nulla metus, laoreet at consectetur sed, dapibus vitae felis. Donec venenatis laoreet purus vel hendrerit. Donec sit amet sem a metus bibendum gravida sit amet at ligula. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>
    <h4>Another Awesome Title</h4>
    <p>Maecenas eu purus ipsum, non accumsan metus. Mauris augue dui, condimentum quis aliquam non, tincidunt id tortor. Donec dignissim sem sed nisl luctus scelerisque. Cras lacinia aliquam orci ac ultricies. Vestibulum ac lacus eu nisi commodo sollicitudin. Curabitur at consectetur leo. Donec augue velit, ornare in fermentum quis, tristique id augue.</p>
    <p>Cras sem est, luctus ac pharetra id, feugiat id enim. Nullam at massa felis, vitae hendrerit tellus. Sed placerat arcu sed risus commodo iaculis. Aenean at felis enim. Mauris eget est in diam sagittis ultrices sit amet eu mi. Sed ultrices, orci et tincidunt fringilla, diam diam consequat elit, vel tempus mauris mi vitae sem. Ut lectus est, commodo a pulvinar at, faucibus et ligula.</p>
  </div>

  <section id="articlesright">
    <h1 style="margin: 0 0 5px 0;">Recent posts</h1>
% for post in bf.config.blog.posts[:3]:
    <article>
      <figure> <img src="images/articleimage.jpg" alt="Article Image" /> </figure>
      <header><a href="${post.path}" title="${post.title}"><h5>${post.title}</h5></a></header>
      <p>
	% for c in post.tags:
      <span style="margin: 3px 5px 0px 5px;">${c}</span>
	% endfor
      </p>
      <p>${post.excerpt}</p>
      <p>${post.date.strftime("%B %d, %Y at %I:%M %p")}</p>
      <a href="${post.path}" title="Read More" class="readmore">Read more</a> </article>
% endfor

  </section>
</div>
