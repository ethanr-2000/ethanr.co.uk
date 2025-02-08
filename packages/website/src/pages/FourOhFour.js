import React from "react"
import {useLocation} from "react-router";
import Container from "react-bootstrap/Container";

function FourOhFour() {
  const path = useLocation().pathname

  return (
      <Container className="h-100 d-flex align-items-center">
        <div>
          <h1 className="text-white">404 - Sorry</h1>
          <p>Did you really think <span className="emph">{path}</span> would exist?</p>
        </div>
      </Container>
  )
}

export default FourOhFour
