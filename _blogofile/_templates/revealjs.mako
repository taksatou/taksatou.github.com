<!doctype html>
<html lang="en">

	<head>
		<meta charset="utf-8">

		<title>${post.title}</title>

		<meta name="description" content="A framework for easily creating beautiful presentations using HTML">
		<meta name="author" content="Hakim El Hattab">

		<meta name="apple-mobile-web-app-capable" content="yes" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />

		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

		<link rel="stylesheet" href="${bf.config.blog.revealjs.path}/css/reveal.min.css">
		<link rel="stylesheet" href="${bf.config.blog.revealjs.path}/css/theme/default.css" id="theme">

		<!-- For syntax highlighting -->
		<link rel="stylesheet" href="${bf.config.blog.revealjs.path}/lib/css/zenburn.css">

		<!-- If the query includes 'print-pdf', use the PDF print sheet -->
		<script>
			document.write( '<link rel="stylesheet" href="${bf.config.blog.revealjs.path}/css/print/' + ( window.location.search.match( /print-pdf/gi ) ? 'pdf' : 'paper' ) + '.css" type="text/css" media="print">' );
		</script>

		<!--[if lt IE 9]>
		<script src="${bf.config.blog.revealjs.path}/lib/js/html5shiv.js"></script>
		<![endif]-->
	</head>

	<body>

		<div class="reveal">
			<!-- Any section element inside of this container is displayed as a slide -->
			<div class="slides">
              <section>
                <h2>${post.title}</h2>
              </section>
              <section data-markdown data-separator="^\n\n\n" data-vertical="^\n\n">
                <script type="text/template">
                  ${markdown_src}
                </script>
              </section>
			</div>

		</div>

		<script src="${bf.config.blog.revealjs.path}/lib/js/head.min.js"></script>
		<script src="${bf.config.blog.revealjs.path}/js/reveal.min.js"></script>

		<script>

			// Full list of configuration options available here:
			// https://github.com/hakimel/reveal.js#configuration
			Reveal.initialize({
				controls: true,
				progress: true,
				history: true,
				center: true,

				theme: Reveal.getQueryHash().theme, // available themes are in /css/theme
				transition: Reveal.getQueryHash().transition || 'default', // default/cube/page/concave/zoom/linear/fade/none

				// Optional libraries used to extend on reveal.js
				dependencies: [
					{ src: '${bf.config.blog.revealjs.path}/lib/js/classList.js', condition: function() { return !document.body.classList; } },
					{ src: '${bf.config.blog.revealjs.path}/plugin/markdown/marked.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
					{ src: '${bf.config.blog.revealjs.path}/plugin/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
					{ src: '${bf.config.blog.revealjs.path}/plugin/highlight/highlight.js', async: true, callback: function() { hljs.initHighlightingOnLoad(); } },
					{ src: '${bf.config.blog.revealjs.path}/plugin/zoom-js/zoom.js', async: true, condition: function() { return !!document.body.classList; } },
					{ src: '${bf.config.blog.revealjs.path}/plugin/notes/notes.js', async: true, condition: function() { return !!document.body.classList; } }
				]
			});

		</script>

	</body>
</html>
