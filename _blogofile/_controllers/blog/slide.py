import urlparse
from blogofile.cache import bf
import re

blog = bf.config.controllers.blog


def run():
    write_permapages()

def write_permapages():
    "Write slide to their locations"
    site_re = re.compile(bf.config.site.url, re.IGNORECASE)
    blog_re = re.compile("/blog", re.IGNORECASE)
    code_re = re.compile("(\$\$code\(lang=.*?\)|\$\$\/code)")
    
    for i, post in enumerate(blog.posts):
        if not (hasattr(post, 'slide') and post.slide):
            continue

        path = blog_re.sub(blog.revealjs.slidepath, post.permalink)
        path = site_re.sub("", path)
        src = code_re.sub("```", post.post_src)
        env = {
            "post": post,
            "markdown_src": src
        }

        bf.writer.materialize_template(
                "revealjs.mako", bf.util.path_join(path, "index.html"), env)
