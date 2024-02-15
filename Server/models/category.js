const mongoose = require("mongoose");

const CategorySchema = new mongoose.Schema(
  {
    CategoryName: {
      type: String,
      min: 3,
      required: true,
    },
    CategoryValue: {
      type: String,
      min: 3,
      required: true,
    },
    CategoryPhotoUrl: {
      type: String,
      required: true,
    },
  },
  { timestamps: true }
);

const CategoryModel = mongoose.model("Category", CategorySchema);
module.exports = CategoryModel;
