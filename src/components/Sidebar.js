import React from "react"
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'
import { Linkedin, Github, Medium } from 'react-bootstrap-icons'

function Sidebar() {
  return (
    <Container className="d-flex align-items-center sidebar m-0 p-0">
      <Row className="sidebar-row pb-3 w-100">
        <Col lg={12} xs={6}>
          <h1>ethan roberts</h1>
          <h6 className="emph">a big nerd</h6>
          <h4>
            <a className="link-light p-1" href="https://www.linkedin.com/in/ethanroberts2000/"><Linkedin/></a>
            <a className="link-light p-1" href="https://github.com/ethanr-2000"><Github/></a>
            <a className="link-light p-1" href="https://ethanr2000.medium.com/"><Medium/></a>
          </h4>
        </Col>
        <Col lg={12} xs={6} className="d-flex m-auto">
          <Col lg={3} xs={6}>
          <h6><a className="link-light float-right" href="/">home</a></h6>
          </Col>
          <Col lg={9} xs={6}>
          <h6><a className="link-light float-right" href="/about">about</a></h6>
          </Col>
        </Col>
      </Row>
    </Container>
  );
}

export default Sidebar;
