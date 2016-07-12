--wifi.setmode(wifi.STATIONAP)
-- Declare configuration variable
--cfg={}
--cfg.ssid="SSID"
--cfg.pwd="password"
-- Pass to access point and configure
--wifi.ap.config(cfg)

wifi.setmode(wifi.STATION)
wifi.sta.config("COT","12345678")

--setup baudrate
uart.setup(0,9600,8,0,1)
--3s delay before starting with the program, sufficient break execution if needed
--tmr.alarm(0,3000,0,function() dofile("init2.lua") end)
tmr.alarm(0,1000,0,function() dofile("webserver.lua") end)
print(wifi.sta.getip())
