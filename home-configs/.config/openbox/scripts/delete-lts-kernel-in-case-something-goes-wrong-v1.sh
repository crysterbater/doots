#!/bin/bash
#
##################################################################################################################
# Written to be used on 64 bits computers
# Author 	: 	Erik Dubois
# Website 	: 	http://www.erikdubois.be
##################################################################################################################
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

echo "Do not just run this. Examine and judge. Run at own risk."
echo
echo "Press enter to continue"; read dummy;

package="linux-lts"


#----------------------------------------------------------------------------------

#checking if application is already installed or else install with aur helpers
if pacman -Qi $package &> /dev/null; then



	#checking which helper is installed
	if pacman -Qi packer &> /dev/null; then

		echo "Installing with packer"
		sudo pacman -R --noconfirm $package
			  	
	fi

	# Just checking if installation was successful
	if pacman -Qi $package &> /dev/null; then
	
	echo "################################################################"
	echo "#########  "$package" has NOT been uninstalled"
	echo "################################################################"

	else

	echo "################################################################"
	echo "#########  "$package" has been uninstalled"
	echo "################################################################"

	fi


else

	echo "################################################################"
	echo "######### "$package" is already uninstalled"
	echo "################################################################"

fi


package="linux-lts-headers"


#----------------------------------------------------------------------------------

#checking if application is already installed or else install with aur helpers
if pacman -Qi $package &> /dev/null; then



	#checking which helper is installed
	if pacman -Qi packer &> /dev/null; then

		echo "Installing with packer"
		sudo pacman -R --noconfirm $package
			  	
	fi

	# Just checking if installation was successful
	if pacman -Qi $package &> /dev/null; then
	
	echo "################################################################"
	echo "#########  "$package" has NOT been uninstalled"
	echo "################################################################"

	else

	echo "################################################################"
	echo "#########  "$package" has been uninstalled"
	echo "################################################################"

	fi


else

	echo "################################################################"
	echo "######### "$package" is already uninstalled"
	echo "################################################################"

fi


echo "This script assumes you have a /dev/sda - Press ENTER to continue or CTRL + C to halt"; read dummy;

sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "reboot"