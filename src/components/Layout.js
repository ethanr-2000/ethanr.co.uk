import React from "react";
import Container from 'react-bootstrap/Container'
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'
import Sidebar from "./Sidebar";

function Layout({...props}) {
  return (
    <div>
      <Container>
        <Row>
          <Col lg={3} xs={12}>
            <Sidebar/>
          </Col>
          <Col lg={9} xs={11} className="p-3 pt-lg-5 pt-0 mh-100">
            {props.children}
          </Col>
        </Row>
      </Container>
    </div>
  );
}

export default Layout;
