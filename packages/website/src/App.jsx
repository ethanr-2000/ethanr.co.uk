import React from "react"
import {BrowserRouter, Route, Routes} from "react-router-dom"
import 'bootstrap/dist/css/bootstrap.min.css'
import Layout from "./components/Layout"
import Home from "./pages/Home"
import BlogPage from "./pages/BlogPage"
import BlogsPage from "./pages/BlogsPage"
import ArchivedPage from "./pages/ArchivedPage"
import ThingsIveMadePage from "./pages/ThingsIveMadePage"
import About from "./pages/About"
import FourOhFour from "./pages/FourOhFour"

function App() {
  return (
    <BrowserRouter>
      <Layout>
        <Routes>
          <Route path="/" element={<Home/>}/>
          <Route path="/blog">
            <Route path=":blogId" element={<BlogPage/>}/>
          </Route>
          <Route path="/blogs" element={<BlogsPage/>}/>
          <Route path="/thingsivemade" element={<ThingsIveMadePage/>}/>
          <Route path="/archived" element={<ArchivedPage/>}/>
          <Route path="/about" element={<About/>}/>
          <Route path="*" element={<FourOhFour/>}/>
        </Routes>
      </Layout>
    </BrowserRouter>
  );
}

export default App;
