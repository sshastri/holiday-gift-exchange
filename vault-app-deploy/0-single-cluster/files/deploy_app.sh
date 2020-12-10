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

  <center><h2>Grinch Holiday Gift Exchange</h2></center>
  <center><img width=300 src="./grinch.png"></img></center>
  
 <center><h3>powered by <a href="https://grinch.is.very-serious.business:8200/"> Vault</a></h3></center>

<!-- Live dashboard-->

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}

.tg td {
  font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;
  padding:10px 10px;
  word-break:normal;
}
  
.tg th {
  font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;
}

.tg .tg-73oq{border-color:#FFFFFF;text-align:left;vertical-align:top}

</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-73oq">People <br>(order to pick gift)</th>
    <th class="tg-73oq">Gifts to pick from</th>
    <th class="tg-73oq">Gift available for steal</th>
    <th class="tg-73oq">Locked</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-73oq">Shobhna<br>Mom<br>Jason</td>
    <td class="tg-73oq">sshastri<br>mom<br>jason </td>
    <td class="tg-73oq"><a href="https://www.amazon.com/dp/B075D9G69J/ref=cm_gf_aAN_i3_d_bt30_p0_qd0_H5h7t0Xk82gAytvu8sD9" target="_blank" rel="noopener noreferrer"><span style="color:#905">socks</span></a></td>
    <td class="tg-73oq"><a href="https://www.amazon.com/dp/B075D9G69J/ref=cm_gf_aAN_i3_d_bt30_p0_qd0_H5h7t0Xk82gAytvu8sD9" target="_blank" rel="noopener noreferrer"><span style="color:#905">candy</span></a></td>
  </tr>
</tbody>
</table>


  </div>
  </body>
</html>
EOM

echo "Script complete."