<%page args="post"/>
<div class="socialbuttons">
  <ul style="list-style:none;">
    <li>
      <div class="fb-like" data-href="${post.permalink}" data-send="false" data-layout="button_count" data-width="20" data-show-faces="true"></div>
    </li>

    <li>
      <a href="http://b.hatena.ne.jp/entry/${post.permalink}" class="hatena-bookmark-button" data-hatena-bookmark-title="${post.title}" data-hatena-bookmark-layout="simple-balloon" title="このエントリーをはてなブックマークに追加"><img src="http://b.st-hatena.com/images/entry-button/button-only.gif" alt="このエントリーをはてなブックマークに追加" width="20" height="20" style="border: none;" /></a><script type="text/javascript" src="http://b.st-hatena.com/js/bookmark_button.js" charset="utf-8" async="async"></script>
    </li>
    
    <li>
      <a href="https://twitter.com/share" class="twitter-share-button" data-url="${post.permalink}" data-text="${post.title}">Tweet</a><script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
    </li>
    
    <li>
      <div class="g-plusone" data-size="medium" data-href="${post.permalink}"></div>
    </li>

    <li>
      <a data-save-url="${post.permalink}" data-pocket-label="pocket" data-pocket-count="horizontal" class="pocket-btn" data-lang="en"></a>
      <script type="text/javascript">!function(d,i){if(!d.getElementById(i)){var j=d.createElement("script");j.id=i;j.src="https://widgets.getpocket.com/v1/j/btn.js?v=1";var w=d.getElementById(i);d.body.appendChild(j);}}(document,"pocket-btn-js");</script>
    </li>
  </ul>
</div>
