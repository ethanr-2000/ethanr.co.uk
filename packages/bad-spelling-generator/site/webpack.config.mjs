import CopyPlugin from "copy-webpack-plugin";
import path from "path";

export default {
  entry: "./src/index.js",
  output: {
    filename: "index.js",
    path: path.resolve("build"),
  },
  resolve: {
    extensions: [".js"],
  },
  mode: "production",
  // The data files are fetched when needed rather than bundled, so only size-check JavaScript
  performance: {
    assetFilter: (file) => file.endsWith(".js"),
  },
  watch: true,
  watchOptions: {
    ignored: ["node_modules/", "build/"],
    aggregateTimeout: 300, // Delay before rebuilding
    poll: 1000,
  },
  plugins: [
    new CopyPlugin({
      patterns: [
        // Static files and the generated data; the JavaScript is bundled instead
        { from: "src", globOptions: { ignore: ["**/*.js"] } },
      ],
    }),
  ],
};
