import React from "react"
import Container from "react-bootstrap/cjs/Container";
import Blogs from "../components/Blogs";
import archivedBlogs from "../data/archived-blogs.json";

function ArchivedPage() {
  return (
    <Container className="h-100 align-items-center">
      <h3>archived - no guarantee of quality</h3>
      <p>These are articles I wrote as a keen 20-22 year old. While I'm proud of them, they don't represent my current best work. That said, they do contain some good information.</p>
      <div>
        <Blogs blogs={archivedBlogs}/>
      </div>
    </Container>
  )
}

export default ArchivedPage
