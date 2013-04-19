<%inherit file="_templates/site.mako" />
<aside id="introduction" class="bodywidth">
  <div id="introleft">
    <h2>Welcome to <span class="blue">mojavy.com</span></h2>
    <p>
      <a href="/blog" title="Blog" class="findoutmore" style="margin: 0 10px 0 10px;">Blog</a>
      <a href="http://twitter.com/#!/taksatou" title="Twitter" class="findoutmore" style="margin: 0 10px 0 10px;">Twitter</a>
      <a href="https://github.com/taksatou" title="github" class="findoutmore" style="margin: 0 10px 0 10px;">github</a>
      <a href="/about.html" title="About" class="findoutmore" style="margin: 0 10px 0 10px;">About</a>
    </p>
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
    <p>
    <img src="images/startingout.png" />
    </p>
  </div>

  <section id="articlesright">
<%include file="recent_posts_large.mako" />
  </section>
</div>
