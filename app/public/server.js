const express = require("express");
const app = express();

app.use(express.static("public"));

app.get("/upload", (req,res)=>{
res.send("Upload photo and change background");
});

app.listen(3000, ()=>{
console.log("Photo App running");
});