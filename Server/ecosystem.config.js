module.exports = {
  apps: [
    {
      name: "liquor-Server",
      script: "app.js",
      instances: "max", // Or specify a number
      exec_mode: "cluster", // Enables clustering
      env: {
        NODE_ENV: "production",
      },
    },
  ],
};
