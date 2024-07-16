const { isValidObjectId } = require("mongoose");
const ShopModel = require("../models/shop");

//////////////////////////Shop List Retriving Handler
const getShopList = async (req, res) => {
  try {
    const shopType = req.params.shopType;
    const Shops = await ShopModel.find(
      { Shop_Type: shopType },
      { _id: 0, createdAt: 0, updatedAt: 0, __v: 0 }
    );

    if (Shops.length < 1) {
      res.status(400).send("No Shops Added in this shop type");
    } else {
      res.status(200).json(Shops);
    }
  } catch (error) {
    console.log(error);
  }
};

//////////////////////////Create Shop List Handler
const createShopList = async (req, res) => {
  try {
    const { name, address, latitude, longitude, category, shopType, state } =
      req.body;
    const NameToLower = name.toLowerCase();
    const isExist = await ShopModel.findOne({
      $and: [{ Name_Lower: NameToLower }, { Category: category }],
    });

    if (isExist) {
      res.status(401).send("Already Exists");
    } else {
      const SavedShop = await new ShopModel({
        Name: name,
        Name_Lower: NameToLower,
        Address: address,
        Latitude: latitude,
        Longitude: longitude,
        Category: category,
        Shop_Type: shopType,
        State: state,
      }).save();

      res.status(200).json(SavedShop);
    }
  } catch (error) {
    console.log(error);
  }
};

//////////////////////////Delete Shop
const deleteShop = async (req, res) => {
  try {
    const shopId = req.query.id;
    if (isValidObjectId(shopId)) {
      const deleteAcknowlodgment = await ShopModel.deleteOne({ _id: shopId });
      if (deleteAcknowlodgment.deletedCount === 1) {
        const restData = await ShopModel.find({});
        res.status(200).json(restData);
      } else {
        res.status(400).send(`Can't find the data`);
      }
    } else {
      res.status(400).send("No valid Shop id");
    }
  } catch (error) {
    console.log(error);
  }
};

// ////////////////////////////////DataBase route Handler/////////////////////////
const getAllShopList = async (req, res) => {
  try {
    const shopList = await ShopModel.find({});
    if (shopList.length < 1) {
      res.status(400).send("No shops Available");
    } else {
      res.status(200).json(shopList);
    }
  } catch (error) {
    console.log(error);
  }
};

module.exports = { getShopList, createShopList, getAllShopList, deleteShop };
