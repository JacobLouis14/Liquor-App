const mongoose = require("mongoose");

const ShopSchema = new mongoose.Schema(
  {
    Name: {
      type: String,
      required: true,
    },
    Name_Lower: {
      type: String,
      required: true,
    },
    Address: {
      type: String,
      required: true,
    },
    Category: {
      type: String,
      required: true,
    },
    Latitude: {
      type: Number,
      required: true,
    },
    Longitude: {
      type: Number,
      required: true,
    },
  },
  { timestamps: true }
);

const ShopModel = mongoose.model("Shops", ShopSchema);
module.exports = ShopModel;
