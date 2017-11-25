#*###########################################################################*
#                   Copyright (C) 2015  LinArch                             #
#									    #
#    This program is free software: you can redistribute it and/or modify   #
#    it under the terms of the GNU General Public License as published by   #
#    the Free Software Foundation, either version 3 of the License, or      #
#    (at your option) any later version.				    #
#									    #
#    This program is distributed in the hope that it will be useful,        #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of         #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          #
#    GNU General Public License for more details.		            #
#									    #
#    You should have received a copy of the GNU General Public License      #
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.  #
#*###########################################################################*

############################################################################*
##             Iranian Arch Users Conky(I.AUC.ver2)                        ##
##             Developed By:          LinArch                              ##
##	       Visit Me:           www.stack.blog.ir                       ##
##             Visit Us:          www.bbs.archusers.ir                     ##
##             Conky-Tut:					           ##
##             Lua-Tut:                                                    ##
############################################################################*
#!/bin/bash
#to call a function from bash use this pattern:
#source bashScript.sh;funcName
#for example:if the script name is service and the function is test so:
#source weather.sh;test

#Wheather API
#Wunderground.com----http://api.wunderground.com/api/26115e7fb6edfe1b/conditions/q/iran/.xmlns

function location ()
{
#	source redis-bash-lib # include the library
#	exec 6<>/dev/tcp/localhost/6379 # open the connection
#	city=Orumiyeh # do a SET operation
#	exec 6>&- # close the connection
	curl -s "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20%28select%20woeid%20from%20geo.places%281%29%20where%20text%3D%22Orumiyeh%2Cir%22%29&format=xml&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys" -o ~/.cache/weather.xml
}

function country ()
{
grep "yweather:location" ~/.cache/weather.xml | grep -o "country=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*"
}

function city ()
{
grep "yweather:location" ~/.cache/weather.xml | grep -o "city=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*"
}

