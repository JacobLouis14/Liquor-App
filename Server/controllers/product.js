const productModel = require("../models/product");
const { initializeApp } = require("firebase/app");
const dotenv = require("dotenv").config();
const {
  getStorage,
  ref,
  getDownloadURL,
  uploadBytesResumable,
  deleteObject,
} = require("firebase/storage");
const { isValidObjectId } = require("mongoose");
const CategoryModel = require("../models/category");
const StateModel = require("../models/state");

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

/* Starting Function */

//Product Creation
const createProduct = async (req, res) => {
  try {
    if (req.files.length > 0) {
      const {
        productName,
        productPrice,
        quantity,
        productCode,
        proof,
        EDP,
        brandName,
        category,
        productAvailableState,
      } = req.body;
      const productValue = `${
        productName.replace(/\s+/g, "").toLowerCase() + quantity
      }`;
      let url = [];

      //Checking the product already Exist
      const isExist = await productModel.findOne({
        ProductValue: productValue,
      });

      if (!isExist) {
        //Uploading file
        for (let [index, uploadData] of req.files.entries()) {
          const storageRef = ref(
            storage,
            `LiquorProductPhoto/${(uploadData.originalname =
              productValue + " " + "(" + index + ")")}`
          );
          const metaData = {
            contentType: uploadData.mimetype,
          };
          const snapShot = await uploadBytesResumable(
            storageRef,
            uploadData.buffer,
            metaData
          );
          const downloadRef = await getDownloadURL(snapShot.ref);
          url.push({
            name: `${productValue + " " + "(" + index + ")"}`,
            url: downloadRef,
          });
        }

        //Saving product to database
        const createdProduct = await new productModel({
          ProductName: productName,
          ProductPrice: productPrice,
          ProductValue: productValue,
          ProductImageUrl: url,
          Quantity: quantity,
          EDP: EDP,
          ProductCode: productCode,
          Proof: proof,
          BrandName: brandName,
          Category: category,
          ProductAvailableState: productAvailableState,
        }).save();
        res.send(createdProduct); //response need to be changed
      } else {
        res.send(`Already Exists`);
      }
    } else {
      res.status(400).send(`Upload Photo`);
    }
  } catch (error) {
    console.log(`Error in creating Product ${error}`);
  }
};

//Product Listing
const getProductLIst = async (req, res) => {
  try {
    const category = req.params.category.toLowerCase();
    const stateName = req.params.statename;

    //Checking state exists
    const isStateExists = await StateModel.findOne({ StateName: stateName });

    // finding category exists
    const isCategoryExists = await CategoryModel.findOne({
      CategoryValue: category,
    });
    if (isStateExists) {
      if (isCategoryExists) {
        let productList;
        // checking for all category
        if (isCategoryExists.CategoryValue === "all") {
          productList = await productModel.find(
            {
              ProductAvailableState: { $in: [isStateExists.StateName] },
            },
            { createdAt: 0, updatedAt: 0, __v: 0 }
          );
        } else {
          // code for spesific category
          productList = await productModel.find(
            {
              $and: [
                { Category: isCategoryExists.CategoryName },
                { ProductAvailableState: { $in: [isStateExists.StateName] } },
              ],
            },
            { createdAt: 0, updatedAt: 0, __v: 0 }
          );
        }
        if (productList.length < 1)
          res
            .status(204)
            .json({ message: `ProductList is Empty, Add Products` });
        else res.status(200).send(productList);
      } else {
        res.status(400).json({ message: `Category not found` });
      }
    } else {
      res.status(400).json({ message: `State not found` });
    }
  } catch (error) {
    console.log(`Error in Listing Products ${error}`);
  }
};

