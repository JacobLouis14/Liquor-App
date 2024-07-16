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
  getAllProduct,
} = require("../controllers/product");
const {
  getCategoryList,
  createCategory,
  deleteCategory,
} = require("../controllers/categories");
const {
  getShopList,
  createShopList,
  getAllShopList,
  deleteShop,
} = require("../controllers/shop");

//middleWare
const { isAdmin } = require("../middleware/auth");

/* multer config */
const upload = multer({
  storage: multer.memoryStorage(),
});

/* State Route */
router.get("/listState", listStates);
router.post("/createState", createState);
router.patch("/updateState", updateStates);
router.delete("/deleteState", deleteStates);

/* Product Route */
router.get("/getProductList/:statename/:category", getProductLIst);
router.post("/createProduct", upload.array("Images"), createProduct);
router.patch("/updateProduct", upload.any(), updateProduct);
router.delete("/deleteProduct", deleteProduct);
router.get("/getallproductdata", getAllProduct);

/* Category Routes */
router.get("/getCategoryList", getCategoryList);
router.post("/createCategory", upload.single("categoryImage"), createCategory);
router.patch("/updateCategory");
router.delete("/deleteCategory", deleteCategory);

/* Shop Routes */
router.get("/getshoplist/:shopType", getShopList);
router.post("/createshop", createShopList);
router.delete("/deleteShop", deleteShop);
router.get("/getallshoplist", getAllShopList);

module.exports = router;
