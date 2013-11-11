import markdown
import logging

import sys
import os

# work around for importing
sys.path.append(os.path.dirname(__file__))

import markdown_ext_toc

config = {
    'name': "Markdown",
    'description': "Renders markdown formatted text to HTML",
    'aliases': ['markdown']
    }


#Markdown logging is noisy, pot it down:
logging.getLogger("MARKDOWN").setLevel(logging.ERROR)


def run(content):
    return markdown.markdown(content, ['toc', 'def_list', 'tables', 'footnotes'])
