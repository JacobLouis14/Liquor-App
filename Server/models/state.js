const mongoose = require("mongoose");

const StateSchema = new mongoose.Schema(
  {
    StateName: {
      type: String,
      min: 3,
      required: true,
    },
    StateValue: {
      type: String,
      min: 3,
      required: true,
    },
  },
  { timestamps: true }
);

const StateModel = mongoose.model("States", StateSchema);
module.exports = StateModel;
