#!/bin/bash
# Script to deploy a very simple web application.
# The web app has a customizable image and some text.

mv /home/ec2-user/grinch.png /var/www/html

cat << EOM > /var/www/html/index.html
<html>
  <head>
    <title>Grinch Holiday Gift Exchange</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Rock+Salt&display=swap" rel="stylesheet">
    
    <style>
      body {
        font-family: 'Rock Salt', cursive;
      }

      h1 {
        color: maroon;
        margin-left: 40px;
      }
    </style>
    
    
    
  </head>
  <body>
  <div style="width:800px;margin: 0 auto">
  <!-- BEGIN -->
  <center><img src="./grinch.png"></img></center>
  <center><h2>Grinch Holiday Gift Exchange powered by Vault</h2></center>

  <!-- END -->
  </div>
  </body>
</html>
EOM

echo "Script complete."