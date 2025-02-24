import React from "react"
import Container from "react-bootstrap/cjs/Container";
import Blogs from "../components/Blogs"
import ThingsIveMade from "../components/ThingsIveMade"
import blogs from "../data/blogs.json";
import archivedBlogs from "../data/archived-blogs.json";
import thingsivemade from "../data/thingsivemade.json";

function Home() {
  return (
    <Container className="h-100 d-flex align-items-center">
      <div>
        <Blogs
          title={"blogs - thoughts on software and rock climbing"}
          blogs={blogs}
          fullPageLink={"/blogs"}
        />
        <Blogs
          title={"archived - no guarantee of quality"}
          blogs={archivedBlogs}
          maxItems={5}
          fullPageLink={"/archived"}
        />
        <ThingsIveMade thingsivemade={thingsivemade}/>
      </div>
    </Container>
  )
}

export default Home
