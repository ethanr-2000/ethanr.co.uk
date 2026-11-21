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
  watch: true,
  watchOptions: {
    ignored: [
      "node_modules/",
      "build/",
    ],
    aggregateTimeout: 300, // Delay before rebuilding
    poll: 1000,
  },
  plugins: [
    new CopyPlugin({
      patterns: [
        { from: "src" },
      ],
    }),
  ],
};
