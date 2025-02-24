import React from "react"
import Container from "react-bootstrap/cjs/Container";
import thingsivemade from "../data/thingsivemade.json";

function ThingsIveMadePage() {
  return (
    <Container className="h-100 d-flex align-items-center">
      <ThingsIveMadePage thingsivemade={thingsivemade}/>
    </Container>
  )
}

export default ThingsIveMadePage
