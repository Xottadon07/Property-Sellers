const express = require("express");
const User = require("../models/userModel");
const router = express.Router();
const multiparty = require("multiparty");
const Product = require("../models/addPropertyModel");
const { default: mongoose } = require("mongoose");

const IMAG_UPLOAD_DIR = "./images";
const IMAGE_BASE_URL = "http://192.168.30.54:8000/";
// for signup
router.post("/signup", (req, res) => {
  User.findOne({ email: req.body.email }, (err, user) => {
    if (err) {
      console.log(err);
      res.json(err);
    } else {
      if (user == null) {
        const user = User({
          username: req.body.username,
          password: req.body.password,
          phoneNumber: req.body.phoneNumber,
          email: req.body.email,
        });
        user.save().then((err) => {
          if (err) {
            console.log(err);
            res.status(404).json(err);
          } else {
            console.log(user);
            res.json(user);
          }
        });
      } else {
        res.json({
          message: "email is not available",
        });
      }
    }
  });
});

//for login
router.post("/login", (req, res) => {
  console.log(req.body);
  User.findOne(
    { username: req.body.username, password: req.body.password },
    (err, user) => {
      console.log(err);
      if (err) {
        console.log(err);
        res.status(400).json(err);
      } else {
        res.json(user);
      }
    }
  );
});
// get users detail
router.get("/login", async (req, res) => {
  try {
    const users = await User.find({});
    res.send(users);
  } catch (err) {
    res.send({ error: err.message });
  }
});
// //get added product
router.get("/user/:id", async (req, res) => {
  try {
    const user = await User.findOne({ _id: req.params.id });
    res.send(user);
  } catch (err) {
    console.log(err);
    res.send({ error: err.message });
  }
});
//post appi to ADD PROPERTY
router.post("/addProduct", async (req, res) => {
  try {
    let form = new multiparty.Form({ uploadDir: IMAG_UPLOAD_DIR });
    form.parse(req, async function (err, fields, files) {
      if (err) return res.send({ error: err.message });
      console.log(`fields = ${JSON.stringify(fields, null, 2)}`);
      console.log(`files = ${JSON.stringify(files, null, 2)}`);

      const imagePath = files.image[0].path;
      const imageFileName = imagePath.slice(imagePath.lastIndexOf("\\") + 1);
      imageUrl = IMAGE_BASE_URL + imageFileName;
      console.log(imageUrl);

      const product = new Product({
        title: fields.title[0],
        price: fields.price[0],
        area: fields.area[0],
        location: fields.location[0],
        description: fields.description[0],
        purpose: fields.purpose[0],
        category: fields.category[0],
        image: imageUrl,
  
      });
if(fields.user){
    product.user =  mongoose.Types.ObjectId(fields.user[0])
}

      const prod = await product.save();
      
const newProd = await Product.findOne({_id: prod._id}).populate("user").exec() ;

res.send(newProd)

    });
  } catch (err) {
    console.log(err);
    res.send({ err: err.message });
  }
});
module.exports = router;
