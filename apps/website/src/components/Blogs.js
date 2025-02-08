import React from "react";

function Blogs({ title, blogs, maxItems=Infinity, fullPageLink }) {
  const sortedFilteredBlogs = blogs.reverse().slice(0, maxItems);
  const overflowItems = blogs.length - sortedFilteredBlogs.length

  return <>
  <code className="text-lowercase">{title}</code>
  <ul className="text-lowercase">{sortedFilteredBlogs.map(blog =>
    <li key={blog.title} className="pb-1">
      <a
        href={blog.link}
        className="link-light"
      >
        {blog.title}
      </a>
      <p><code>{blog.date}</code>{" / " + blog.subtitle}</p>
    </li>
  )}
  {overflowItems > 0 ?
  <li key={"overflow"}>
    <a className="link-light" href={fullPageLink}>
      {`${overflowItems} more...`}
    </a>
  </li>
  : null}
  </ul>
  </>
}

export default Blogs
