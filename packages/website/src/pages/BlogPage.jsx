import React, { useState, useEffect } from "react"
import { useParams } from 'react-router-dom';
import Container from "react-bootstrap/cjs/Container";

function BlogPage() {
  const { blogId } = useParams();
  const [blogContent, setBlogContent] = useState('');

  useEffect(() => {
    const fetchBlogContent = async () => {
      try {
        // If the blog doesn't exist, the responses will match
        const defaultResponse = await fetch(`this_path_doesnt-exist`);
        const response = await fetch(`/blogs/${blogId}.txt`);

        const blogText = await response.text();
        const defaultText = await defaultResponse.text();

        if (!response.ok || await blogText === defaultText) {
          window.location.href = `/${blogId}`
        }
        
        setBlogContent(blogText);
      } catch (error) {
        window.location.href = `/${blogId}`
      }
    };

    fetchBlogContent();
  }, [blogId]);

  return (
    <Container className="h-100 d-flex align-items-center">
      <div>
        <p>{blogContent}</p>
      </div>
    </Container>
  )
}

export default BlogPage
