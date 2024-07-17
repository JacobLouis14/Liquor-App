module.exports = {
  apps: [
    {
      name: "my-express-app",
      script: "app.js",
      instances: "max", // Or specify a number
      exec_mode: "cluster", // Enables clustering
      env: {
        NODE_ENV: "production",
      },
    },
  ],
};
