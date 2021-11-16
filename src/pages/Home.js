import React from "react"
import Blogs from "../components/Blogs"
import ThingsIveMade from "../components/ThingsIveMade"
import Container from "react-bootstrap/cjs/Container";

function Home() {
  return (
      <Container className="h-100 d-flex align-items-center">
        <div>
          <ThingsIveMade/>
          <Blogs/>
        </div>
      </Container>
  )
}

export default Home
