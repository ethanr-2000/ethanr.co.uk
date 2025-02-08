import React from "react";

function ThingsIveMade({ thingsivemade }) {
  return <>
    <code className="text-lowercase"> Things I've Made </code>
    <ul className="text-lowercase">{thingsivemade.map(t =>
      <li key={t.title}>
        <a
          href={t.link}
          className="link-light"
        >
          {t.title}
        </a>
      </li>
    )}
    </ul>
  </>
}

export default ThingsIveMade
