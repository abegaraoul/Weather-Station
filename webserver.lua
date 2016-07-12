arr={0,0,0,0,-1,0}
if srv==nil then
srv=net.createServer(net.TCP) 
srv:listen(80,function(conn)
   conn:on("receive",function(conn,payload)
   --print(payload) -- for debugging only
   strstr={string.find(payload,"GET / HTTP/1.1")}
   if(strstr[1]~=nil)then
   --generate the measurement string from arr list of measurements
   --create an empty string
   values_string="Measurements:"
   --print("SERVER RESPOND... ")     
   for i,v in ipairs(arr) do
      --concatenate measurements into a string
       --print("values_string is  "..v.."") --for debugging
      values_string=values_string .. v .. ","
     -- print(""..values_string.."")
   end
   end
   local winddir=""..arr[6].."";
   local j;
   if winddir==0 then 
         j="0° EAST"; 
   elseif winddir=="23" then
         j="23° EAST NORTH EAST"; 
   elseif winddir == "45" then
         j="45° NORTH EAST"; 
   elseif winddir=="68" then 
         j="68° NORTH NORTH EAST"; 
   elseif winddir=="90" then
         j="90° NORTH"; 
   elseif winddir=="113" then 
         j="113° NORTH NORTH WEST"; 
   elseif winddir=="135" then 
         j="135° NORTH WEST";  
   elseif winddir=="158" then
         j="158° WEST NORTH WEST"; 
   elseif winddir=="180" then
         j="180° WEST"; 
   elseif winddir=="203" then
         j="203° WEST SOUTH WEST"; 
   elseif winddir=="225" then 
         j="225° SOUTH WEST"; 
   elseif winddir=="248" then 
         j="248° SOUTH SOUTH WEST"; 
   elseif winddir=="270" then 
         j="270° SOUTH"; 
   elseif winddir=="293" then 
         j="293° SOUTH SOUTH EAST"; 
   elseif winddir=="315" then 
         j="315° SOUTH EAST"; 
   elseif winddir=="338" then 
         j="338° EAST SOUTH EAST"; 
   else
         j="notconnected";
   end
   
  
    -- print(j)
    -- print(winddir)       
   --generates HTML web site, autorefreshes at 1s interval, prints measurements
   conn:send("HTTP/1.1 200 OK\r\nConnection: keep-alive\r\nCache-Control: private, no-store\r\n\r\n")
   conn:send("<!DOCTYPE HTML>")
   conn:send("<html><head><meta content='text/html;charset=utf-8'>")
   conn:send("<title>DESIGN PROJECT</title><meta http-equiv='refresh' content='30' />")
   conn:send("<script type='text/javascript' src='https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js'></script>")
   conn:send("<script type='text/javascript'>")
   conn:send("$(function() {")
  conn:send("$(document).ready(function() {")
  conn:send("Highcharts.setOptions({global: {useUTC: false}});")
  conn:send("$('#container').highcharts({chart: {type: 'spline',")
  conn:send("animation: Highcharts.svg,")
  conn:send("marginRight: 10,events: {")
  conn:send("load: function() {")
  conn:send("var series = this.series[0];")
  conn:send("var series1 = this.series[1];")
  conn:send("setInterval(function() {var x = (new Date()).getTime(),") 
  conn:send("y ="..arr[2]..";series.addPoint([x, y], true, true);")
  conn:send("var x = (new Date()).getTime(),")
  conn:send(" k ="..arr[3]..";series1.addPoint([x, k], true, true);}, 1000);}}},")
  conn:send("title: {text: 'Temperature And Humidity'},")
  conn:send("xAxis: {type: 'datetime',tickPixelInterval:75},")
  conn:send("yAxis: {title: {text: 'Value'},plotLines: [{value: 0,width: 1,color: '#808080'}]},")
  conn:send("tooltip: {formatter: function() {")
  conn:send("return '<b>' + this.series.name + '</b><br/>' +")
  conn:send("Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +")
  conn:send("Highcharts.numberFormat(this.y, 2);}},")
  conn:send("legend: {enabled: false},exporting: {enabled: false},")
  conn:send("series: [{name: 'Relative Humidity',data: (function() {")
  conn:send("var data = [],time = (new Date()).getTime(),i;")
  conn:send("for (i = -19; i <= 0; i += 1) {")
  conn:send("data.push({x: time + i * 1000,y:"..arr[2].."});}")
  conn:send("return data;}())}, {name: 'Temperature',data: (function() {")
  conn:send("var data1 = [],time = (new Date()).getTime(),i;")
  conn:send("for (i = -19; i <= 0; i += 1) {data1.push({x: time + i * 1000,")
  conn:send("k: "..arr[3].."});}")
  conn:send("return data1;}())}]});});});")
  conn:send("</script>")
  conn:send("</head>")
  conn:send("<body background='http://www.senseaboutscience.org/data/images/weather.jpg' style='color:white;'>")
  conn:send("<section><center>")
  conn:send(" <h1> UNIVERSITY OF BUEA </h1>")
  conn:send(" <h2>COLLEGE OF TECHNOLOGY</h2>")
  conn:send("<h2>COMPUTER ENGINEERING</h2>")
  conn:send("<h3>PRESENTED BY NKOUDOU ABEGA SIMON RAOUL</h3>")
  conn:send("<section style='border:1px solid black;'>")
  conn:send("<h2>HUMIDITY : "..arr[2].." %</h2>")
  conn:send("<h2>TEMPERATURE : "..arr[3].." °C</h2>")
  conn:send("<h2>HEAT INDEX : "..arr[4].." °C</h2>")
  conn:send("<h2>WIND SPEED : "..arr[5].." km/h</h2>")
  conn:send("<h2>WIND DIRECTION : "..j.."</h2>")
  conn:send("<h2>AMOUNT OF RAIN FALL : "..arr[7].." mm</h2>")
  conn:send("<script type='text/javascript' src='https://code.highcharts.com/highcharts.js'></script>")
  conn:send("<div id='container' style='width: 400px; height: 300px;'></div>")
  conn:send("</section>")
  conn:send("<footer>")
  conn:send("<p>COLLEGE OF TECHNOLOGY 2015/2016 ACADEMIC YEAR</p>")
  conn:send("<p>PROJECT SUPERVISORS:</p>")
  conn:send(" <p> MR. TCHIMMOUE GABY ERIC</p>")
  conn:send(" <p> MR. TCHAPGA CHRISTIAN</p>")
  conn:send("</footer></center></section>")
  conn:send("</body></html>")
  
  conn:on("sent",function(conn) conn:close() end)
end)
end)
end

