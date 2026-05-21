// @ts-check
import tailwindcss from "@tailwindcss/vite";
import { defineConfig } from "astro/config";

import sitemap from "@astrojs/sitemap";

// https://astro.build/config
export default defineConfig({
  vite: {
      plugins: [tailwindcss()],
  },

  server: {
      allowedHosts: true
  },
  site: "https://vidalatech.dpdns.org/",
  integrations: [sitemap()]
});