wind ()
{
M=$(grep "yweather:wind" ~/.cache/weather.xml | grep -o "speed=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | tail -1);
awk "BEGIN {printf \"%.0f\n\", ($M*0.44704)}";
}

humidity ()
{
grep "yweather:atmosphere" ~/.cache/weather.xml | grep -o "humidity=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*"
}

atmosphere()
{
grep "yweather:atmosphere" ~/.cache/weather.xml | grep -o "humidity=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*"
}

sunrise()
{
grep "yweather:astronomy" ~/.cache/weather.xml | grep -o "sunrise=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*"
}

sunset()
{
grep "yweather:astronomy" ~/.cache/weather.xml | grep -o "sunset=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*"
}

status1 ()
{
grep "yweather:condition" ~/.cache/weather.xml | grep -o "text=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | tr '[a-z]' '[A-Z]' | awk 'NR==1'
}

todayTemp ()
{
F=$(grep "yweather:condition" ~/.cache/weather.xml | grep -o "temp=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*");
awk "BEGIN {printf \"%.0f\n\", ($F-32)*5/9}";
}

dayHigh1()
{
F=$(grep "yweather:forecast" ~/.cache/weather.xml | grep -o "high=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==1');
awk "BEGIN {printf \"%.0f\n\", ($F-32)*5/9}";
}

dayHigh2()
{
F=$(grep "yweather:forecast" ~/.cache/weather.xml | grep -o "high=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==2');
awk "BEGIN {printf \"%.0f\n\", ($F-32)*5/9}";
}

dayHigh3()
{
F=$(grep "yweather:forecast" ~/.cache/weather.xml | grep -o "high=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==3');
awk "BEGIN {printf \"%.0f\n\", ($F-32)*5/9}";
}

dayHigh4()
{
F=$(grep "yweather:forecast" ~/.cache/weather.xml | grep -o "high=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==4');
awk "BEGIN {printf \"%.0f\n\", ($F-32)*5/9}";
}

dayHigh5()
{
F=$(grep "yweather:forecast" ~/.cache/weather.xml | grep -o "high=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==5');
awk "BEGIN {printf \"%.0f\n\", ($F-32)*5/9}";
}

dayHigh6()
{
F=$(grep "yweather:forecast" ~/.cache/weather.xml | grep -o "high=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==6');
awk "BEGIN {printf \"%.0f\n\", ($F-32)*5/9}";
}

dayLow1()
{
F=$(grep "yweather:forecast" ~/.cache/weather.xml | grep -o "low=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==1');
awk "BEGIN {printf \"%.0f\n\", ($F-32)*5/9}";
}

dayLow2()
{
F=$(grep "yweather:forecast" ~/.cache/weather.xml | grep -o "low=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==2');
awk "BEGIN {printf \"%.0f\n\", ($F-32)*5/9}";
}

dayLow3()
{
F=$(grep "yweather:forecast" ~/.cache/weather.xml | grep -o "low=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==3');
awk "BEGIN {printf \"%.0f\n\", ($F-32)*5/9}";
}

dayLow4()
{
F=$(grep "yweather:forecast" ~/.cache/weather.xml | grep -o "low=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==4');
awk "BEGIN {printf \"%.0f\n\", ($F-32)*5/9}";
}

dayLow5()
{
F=$(grep "yweather:forecast" ~/.cache/weather.xml | grep -o "low=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==5');
awk "BEGIN {printf \"%.0f\n\", ($F-32)*5/9}";
}

dayLow6()
{
F=$(grep "yweather:forecast" ~/.cache/weather.xml | grep -o "low=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==6');
awk "BEGIN {printf \"%.0f\n\", ($F-32)*5/9}";
}

day1 ()
{
grep "yweather:forecast" ~/.cache/weather.xml | grep -o "code=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==1'
}


day2 ()
{
grep "yweather:forecast" ~/.cache/weather.xml | grep -o "code=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==2'
}

day3 ()
{
grep "yweather:forecast" ~/.cache/weather.xml | grep -o "code=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==3'
}

day4 ()
{
grep "yweather:forecast" ~/.cache/weather.xml | grep -o "code=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==4'
}

day5 ()
{
grep "yweather:forecast" ~/.cache/weather.xml | grep -o "code=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==5'
}

day6 ()
{
grep "yweather:forecast" ~/.cache/weather.xml | grep -o "code=\"[^\"]*\"" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | awk 'NR==6'
}

procName1 ()
{
ps -aux | sort -k3 | tail -6 | awk 'NR==5' | awk -F ' ' '{print $11}' 
}

procName2 ()
{
ps -aux | sort -k3 | tail -6 | awk 'NR==4' | awk -F ' ' '{print $11}' 
}

procName3 ()
{
ps -aux | sort -k3 | tail -6 | awk 'NR==3' | awk -F ' ' '{print $11}' 
}

procName4 ()
{
ps -aux | sort -k3 | tail -6 | awk 'NR==2' | awk -F ' ' '{print $11}' 
}

procName5 ()
{
ps -aux | sort -k3 | tail -6 | awk 'NR==1' | awk -F ' ' '{print $11}' 
}

proc1 ()
{
ps -aux | sort -k3 | tail -6 | awk 'NR==5' | awk -F ' ' '{print $3}' 
}

proc2 ()
{
ps -aux | sort -k3 | tail -6 | awk 'NR==4' | awk -F ' ' '{print $3}' 
}

proc3 ()
{
ps -aux | sort -k3 | tail -6 | awk 'NR==3' | awk -F ' ' '{print $3}' 
}

proc4 ()
{
ps -aux | sort -k3 | tail -6 | awk 'NR==2' | awk -F ' ' '{print $3}' 
}

proc5 ()
{
ps -aux | sort -k3 | tail -6 | awk 'NR==1' | awk -F ' ' '{print $3}' 
}

allModules ()
{
systemctl list-units -t service --all | wc -l 
}

failedModules ()
{
systemctl list-units -t service --failed | wc -l
}

moduleName1(){
systemd-analyze blame | awk 'NR==1' | awk -F ' ' '{print $2}' | awk -F '@' '{print $1}'
}

moduleName2(){
systemd-analyze blame | awk 'NR==2' | awk -F ' ' '{print $2}' | awk -F '@' '{print $1}'
}

moduleName3(){
systemd-analyze blame | awk 'NR==3' | awk -F ' ' '{print $2}' | awk -F '@' '{print $1}'
}

moduleName4(){
systemd-analyze blame | awk 'NR==4' | awk -F ' ' '{print $2}' | awk -F '@' '{print $1}'
}

moduleName5(){
systemd-analyze blame | awk 'NR==5' | awk -F ' ' '{print $2}' | awk -F '@' '{print $1}'
}

moduleTime1(){
systemd-analyze blame | awk 'NR==1' | awk -F ' ' '{print $1}' 
}

moduleTime2(){
systemd-analyze blame | awk 'NR==2' | awk -F ' ' '{print $1}' 
}

moduleTime3(){
systemd-analyze blame | awk 'NR==3' | awk -F ' ' '{print $1}' 
}

moduleTime4(){
systemd-analyze blame | awk 'NR==4' | awk -F ' ' '{print $1}' 
}

moduleTime5(){
systemd-analyze blame | awk 'NR==5' | awk -F ' ' '{print $1}' 
}

miToKm()
{
mi=0.62137 km;
}

inToCm()
{
1 inches= 2.54 centimeter;
}

getsize()
{
	wgetlogs=$(wget --spider $(pacman -Sup) 2> /tmp/output_wget_spider 2>&1 )
	awk '/^Length/ {print $2}' <<< "$wgetlogs"
}

nextUpdate()
{
getsize  > /tmp/size
total=$(awk '{sum+=$1} END {print sum}' /tmp/size)
if [ -s /tmp/size ]; then
	if [ ${#total} -le 3 ];then
		{ echo "$total" | cut -c1-3; echo "Byte"; } | sed -e 'N;s/\n/ /'
	elif [ ${#total} -gt 3 ] && [ ${#total} -le 6 ];then
		{ echo "$total" | cut -c1-3; echo "KB"; } | sed -e 'N;s/\n/ /'
	elif [ ${#total} -gt 6 ] && [ ${#total} -le 9 ];then
		{ echo "$total" | cut -c1-3; echo "MB";echo "+";echo "$total" | cut -c4-6;echo "KB"; } | sed ':a;N;$!ba;s/\n/ /g'
	elif [ ${#total} -gt 9 ] && [ ${#total} -le 12 ];then
		{ echo "$total" | cut -c1-3; echo "GB";echo "+";echo "$total" | cut -c4-6;echo "MB";echo "+";echo "$total" | cut -c7-9;echo "KB"; } | sed ':a;N;$!ba;s/\n/ /g'
	fi
else 
	echo "No updates."
fi
}

myAurHelpers()
{
aur_helper=("apacman" "aura" "aurelaurget" "aurquery" "aurutils" "bauerbill" "burgaur" "cower" "pacaur" "packer" "pbget" "pkgbuilder" "prm" "trizen" "wrapaur" "yaah" "yaourt")
for i in ${aur_helper[*]}; do
  if [ -f "/usr/bin/$i" ]; then
   echo "$i"
  fi 
done
}

showInstalledVGADrivers()
{
	echo $(xrandr --listproviders | awk '{print $(NF)}' | tail -2 | sed ':a;N;$!ba;s/\n/+/g' | sed -e 's/name://g')
}

showVGA()
{
	echo $(lspci | grep VGA | cut -d" " -f5 | sed ':a;N;$!ba;s/\n/+/g')
}

showVGAmodel()
{
	#echo $(lspci | grep VGA | tail -1 | awk -F '[' '{print $2}' | cut -d"]" -f1)
	(echo $(lspci | grep VGA | cut -d" " -f5 | tail -1); echo $(lspci | grep VGA | tail -1 | awk -F '[' '{print $2}' | cut -d"]" -f1)) | sed ':a;N;$!ba;s/\n/ /g'
}

dayDiff()
{
	todaySecond=$(date -d "$date" +"%s")
	installTime=$(ls -ld /lost+found | awk '{print $6, $7, $8}')
	installTimeSecond=$(date -d "$installTime" +"%s")
	ageSecond=$((todaySecond - installTimeSecond))
    alldays=$((ageSecond / 86400 ))
    monthfirst=$((alldays/30))
    year=$((monthfirst/12))
    month=$((monthfirst%12))
    day=$((alldays%30))
    echo "$year year,$month month,$day day"
}
 
whichGraphicCard()
{
	prefix="\e[1;31m"
	postfix="\e[0m"
string=$(DRI_PRIME=1 glxinfo|grep 'OpenGL renderer')
if [[ $string == *Intel* ]];then
  echo "Intel";
else
	echo $(xrandr --listproviders | awk '{print $(NF)}' | tail -2 | sed ':a;N;$!ba;s/\n/+/g' | sed -e 's/name://g' | cut -d"+" -f2)
fi
}

whichInterface()
{
	interface=$(ifconfig | grep "RUNNING" | grep "BROADCAST" | awk '{print $(1F)}' | cut -d":" -f1)
	# echo "export INTERFACE=$interface" >> ~/.bashrc
	sed -i -- "s/wlp3s0/$interface/g" "../.conkyrc"

}
