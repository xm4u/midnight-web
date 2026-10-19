import { readFile } from "node:fs/promises";

const config = {
  path: new URL("./data.json", import.meta.url),
  retries: 2,
  features: ["cache", "metrics"],
};

export function createCache(entries = []) {
  const values = new Map(entries.map(([key, value]) => [key, value]));
  return {
    get: (key) => values.get(key) ?? null,
    set(key, value) {
      values.set(key, value);
    },
  };
}

export async function readConfig() {
  try {
    const source = await readFile(config.path, "utf8");
    const parsed = JSON.parse(source);
    return { ...parsed, features: config.features.filter((name) => name !== "metrics") };
  } catch (error) {
    console.error(`Unable to read config: ${error.message}`);
    throw error;
  }
}
