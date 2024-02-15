const mongoose = require("mongoose");

const productSchema = new mongoose.Schema(
  {
    ProductName: {
      type: String,
      required: true,
    },
    ProductValue: {
      type: String,
      required: true,
    },
    ProductPrice: {
      type: Number,
      required: true,
    },
    ProductCode: {
      type: String,
      required: true,
    },
    BrandName: {
      type: String,
      required: true,
    },
    Quantity: {
      type: Number,
      required: true,
    },
    Proof: {
      type: Number,
      required: true,
    },
    EDP: {
      type: Number,
      required: true,
    },
    Category: {
      type: String,
      required: true,
    },
    ProductImageUrl: {
      type: Array,
      required: true,
    },
    ProductAvailableState: {
      type: Array,
      required: true,
    },
  },
  { timestamps: true }
);

const productModel = mongoose.model("Products", productSchema);
module.exports = productModel;
