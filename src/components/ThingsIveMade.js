import React from "react";
import thingsivemade from "../data/thingsivemade.json";

function ThingsIveMade() {
  return <>
    <code className="text-lowercase"> Things I've Made </code>
    <ul className="text-lowercase">{thingsivemade.map(t => <li>
        <a
          href={t.link}
          target="_blank"
          rel="noopener noreferrer"
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
