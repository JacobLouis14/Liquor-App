const CategoryModel = require("../models/category");
const { initializeApp } = require("firebase/app");
const {
  getStorage,
  ref,
  getDownloadURL,
  uploadBytesResumable,
} = require("firebase/storage");
//Firebase Configuration
initializeApp({
  apiKey: process.env.API_KEY,
  authDomain: process.env.AUTH_DOMAIN,
  projectId: process.env.PROJECT_ID,
  storageBucket: process.env.STORAGE_BUCKET,
  messagingSenderId: process.env.MESSAGE_SENDER_ID,
  appId: process.env.APP_ID,
});
const storage = getStorage();

//Listing Category
const getCategoryList = async (req, res) => {
  try {
    const categoryList = await CategoryModel.find(
      {},
      { CategoryName: 1, _id: 0, CategoryValue: 1, CategoryPhotoUrl: 1 }
    );

    if (categoryList.length > 0) {
      res.status(200).send(categoryList);
    } else {
      res.status(404).json({ msg: "Categories Not Added" });
    }
  } catch (error) {
    console.log(`Error in Listing Categories ${error}`);
  }
};

//Creating Category
const createCategory = async (req, res) => {
  try {
    if (req.file) {
      const { categoryName } = req.body;
      console.log(req.body);
      const categoryValue = categoryName.toLowerCase();

      //checking the data exists
      const isExist = await CategoryModel.findOne({
        CategoryValue: categoryValue,
      });

      if (isExist) {
        res.status(400).json({ message: "Category Exists" });
      } else {
        //uploading image

        const storageRef = ref(
          storage,
          `CategoryPhoto/${(req.file.originalname = categoryValue)}`
        );
        const metaData = {
          contentType: req.file.mimetype,
        };
        const snapShot = await uploadBytesResumable(
          storageRef,
          req.file.buffer,
          metaData
        );
        const downloadRef = await getDownloadURL(snapShot.ref);

        //saving to database
        const savedCategory = await new CategoryModel({
          CategoryName: categoryName,
          CategoryValue: categoryValue,
          CategoryPhotoUrl: downloadRef,
        }).save();
        const { _id, createdAt, updatedAt, __v, ...categoryDataToSend } =
          savedCategory._doc;
        res.status(200).json(categoryDataToSend);
      }
    } else {
      res.status(400).json({ msg: "Image file required" });
    }
  } catch (error) {
    console.log(`Error in creating State${error}`);
  }
};
const updtateCategory = () => {};
const deleteCategory = () => {};

module.exports = { getCategoryList, createCategory };
