import React from "react"
import Container from "react-bootstrap/Container";

function About() {
  return (
    <Container className="h-100 d-flex align-items-center">
      <div>
        <p>fourth year undergraduate software engineer at the <span className="emph">dyson institute</span></p>
        <p>currently developing & maintaining <span className="emph">dyson's cloud services</span></p>
        <p>see where i've been <a className="emph" href="https://www.ukclimbing.com/logbook/showlog.php?id=315371">rock climbing</a> recently</p>
      </div>
    </Container>
  )
}

export default About
