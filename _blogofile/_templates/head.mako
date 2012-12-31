<title>
% if post:
${post.title}
% else:
${bf.config.blog.name}
% endif
</title>
<link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="${bf.util.site_path_helper(bf.config.blog.path,'/feed')}" />
<link rel="alternate" type="application/atom+xml" title="Atom 1.0"
href="${bf.util.site_path_helper(bf.config.blog.path,'/feed/atom')}" />
<link rel='stylesheet' href='${bf.config.filters.syntax_highlight.css_dir}/pygments_${bf.config.filters.syntax_highlight.style}.css' type='text/css' />


<link href='http://fonts.googleapis.com/css?family=Ubuntu:regular,bold' rel='stylesheet' type='text/css' />
<link href='http://fonts.googleapis.com/css?family=Vollkorn:regular,italic,bold' rel='stylesheet' type='text/css'>
<!--[if IE]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<!--[if lt IE 9]><script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js"></script><![endif]-->

<link rel='stylesheet' href="${bf.util.site_path_helper(bf.config.site.path,'/styles/styles.css')}" type='text/css' />
<link rel='stylesheet' href='http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/themes/pepper-grinder/jquery-ui.css' type='text/css' />
<script src="https://www.google.com/jsapi?key=ABQIAAAAcOj4HIzbhVG_glmoxqtIlhSZ8YWc9pfyrPx-qTk3ymJ7vBNWbhSCYgWPuVGOqTugaARvpRrNszeUJQ" type="text/javascript"></script>
<script language="Javascript" type="text/javascript">
  google.load("search", "1");
  google.load("jquery", "1.6.4");
  google.load("jqueryui", "1.8.16");


  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-26834066-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

<!-- coderwall -->
<link href="http://coderwall.com/stylesheets/jquery.coderwall.css" media="all" rel="stylesheet" type="text/css">
<script src="http://coderwall.com/javascripts/jquery.coderwall.js"></script>

<rdf:RDF
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:foaf="http://xmlns.com/foaf/0.1/">
  <rdf:Description rdf:about="http://mojavy.com/">
    <foaf:maker rdf:parseType="Resource">
      <foaf:holdsAccount>
        <foaf:OnlineAccount foaf:accountName="armyofpigs">
          <foaf:accountServiceHomepage rdf:resource="http://www.hatena.ne.jp/" />
        </foaf:OnlineAccount>
      </foaf:holdsAccount>
    </foaf:maker>
  </rdf:Description>
</rdf:RDF>
