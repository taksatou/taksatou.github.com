  <div id="categories">
    <h1>Categories</h1>
    <ul>
% for category, num_posts in bf.config.blog.all_categories:
     <li><a href="${category.path}">${category}</a> (<a href="${category.path}/feed">rss</a>) (${num_posts})</li>
% endfor
    </ul>
  </div> 
