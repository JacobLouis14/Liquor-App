const express = require("express");
const multer = require("multer");
const router = express.Router();

const {
  createState,
  listStates,
  updateStates,
  deleteStates,
} = require("../controllers/state");
const {
  createProduct,
  getProductLIst,
  updateProduct,
  deleteProduct,
} = require("../controllers/product");
const {
  getCategoryList,
  createCategory,
} = require("../controllers/categories");
const { getShopList, createShopList } = require("../controllers/shop");

//middleWare
const { isAdmin } = require("../middleware/auth");

/* multer config */
const upload = multer({
  storage: multer.memoryStorage(),
});

/* State Route */
router.get("/listState", listStates);
router.post("/createState", isAdmin, createState);
router.patch("/updateState", updateStates);
router.delete("/deleteState", deleteStates);

/* Product Route */
router.get("/getProductList", getProductLIst);
router.post("/createProduct", upload.any(), createProduct);
router.patch("/updateProduct", upload.any(), updateProduct);
router.delete("/deleteProduct", deleteProduct);

/* Category Routes */
router.get("/getCategoryList", getCategoryList);
router.post("/createCategory", upload.single("categoryImage"), createCategory);
router.patch("/updateCategory");
router.delete("/deleteCategory");

/* Shop Routes */
router.get("/getshoplist", getShopList);
router.post("/createshoplist", createShopList);

module.exports = router;
