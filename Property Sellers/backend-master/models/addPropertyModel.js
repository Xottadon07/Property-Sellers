const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const newSchema = new Schema({
  title: { type: String, default: "" },
  price: { type: String, default: "" },
  area: { type: String, default: "" },
  description: { type: String, default: "" },
  location: { type: String, default: "" },
  purpose: { type: String, default: "" },
  category: { type: String, default: "" },
  image: { type: String, default: "" },
  user: {type: mongoose.Schema.Types.ObjectId, ref: "User", required: false,},
});

const Product = mongoose.model("Product", newSchema);
module.exports = Product;
