const express = require("express");
const { default: mongoose } = require("mongoose");
const Product = require("../models/addPropertyModel");
const Like = require("../models/likes");
const User = require("../models/userModel");

const router = express.Router();

router.get("/", async function (req, res) {
  try {
    const allProds = await Product.find({}).populate("user").exec();

    // allProds = await Promise.all(
    //   allProds.map(async function (p) {
    //     p.populate("user");
    //     await p.execPopulate();
    //     return p;
    //   })
    // );

    return res.json({ products: allProds });
  } catch (e) {
    return res.json({ error: e.toString() });
  }
});

router.post("/like/:productId/:userId", async function (req, res) {
  console.log(req.params);
  try {
    const user = await User.findById(req.params.userId);
    const product = await Product.findById(req.params.productId);

    if (!user || !product) throw new Error("User or product not found");

    const alreadyLiked = await Like.countDocuments({
      user: user._id,
      product: product._id,
    });

    if (alreadyLiked != 0) {
      return res.send({ alreadyLiked: true });
    } else {
      const like = await Like.create({ user: user._id, product: product._id });

      return res.send(like);
    }
  } catch (e) {
    return res.json({ error: e.toString() });
  }
});

router.get("/notifications/:userId", async function (req, res) {
  try {
    const products = await Product.find(
      { user: mongoose.Types.ObjectId(req.params.userId) },
      "_id"
    );

    const likes = await Like.find({
      product: { $in: products.map((p) => p._id) },
    }).populate("user product");

    return res.json(likes);
  } catch (e) {
    return res.json({
      error: e.toString(),
    });
  }
});

module.exports = router;
