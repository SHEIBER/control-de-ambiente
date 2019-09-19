LED1=0
OUT1=1
OUT2=2
DHT=3
BTN1=6
BTN2=7

val =0
porc=0
on=0

prove_tmr=tmr.create()
adc_tmr=tmr.create()

gpio.mode(LED1, gpio.OUTPUT)
gpio.mode(OUT1, gpio.OUTPUT)
gpio.mode(OUT2, gpio.OUTPUT)
gpio.mode(DHT, gpio.INPUT)
gpio.mode(BTN1, gpio.INPUT)
gpio.mode(BTN2, gpio.INPUT)

function ADC()--funcion de conversion de valores analogicos 1024=0% 0=100%
	val=adc.read(0)
	porc=100*(978-val)/val
	print(porc.."%")
	if porc>=75 then
		prove_tmr:stop()
	else
		prove_tmr:start()
	end
end

function parpadeo()--funcion de parpadeo para comprobar funcionamiento de circuito
	if on==0 then
		gpio.write(LED1, gpio.HIGH)
		on=1
	else
		gpio.write(LED1, gpio.LOW)
		on=0
	end
end

prove_tmr:alarm(100,tmr.ALARM_AUTO,parpadeo)--inicia parpadeo cada 100ms 
wifi.setmode(wifi.STATION)

adc_tmr:alarm(2000,tmr.ALARM_AUTO,ADC)

