const { isValidObjectId } = require("mongoose");
const StateModel = require("../models/state");

//Creating State
const createState = async (req, res) => {
  try {
    const { StateName } = req.body;
    const distValue = StateName.toLowerCase();

    //checking the data exists
    const isExist = await StateModel.findOne({ StateValue: distValue });

    if (isExist) {
      res.status(400).json({ message: "State Exists" });
    } else {
      const savedState = await new StateModel({
        StateName: StateName,
        StateValue: distValue,
      }).save();
      const { createdAt, updatedAt, __v, ...stateDataToSend } = savedState._doc;
      res.status(200).json(stateDataToSend);
    }
  } catch (error) {
    console.log(`Error in creating State${error}`);
  }
};

//Listing States
const listStates = async (req, res) => {
  try {
    const StatesList = await StateModel.find({}, { StateName: 1, _id: 1 });

    if (StatesList.length > 0) {
      res.status(200).send(StatesList);
    } else {
      res.status(404).json({ msg: "States Not Added" });
    }
  } catch (error) {
    console.log(`Error in Listing States ${error}`);
  }
};

//Updating States
const updateStates = async (req, res) => {
  try {
    const id = req.query.id;
    const { StateName } = req.body;

    //Adding State Value
    const update = {
      StateName: StateName,
      StateValue: StateName.toLowerCase(),
    };

    //updating based on id valid
    if (isValidObjectId(id)) {
      const updateAcknowledgment = await StateModel.updateOne(
        { _id: id },
        { $set: update }
      );
      if (updateAcknowledgment.modifiedCount === 1) {
        let updatedData = await StateModel.findById(id, {
          StateName: 1,
        });
        res.status(200).json(updatedData);
      } else {
        res.send(`Error in Updating Data. Check the data exists`);
      }
    } else {
      res.status(400).json({ message: `Data not Found` });
    }
  } catch (error) {
    console.log(`Error in updating States ${error}`);
  }
};

//Deleting States
const deleteStates = async (req, res) => {
  const id = req.query.id;

  //Checking the id valid
  if (isValidObjectId(id)) {
    const deleteAcknowledgment = await StateModel.deleteOne({ _id: id });
    if (deleteAcknowledgment.deletedCount === 1) {
      const restData = await StateModel.find({}, { StateName: 1, _id: 1 });
      res.status(200).json(restData);
    } else {
      res.json({ message: `Can't find the data` });
    }
  } else {
    res.send(`Data Id not Valid`);
  }
};

module.exports = {
  createState,
  listStates,
  updateStates,
  deleteStates,
};
