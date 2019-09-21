LED1=0--led indicador de estado
OUT1=1
OUT2=2
dht11=3--se conecta a este pin el sensor DHT11
BTN1=6
BTN2=7

val =0--valor de lectura del ADC
porc=0--aca se guarda el procentaje de lectura del ADC 1024=0% 0=100%
on=0--variable usada para el parpadeo

prove_tmr=tmr.create()--timer de secuencias de estado
adc_tmr=tmr.create()--timer para conversionde ADC

gpio.mode(LED1, gpio.OUTPUT)
gpio.mode(OUT1, gpio.OUTPUT)
gpio.mode(OUT2, gpio.OUTPUT)
gpio.mode(dht11, gpio.INPUT)
gpio.mode(BTN1, gpio.INPUT)
gpio.mode(BTN2, gpio.INPUT)

function ADC()--funcion de conversion de valores analogicos 1024=0% 0=100%
	val=adc.read(0)
	porc=100*(978-val)/val
	print(porc.."%/n")
	if porc>=75 then
		prove_tmr:stop()
	else
		prove_tmr:start()
	end
end

function DHT()
	stat,temp,hume,temp_dec,hume_dec=dht.read(dht11)
	if stat == dht.OK then
		print("Temperatura:"..temp.." Humedad:"..hume)
	elseif stat==dht.ERROR_CHECKSUM then
		print("checksum error")
	elseif stat==dht.ERROR_TIMEOUT then
		print("timeout error")
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

adc_tmr:alarm(3000,tmr.ALARM_AUTO,function()
	ADC()
	DHT()
end)

