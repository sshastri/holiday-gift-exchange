#!/bin/bash
# Script to deploy a very simple web application.
# The web app has a customizable image and some text.

mv /home/ec2-user/grinch.png /var/www/html

cat << EOM > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Grinch Holiday Gift Exchange</title>
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Rock+Salt&display=swap" rel="stylesheet">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
  * {
    box-sizing: border-box;
  }

  body {
    margin: 0;
    font-family: 'Rock Salt', cursive;
  }
  

  /* Style the header */
  .header {
    background-color: #f1f1f1;
    padding: 20px;
    text-align: center;
  }

  /* Style the top navigation bar */
  .topnav {
    overflow: hidden;
    background-color: #333;
  }

  /* Style the topnav links */
  .topnav a {
    float: left;
    display: block;
    color: #f2f2f2;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
  }

  /* Change color on hover */
  .topnav a:hover {
    background-color: #ddd;
    color: black;
  }

  /* Create four equal columns that floats next to each other */
  .column {
    float: left;
    width: 25%;
    padding: 15px;
  }

  /* Clear floats after the columns */
  .row:after {
    content: "";
    display: table;
    clear: both;
  }

  /* Responsive layout - makes the three columns stack on top of each other instead of next to each other */
  @media screen and (max-width:600px) {
    .column {
      width: 100%;
    }
  }
  </style>
</head>
<body>

<center><h2>Grinch Holiday Gift Exchange</h2></center>
<center><img width=300 src="./grinch.png"></img></center>

<center><h3>powered by <a href="https://grinch.is.very-serious.business:8200/"> Vault</a></h3></center>

<div class="header">
  <h1>Grinch Exchange Dashboard</h1>
  <!-- <p>Resize the browser window to see the responsive effect.</p> -->
</div>

<!-- <div class="topnav">
  <a href="#">Link</a>
  <a href="#">Link</a>
  <a href="#">Link</a>
   <a href="#">Link</a>
</div> -->

<div class="row">
  <div class="column">
    <h2>Whos from Whoville</h2>
    <p>a<br>b<br>c<br></p>
  </div>
  
  <div class="column">
    <h2>Unopened Gifts</h2>
    <p>a<br>b<br>c<br></p>
  </div>
  
  <div class="column">
    <h2>Open Gifts in Play</h2>
    <p>a<br>b<br>c<br></p>
  </div>
  
  <div class="column">
    <h2>No More Steals</h2>
    <p>a<br>b<br>c<br></p>
  </div>
</div>


</body>
</html>
EOM

echo "Script complete."