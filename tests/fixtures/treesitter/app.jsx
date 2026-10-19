import React from "react";

const IconButton = ({ label, onActivate }) => (
  <button className="icon-button" aria-label={label} onClick={onActivate}>
    <span className="icon" aria-hidden="true">✦</span>
    <span>{label}</span>
  </button>
);

export default function Toolbar({ title = "Workspace" }) {
  const handleSave = () => console.info(`Saving ${title}`);
  return (
    <nav aria-label="Main navigation">
      <h2>{title}</h2>
      <IconButton label="Save changes" onActivate={handleSave} />
      <a href="https://example.test/help" target="_blank" rel="noreferrer">
        Help
      </a>
    </nav>
  );
}
