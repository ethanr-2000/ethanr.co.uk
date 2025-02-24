import React from "react"
import Container from "react-bootstrap/Container";

function About() {
  return (
    <Container className="h-100 d-flex align-items-center">
      <div>
        <p>software engineering consultant with <a className="emph" href="https://bjss.com">bjss</a></p>
        <p>former undergraduate software engineer at the <a className="emph" href="https://www.dysoninstitute.com">dyson institute</a></p>
        <p>see where i've been <a className="emph" href="https://www.ukclimbing.com/logbook/showlog.php?id=315371">rock climbing</a> recently</p>
      </div>
    </Container>
  )
}

export default About