//Update Product
const updateProduct = async (req, res) => {
  try {
    const id = req.query.id;
    const {
      productName,
      productPrice,
      quantity,
      productCode,
      proof,
      EDP,
      brandName,
      category,
    } = req.body;
    const productValue = `${
      productName.replace(/\s+/g, "").toLowerCase() + quantity
    }`;
    let url = [];

    //Accessing data from database
    const { ProductImageUrl } = await productModel.findById(id);

    //Deleting Existing files uploaded to storage
    let isDeleteSucess = [];
    try {
      for (let deleteValue of ProductImageUrl) {
        const deleteObj = ref(
          storage,
          `LiquorProductPhoto/${deleteValue.name}`
        );
        const deleteConfrm = await deleteObject(deleteObj);
        if (deleteConfrm) {
          isDeleteSucess.push(deleteConfrm);
          res.send(`Error in Deleting Existing file ${deleteConfrm}`);
        }
      }
    } catch (error) {
      res.send(`Error in Deleting Existing Data ${error}`);
    }

    //Updating new files to Storage
    if (isDeleteSucess.length === 0) {
      for (let [index, uploadData] of req.files.entries()) {
        const storageRef = ref(
          storage,
          `LiquorProductPhoto/${(uploadData.originalname =
            productValue + " " + "(" + index + ")")}`
        );
        const metaData = {
          contentType: uploadData.mimetype,
        };
        const snapShot = await uploadBytesResumable(
          storageRef,
          uploadData.buffer,
          metaData
        );
        const downloadRef = await getDownloadURL(snapShot.ref);
        url.push({
          name: `${productValue + " " + "(" + index + ")"}`,
          url: downloadRef,
        });
      }
    } else {
      res.send(`Delete not Successfull ${isDeleteSucess}`);
    }

    //Updating Data in Database
    const update = {
      ProductName: productName,
      ProductPrice: productPrice,
      ProductValue: productValue,
      ProductImageUrl: url,
      Quantity: quantity,
      EDP: EDP,
      ProductCode: productCode,
      Proof: proof,
      BrandName: brandName,
      Category: category,
    };
    const updateAck = await productModel.updateOne(
      { _id: id },
      { $set: update }
    );
    if (updateAck.modifiedCount === 1) {
      let updatedData = await productModel.findById(id);
      res.send(updatedData);
    } else {
      res.send(`Failed to update data to database`);
    }
  } catch (error) {
    console.log(`Error in Updating Product ${error}`);
  }
};

//Delete Product
const deleteProduct = async (req, res) => {
  try {
    const id = req.query.id;

    //Checking if the id is valid
    if (isValidObjectId(id)) {
      //Checking the Data Exists and Proceed
      const isExists = await productModel.findById(id);
      if (isExists) {
        const isDeleteSucess = [];

        //Deleteing files in storage
        for (let deleteValue of isExists.ProductImageUrl) {
          const deleteObj = ref(
            storage,
            `LiquorProductPhoto/${deleteValue.name}`
          );
          const deletAck = await deleteObject(deleteObj);
          if (deletAck) {
            isDeleteSucess.push(deletAck);
          }
        }
        if (isDeleteSucess.length === 0) {
          const deleteAck = await productModel.deleteOne({ _id: id });
          if (deleteAck.deletedCount === 1) {
            const restData = await productModel.find();
            res.send(restData);
          } else {
            res.send(`Error in Deleting the Data`);
          }
        } else {
          res.send(`Error in deleting the File from the storage`);
        }
      } else {
        res.send(`Error, Data not Exists`);
      }
    } else {
      res.send(`Object id is not valid`);
    }
  } catch (error) {
    console.log(`Error in Deleting Product ${error}`);
  }
};

//////////////////////////////////////DASHBOARD CONTROLS////////////////////////////////////
const getAllProduct = async (req, res) => {
  try {
    const allProduct = await productModel.find({});
    if (allProduct.length > 0) {
      res.status(200).json(allProduct);
    } else {
      res.status(400).send("No data Found");
    }
  } catch (error) {
    console.log(error);
  }
};

module.exports = {
  createProduct,
  getProductLIst,
  updateProduct,
  deleteProduct,
  getAllProduct,
};
