"""
Render TeX blocks to png

This is a Blogofile filter. Place it in your _filters directory.
"""
import tempfile
import subprocess
import shutil
import shlex
import os
import re
import hashlib
import blogofile_bf as bf

tex_template = r"""
\documentclass{article}
\usepackage{amsmath}
\usepackage{amsthm}
\usepackage{amssymb}
\usepackage{bm}
\newcommand{\mx}[1]{\mathbf{\bm{#1}}}
\newcommand{\vc}[1]{\mathbf{\bm{#1}}}
\newcommand{\T}{\text{T}}
\pagestyle{empty}
\begin{document}
%s
\newpage 
\end{document}
"""

latex_block_re = re.compile(r"\s\$\$latex\s(.*?)\s\$", re.DOTALL)

def render_tex_math_expr_to_png(math_block, png_location):
    """Wrap a mathematical TeX expression in $ symbols and render"""
    render_tex_to_png("$%s$" % math_block, png_location)

def render_tex_to_png(latex_block, png_location):
    """Render a TeX formatted string to an image file

    Depends on 'latex' and 'dvipng' binaries on the system path
    """

    #Create a temporary directory and go into it
    tmp_dir = tempfile.mkdtemp()
    previous_dir = os.getcwd()
    os.chdir(tmp_dir)

    tex_f = open(os.path.join(tmp_dir,"source.tex"),"w")
    tex_f.write((tex_template % latex_block))
    tex_f.close()

    try:
        #Generate the .dvi
        p = subprocess.Popen(shlex.split(
                'latex -interaction=nonstopmode source.tex'),
                             stdout=subprocess.PIPE)
        p.wait()
        #Generate the .ps
        p = subprocess.Popen(shlex.split('dvips source.dvi'),
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE)
        p.wait()
        #Generate the .png
        p = subprocess.Popen(shlex.split(
                'convert -density 120 -trim -transparent'
                ' "#FFFFFF" source.ps rendered.png'),stdout=subprocess.PIPE)
        p.wait()
        #Copy the .png to the png_location
        os.chdir(previous_dir)
        shutil.copyfile(os.path.join(tmp_dir,"rendered.png"),png_location)
    finally:
        #Go back to the original directory and clean up the temp files
        os.chdir(previous_dir)
        shutil.rmtree(tmp_dir)
        
def render_latex_blocks(src, cache_dir="_tmp", site_images_dir="images"):
    """Render a document with LaTeX blocks

    1) Extract all the $$latex blocks
    2) Render each TeX block to an image to the cache
    3) Copy the (pre)rendered image from the cache to the _site dir
    4) Replace the $$latex blocks with <img> tags
    """
    img_substitutions = {}
    for m in latex_block_re.finditer(src):
        tex_expr = m.groups()[0]
        fn = hashlib.md5(tex_expr).hexdigest()+".png"
        png_cached = os.path.join(cache_dir,fn)
        site_png_dir = bf.util.path_join("_site",bf.util.fs_site_path_helper(
                site_images_dir))
        site_png = bf.util.path_join(site_png_dir,fn)
        #only render the image if the image is not already cached
        if(not os.path.isfile(png_cached)):
            bf.util.mkdir(cache_dir)
            bf.filter.logger.info("Rendering LaTeX: "+tex_expr)
            render_tex_math_expr_to_png(tex_expr,png_cached)
        #copy the rendered image to the site dir
        bf.util.mkdir(site_png_dir)
        shutil.copyfile(png_cached,site_png)
        #record the $$latex block and it's replacement <img> tag
        img_substitutions[m.group()] = "<img src=\"%s\">" % \
            (bf.util.site_path_helper(site_images_dir,fn))
    #Make the <img> tag replacements in a single pass

    def my_replace(x):
        if img_substitutions.has_key(x.group(0)):
            return img_substitutions[x.group(0)]
        else:
            ''

    p = re.compile('|'.join(map(re.escape, img_substitutions)))
    return p.sub(my_replace, src)
    

def run(src):
    return render_latex_blocks(src)
