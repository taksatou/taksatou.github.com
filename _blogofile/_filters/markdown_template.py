import markdown
import logging

import markdown_ext_toc

config = {
    'name': "Markdown",
    'description': "Renders markdown formatted text to HTML",
    'aliases': ['markdown']
    }


#Markdown logging is noisy, pot it down:
logging.getLogger("MARKDOWN").setLevel(logging.ERROR)


def run(content):
    return markdown.markdown(content, ['toc', 'def_list', 'tables'])
