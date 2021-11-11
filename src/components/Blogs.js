import React from "react";
import blogs from "../data/blogs.json";

function Blogs() {
  return <>
  <code className="text-lowercase"> Blogs </code>
  <ul className="text-lowercase">{blogs.map(b => <li className="pb-1">
      <a
        href={b.link}
        target="_blank"
        rel="noopener noreferrer"
        className="link-light"
      >
        {b.title}
      </a>
      <p><code>{b.date}</code>{" / " + b.subtitle}</p>
    </li>
  ).reverse()}
  </ul>
  </>
}

export default Blogs
