import React from "react"
import {BrowserRouter, Route, Routes} from "react-router-dom"
import 'bootstrap/dist/css/bootstrap.min.css'
import Layout from "./components/Layout"
import Home from "./pages/Home"
import About from "./pages/About"
import FourOhFour from "./pages/FourOhFour"

function App() {
  return (
    <BrowserRouter>
      <Layout>
        <Routes>
          <Route path="/" element={<Home/>}/>
          <Route path="/about" element={<About/>}/>
          <Route path="*" element={<FourOhFour/>}/>
        </Routes>
      </Layout>
    </BrowserRouter>
  );
}

export default App;
