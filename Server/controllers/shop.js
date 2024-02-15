const ShopModel = require("../models/shop");

//////////////////////////Shop List Retriving Handler
const getShopList = async (req, res) => {
  try {
    const Shops = await ShopModel.find(
      {},
      { _id: 0, createdAt: 0, updatedAt: 0, __v: 0 }
    );

    if (Shops.length < 1) {
      res.status(400).send("No Shops Added");
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
    const { name, address, latitude, longitude, category } = req.body;

    const NameToLower = name.toLowerCase();
    const isExist = await ShopModel.findOne({
      $and: [{ Name_Lower: NameToLower }, { Category: category }],
    });

    if (isExist) {
      res.status(401).send("Already Exists");
    } else {
      const SavedShop = await new ShopModel({
        Name: name,
        Name_Lower: name.toLowerCase(),
        Address: address,
        Latitude: latitude,
        Longitude: longitude,
        Category: category,
      }).save();

      res.status(200).send("Sucessfully Created");
    }
  } catch (error) {
    console.log(error);
  }
};

module.exports = { getShopList, createShopList };
