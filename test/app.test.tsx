import { test, expect } from "bun:test";
import { renderToStaticMarkup } from "react-dom/server";
import App from "../src/App";

test("App renders expected text", () => {
  const html = renderToStaticMarkup(<App />);
  expect(html).toContain("Hello EPAM");
  expect(html).toContain("Thanks for the course!");
  expect(html).toContain("it was fire");
});
