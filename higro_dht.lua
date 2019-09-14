LED1=0
OUT1=1
OUT2=2
DHT=3
BTN1=6
BTN2=7

gpio.mode(LED1, gpio.OUTPUT)
gpio.mode(OUT1, gpio.OUTPUT)
gpio.mode(OUT2, gpio.OUTPUT)
gpio.mode(DHT, gpio.INPUT)
gpio.mode(BTN1, gpio.INPUT)
gpio.mode(BTN2, gpio.INPUT)

function ADC()
	
end