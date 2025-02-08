import React from "react"
import Container from "react-bootstrap/cjs/Container";
import Blogs from "../components/Blogs";
import blogs from "../data/blogs.json";

function BlogsPage() {
  return (
    <Container className="h-100 d-flex align-items-center">
      <div>
        <p>thoughts on software and rock climbing</p>
        <Blogs blogs={blogs}/>
      </div>
    </Container>
  )
}

export default BlogsPage
