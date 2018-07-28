#!/bin/bash
INSTALLER_VERSION=7.0.34
TAP_IP_REGISTRY_FILE="/etc/tap_registry.txt"
INST_TYPE="/etc/TAP_REGISTRY/inst_type"
PATH_PARAM="PATH"
AGENT_TO_BE_UNINSTALLED=1.04
TAP=TAP
MULTI_TAP=0
UPGRADE_FLAG=0
CM_INSTALL_FLAG=false
FO_INSTALL_FLAG=false
CD_INSTALL_FLAG=false
SLBM_INSTALL_FLAG=false
RDM_INSTALL_FLAG=false

CM_UPGRADE_FLAG=0
FO_UPGRADE_FLAG=0
CD_UPGRADE_FLAG=0
SLBM_UPGRADE_FLAG=0
RDM_UPGRADE_FLAG=0

USER_ID=$(id -u)
if [ $USER_ID -ne 0 ];then
        echo "Kindly ensure TAP Installation is done using \"root\" login."
        exit
fi
ipo_mf=0
mkdir -p "/tmp/TAP_Setup_Files"
rm -f "/tmp/TAP_InstallationDetails.log"
touch "/tmp/TAP_InstallationDetails.log"
LOG="/tmp/TAP_InstallationDetails.log"

BROKER_ID_FILE="/tmp/brokerid_list.txt"
BROKER_ID_FILE_CM="/tmp/brokerid_list_cm.txt"
BROKER_ID_FILE_FO="/tmp/brokerid_list_fo.txt"
BROKER_ID_FILE_CD="/tmp/brokerid_list_cd.txt"
BROKER_ID_FILE_SLBM="/tmp/brokerid_list_slbm.txt"
BROKER_ID_FILE_RDM="/tmp/brokerid_list_rdm.txt"

#Used for storing the root directory of TAP
TAP_ROOT_DIRECTORY=

#It holds the Installation directory of TAP
InstallDir="/usr/bin/$TAP"

#It holds the TAP Registry directory path
REGISTRY_DIRECTORY="/etc/TAP_REGISTRY"
#It holds the registry file names present in the registry.
BROKER_ID_TEMP_FILE="/tmp/brokerid_temp.txt"

#It holds the TAP common registry file path
COMMON_FILE="$REGISTRY_DIRECTORY/common.txt"
PATH_PARAM="PATH"
ROOT_NAME=ROOT
COUNT_PARAM="COUNT"

SetupFilesPath="/tmp/TAP_Setup_Files"
mkdir -p "/tmp/TAP_Setup_Files"
if [ ! -d $SetupFilesPath ]; then
	echo "Cannot create SetupFilesPath directory." | tee -a $LOG
	exit
fi

Setup_zip_file="TAP_"$INSTALLER_VERSION"_SetupFiles.zip"
#Setup_zip_file="NOW_TAP_7.01_SetupFiles.zip"
unzip -o "$Setup_zip_file" -x -d $SetupFilesPath >> $LOG
value=$?
if [ $value -ne 0 ]; then
	echo "Cannot unzip $Setup_zip_file." | tee -a $LOG
	exit
fi

echo "All files extracted" >> $LOG
cd "$SetupFilesPath/exe"
chmod -R 777 "$SetupFilesPath" >> $LOG 2>> $LOG
echo "All permissions granted to Setup Files" >> $LOG

check_tap_mode() {

	#decide type of the installation 'Multi TAP' or 'Single TAP' 
	#based on the registry entry done by 'Register installer type' batch file.
	#check if TAP_IP Directory Strucure exists,check if CM,FO,CD,SLBM markets exist
	#If yes uninstall existing CM,FO,CD,SLBM markets
	live_cm_flag=0
	live_cd_flag=0
	live_fo_flag=0
	live_slbm_flag=0
	ipo_mf=0
	return_value=0
	 buffer=
	if [ -f $TAP_IP_REGISTRY_FILE ]; then

		#TAP_PATH reading
		./config_utility -sg $TAP_IP_REGISTRY_FILE $ROOT_NAME $PATH_PARAM
		value=$?		
		if [ $value -ne 0 ]; then
			echo "Reading of TAP_IP PATH failed. Return value: $value" | tee -a $LOG
			clean_up 0
		fi
		TAP_IP_PATH=`cat tap_val.txt`

			echo 
		# check if CM present
        ./config_utility -sg $TAP_IP_REGISTRY_FILE 1 $PATH_PARAM
         value=$?
          if [ $value -eq 0 ]; then
				#echo " CM Market"
				live_cm_flag=1
			  return_value=1
          fi
		# check if FO present
        ./config_utility -sg $TAP_IP_REGISTRY_FILE 2 $PATH_PARAM
         value=$?
          if [ $value -eq 0 ]; then
			#echo " FO market"
			live_fo_flag=1
			 return_value=1
          fi

		# check if CD present
        ./config_utility -sg $TAP_IP_REGISTRY_FILE 5 $PATH_PARAM
         value=$?
          if [ $value -eq 0 ]; then
			#echo " CD market"
			live_cd_flag=1
			  return_value=1
          fi
		 
		# check if SLBM present
        ./config_utility -sg $TAP_IP_REGISTRY_FILE 6 $PATH_PARAM
         value=$?
          if [ $value -eq 0 ]; then
			#echo " SLBM market"
			live_slbm_flag=1
			  return_value=1
          fi

		  #check if IPO or mf is installed 
         ./config_utility -sg $TAP_IP_REGISTRY_FILE 7 $PATH_PARAM
         value=$?
          if [ $value -eq 0 ]; then
			 ipo_mf=1
          fi

		  #check if IPO or mf is installed 
         ./config_utility -sg $TAP_IP_REGISTRY_FILE 4 $PATH_PARAM
         value=$?
          if [ $value -eq 0 ]; then
			 ipo_mf=1
          fi
		 
		 if [ $return_value -eq 1 ]; then
			#Currently Exit installation use function()
			echo "Please uninstall the below markets  " |tee -a $LOG
			if [ $live_cm_flag -eq 1 ]; then
                         echo " CM Market"
			 live_cm_flag=0
			fi

			if [ $live_fo_flag -eq 1 ]; then
                         echo " FO Market"
			 live_fo_flag=0
                        fi
			
			if [ $live_cd_flag -eq 1 ]; then
                         echo " CD Market"
                         live_cd_flag=0
                        fi
		
			if [ $live_slbm_flag -eq 1 ]; then
                         echo " SLBM Market"
                         live_slbm_flag=0 
		        fi

			echo 
			clean_up 0
		 fi
		
		if [ $ipo_mf -eq 1 ] ; then 
			echo "MF,IPO TAP will be started . " |tee -a $LOG
			echo -n "Press Y to continue and N to quit installation ? "
			read choice
			echo "$choice ">>$LOG
		case "$choice"
		in

			Y|y) echo "Continue installation :Yes " >>$LOG
			;;
			
			N|n) echo "Continue installation :NO " >>$LOG 
			     clean_up 0
			;;
			
			*) echo "Enter valid choice " |tee -a $LOG
			   clean_up 0
			;;
		esac
		fi
		 		if [ -f  /etc/tap_agent_registry.txt ]; then
				# TAP_AGENT uninstallation call.
				bash "$TAP_IP_PATH/TAP_AGENT/agent_uninstaller.sh" >>$LOG 2>>$LOG		
				fi
 	fi

}
#select the markets for installation
#This funtion is used only for upgradation case of the market defined.
Upgrade_NOWTAP() {

	if [ $MULTI_TAP -eq 0 ]; then
	echo "TAP  will be restarted. Do you wish to continue?"
	while true
	do
		echo -e "\nPress Y to continue and Q to quit installation : \c "
		read choice

		case $choice
		in
		Y|y)
			echo "TAP Service should be restarted. User entered: $choice" >>$LOG
			break
			;;
		Q|q)	
			echo "Pressed Q to quit installation. User entered: $choice" >>$LOG
			clean_up 0	
			;;
		*)	echo -e  "Please enter a valid choice. \c "
			echo "Selected choice: $choice is invalid." >>$LOG 
		esac
	done
	fi		
	
	cd $REGISTRY_DIRECTORY
	>$BROKER_ID_FILE_CM	
	>$BROKER_ID_FILE_FO	
	>$BROKER_ID_FILE_CD	
	>$BROKER_ID_FILE_SLBM
	>$BROKER_ID_FILE_RDM
	
	ls $REGISTRY_DIRECTORY | grep -v common.txt > $BROKER_ID_TEMP_FILE
	
	while read line
	do
		count=`cat $line | grep "\[1\]" |wc -l`
		if [ $count -eq 1 ];then
			echo $line >> $BROKER_ID_FILE_CM
			CM_INSTALL_FLAG=true
			BROKER_ID=$line
		fi		

		count=`cat $line | grep "\[2\]" |wc -l`
		if [ $count -eq 1 ];then
			echo $line >> $BROKER_ID_FILE_FO
			FO_INSTALL_FLAG=true
			BROKER_ID=$line
		fi		

		count=`cat $line | grep "\[5\]" |wc -l`
		if [ $count -eq 1 ];then
			echo $line >> $BROKER_ID_FILE_CD
			CD_INSTALL_FLAG=true
			BROKER_ID=$line
		fi		

		count=`cat $line | grep "\[6\]" |wc -l`
		if [ $count -eq 1 ];then
			echo $line >> $BROKER_ID_FILE_SLBM
			SLBM_INSTALL_FLAG=true
			BROKER_ID=$line
		fi
		
		count=`cat $line | grep "\[8\]" |wc -l`
		if [ $count -eq 1 ];then
			echo $line >> $BROKER_ID_FILE_RDM
			RDM_INSTALL_FLAG=true
			BROKER_ID=$line
		fi		

	done < $BROKER_ID_TEMP_FILE
#read
#echo "Populated files for upgradation  "
}

Now_Menu_BROKERID() {	
	
	monitoring_flag=0
	while true
	do
		echo -e "Please Enter your Broker ID : \c " | tee -a $LOG

		read BROKER_ID
		echo $BROKER_ID > $BROKER_ID_FILE
		count=`wc -c $BROKER_ID_FILE |awk {'print $1'}` 
		count=$(expr $count - 1)
		#MULTI_TAP=0
		if [ $count -lt 6  ] && [ $count -ne 0 ] ;then
	
			if [ $MULTI_TAP -eq 0 ];then

				#for fresh installation
					#check common.txt file is present in the register directory
				if [ ! -f $COMMON_FILE ]; then
					echo "BROKER ID: $BROKER_ID has been accepted for fresh installation." >> $LOG	
					break; >>$LOG
				elif [ -f "$REGISTRY_DIRECTORY/$BROKER_ID" ];then
					echo "BROKER ID: $BROKER_ID has been accepted for Normal Member." >> $LOG
				else
					#Reading of COUNT from the registry common file
					./config_utility -sg $COMMON_FILE $ROOT_NAME $COUNT_PARAM
					value=$?
					if [ $value -ne 0 ]; then
						 echo "Reading of $COUNT_PARAM from $COMMON_FILE failed. Return value: $value" | tee -a $LOG
						 #exit 
						 clean_up 0
					fi
					export COUNT_OF_BROKERS=`cat tap_val.txt`
					COUNT_OF_BROKERS=`expr $COUNT_OF_BROKERS + 0 `
					if [ $COUNT_OF_BROKERS -eq 0 ];then
						echo "BROKER ID: $BROKER_ID has been accepted for Normal Member." >> $LOG
					else					
						echo "Please enter a valid Broker ID ." | tee -a $LOG
						clean_up 0
						#exit
					fi
				fi
			elif [ $MULTI_TAP -eq 1 ];then
				echo "BROKER ID: $BROKER_ID has been accepted for  Members." >> $LOG
				#break; >>$LOG
			fi
		else
			echo "Please enter a valid Broker ID." | tee -a $LOG	
			clean_up 0
			#exit
		fi

		if [ -f "$REGISTRY_DIRECTORY/$BROKER_ID" ];then
			# checked if any market is installed for the given member id
			echo "BROKER ID: $BROKER_ID has been accepted." >> $LOG
			# check if CM present
		   ./config_utility -sg $REGISTRY_DIRECTORY/$BROKER_ID 1 $PATH_PARAM
		    value=$?
			if [ $value -eq 0 ]; then
				CM_UPGRADE_FLAG=1
				monitoring_flag=1
			else
				CM_UPGRADE_FLAG=0
			fi
			# check if FO present
			./config_utility -sg $REGISTRY_DIRECTORY/$BROKER_ID 2 $PATH_PARAM
			value=$?
			if [ $value -eq 0 ]; then
				FO_UPGRADE_FLAG=1
				monitoring_flag=1
			else
				FO_UPGRADE_FLAG=0
			fi
			# check if CD present
			./config_utility -sg $REGISTRY_DIRECTORY/$BROKER_ID 5 $PATH_PARAM
			value=$?
			if [ $value -eq 0 ]; then
				CD_UPGRADE_FLAG=1
				monitoring_flag=1
			else
				CD_UPGRADE_FLAG=0
			fi
			# check if SLBM present
			./config_utility -sg $REGISTRY_DIRECTORY/$BROKER_ID 6 $PATH_PARAM
			value=$?
			if [ $value -eq 0 ]; then
				SLBM_UPGRADE_FLAG=1
				monitoring_flag=1
			else
				SLBM_UPGRADE_FLAG=0
			fi
			
			# check if RDM present
			./config_utility -sg $REGISTRY_DIRECTORY/$BROKER_ID 8 $PATH_PARAM
			value=$?
			if [ $value -eq 0 ]; then
				RDM_UPGRADE_FLAG=1
				monitoring_flag=1
			else
				RDM_UPGRADE_FLAG=0
			fi
			
				#should exit installation
	fi

	break; >>$LOG
	done
       if [ $CM_UPGRADE_FLAG -eq 1 -a $CD_UPGRADE_FLAG -eq 1 -a $FO_UPGRADE_FLAG -eq 1 ];then
                echo
		echo "TAP for following markets are already installed " |tee -a $LOG
		echo "Capital Market (CM) " |tee -a $LOG
		echo "Futures and Options Market (FO) "   | tee -a $LOG
		echo "Currency Derivative Market (CD) "  | tee -a $LOG
		#echo "Securities Lending and Borrowing Market (SLBM) "  | tee -a $LOG
		#echo "Retail Debt Market (RDM) "  | tee -a $LOG
		echo "Please upgrade TAP to install latest components " |tee -a $LOG
		echo 
		clean_up 0
       fi


	
	if [ $MULTI_TAP -eq 0 ]; then
	echo
		if [ $monitoring_flag -eq 1 ]; then
			echo "TAP  will be restarted. Do you wish to continue?"
			while true
			do
				echo -e "\nPress Y to continue and Q to quit installation : \c "
				read choice

				case $choice	
				in
				Y|y)
					echo "TAP Service should be restarted. User entered: $choice" >>$LOG
					break
				;;
				Q|q)	
					echo "Pressed Q to quit installation. User entered: $choice" >>$LOG
					clean_up 0
					;;
				*)	echo -e  "Please enter a valid choice. \c "
					echo "Selected choice: $choice is invalid." >>$LOG 
				esac
			done
		fi
		#kill the TAP and Monitoring if running
		#KillAllProcess $BORKER_ID	
	fi
	all_selected=0
	echo
	while true
	do	
		#i=1
		echo -e  "\t*********************** INSTALL TAP FOR *************************"  | tee -a $LOG
		if [ $CM_UPGRADE_FLAG -eq 0 ];then
			echo -e "\t 1. Capital Market (CM)"  | tee -a $LOG

		fi

		if [ $FO_UPGRADE_FLAG -eq 0 ];then
			echo -e "\t 2. Futures and Options Market (FO)"   | tee -a $LOG
	
		fi

		if [ $CD_UPGRADE_FLAG -eq 0 ];then
			echo -e  "\t 3. Currency Derivative Market (CD)"  | tee -a $LOG

		fi

		#if [ $SLBM_UPGRADE_FLAG -eq 0 ];then
		#	echo -e "\t 4. Securities Lending and Borrowing Market (SLBM)"  | tee -a $LOG

		#fi
		
		#if [ $RDM_UPGRADE_FLAG -eq 0 ];then
		#	echo -e "\t 5. Retail Debt Market (RDM)"  | tee -a $LOG

		#fi		
		if [ $CM_UPGRADE_FLAG -eq 1 -a $CD_UPGRADE_FLAG -eq 1 -a $FO_UPGRADE_FLAG -eq 1 ];then
		echo 
		echo -e "\t\tAll markets selected . " |tee -a $LOG
		echo
		all_selected=1
		fi
		if [ $all_selected -ne 1 ] ; then
			 echo -e "\t 6. Install TAP for all the above markets "  | tee -a $LOG
		fi
		if [ $all_selected -eq 0 ]; then

			echo -e "\t 0. Exit Installation "  | tee -a $LOG
		else
			
			echo -e "\t 0. Continue Installation "  | tee -a $LOG
		fi
		echo -e "\t******************************************************************  "  | tee -a $LOG
		echo -n -e  " Enter your choice	" | tee -a $LOG
		read choice
		echo "$choice ">>$LOG
		if [ $choice -gt 3 -a $choice -ne 6 ]; then
		echo " Please enter a valid choice. " |tee -a $LOG
		continue
		fi
		case "$choice"
			in

			1)
				if [ $CM_UPGRADE_FLAG -eq 0 ]; then
				#./NOW_TAP_CM_2.0.6_Setup.sh
				CM_UPGRADE_FLAG=1
				CM_INSTALL_FLAG=true
				echo $BROKER_ID > $BROKER_ID_FILE_CM
				else
				echo " Please enter a valid choice. " |tee -a $LOG
				continue
				fi	
				;;
			2)
				if [ $FO_UPGRADE_FLAG -eq 0 ]; then
				FO_UPGRADE_FLAG=1
				FO_INSTALL_FLAG=true
				echo $BROKER_ID > $BROKER_ID_FILE_FO
				else
				echo " Please enter a valid choice. " |tee -a $LOG
					continue
                 fi

				;;
			3)	 if [ $CD_UPGRADE_FLAG -eq 0 ]; then
				#./NOW_TAP_CM_2.0.6_Setup.sh
				CD_UPGRADE_FLAG=1
				CD_INSTALL_FLAG=true
				echo $BROKER_ID > $BROKER_ID_FILE_CD
				else
				echo " Please enter a valid choice. " |tee -a $LOG
								continue
				fi

				;;
			4)	 if [ $SLBM_UPGRADE_FLAG -eq 0 ]; then
				SLBM_UPGRADE_FLAG=1
				SLBM_INSTALL_FLAG=true
				echo $BROKER_ID > $BROKER_ID_FILE_SLBM
				else
				echo " Please enter a valid choice. " |tee -a $LOG
				continue
                fi

				;;
				
			5)	 if [ $RDM_UPGRADE_FLAG -eq 0 ]; then
				RDM_UPGRADE_FLAG=1
				RDM_INSTALL_FLAG=true
				echo $BROKER_ID > $BROKER_ID_FILE_RDM
				else
				echo " Please enter a valid choice. " |tee -a $LOG
				continue
                fi

				;;
				
			6)
				if [ $CM_UPGRADE_FLAG -eq 0 ]; then
				CM_UPGRADE_FLAG=1
				CM_INSTALL_FLAG=true
				echo $BROKER_ID > $BROKER_ID_FILE_CM
				fi
				
				if [ $FO_UPGRADE_FLAG -eq 0 ]; then
				FO_UPGRADE_FLAG=1
				FO_INSTALL_FLAG=true
				echo $BROKER_ID > $BROKER_ID_FILE_FO
				fi 

				if [ $CD_UPGRADE_FLAG -eq 0 ]; then
				CD_UPGRADE_FLAG=1
				CD_INSTALL_FLAG=true
				echo $BROKER_ID > $BROKER_ID_FILE_CD
				fi

				#if [ $SLBM_UPGRADE_FLAG -eq 0 ]; then
        	    #SLBM_UPGRADE_FLAG=1
                #SLBM_INSTALL_FLAG=true
                #echo $BROKER_ID > $BROKER_ID_FILE_SLBM
				#fi
				
				#if [ $RDM_UPGRADE_FLAG -eq 0 ]; then
        	    #RDM_UPGRADE_FLAG=1
                #RDM_INSTALL_FLAG=true
                #echo $BROKER_ID > $BROKER_ID_FILE_RDM
				#fi
				break
				;;

			0)	if [ $all_selected -eq 0 ]; then
					echo "Exiting Installation as user terminated " >> $LOG
					clean_up 0
					#exit 
				else
					echo " Continuing installation as all markets selected " >> $LOG
					break
				fi
				;;
			*)
				echo " Please enter a valid choice. " |tee -a $LOG
				echo
				continue
				;;
		esac
		echo -n -e  "Select additional market? [(y)es/(n)o/(q)uit]	   " | tee -a $LOG
		read choice
		case "$choice"
			in
				N|n)
					echo "User entered no " >>$LOG
					break
					;;
				Y|y)	#j=$(expr $j + 1)
					echo
					echo "User entered yes.Selecting another market " >>$LOG
					continue
					;;
				Q|q)exit
					;;
				*) echo " Please enter a valid choice. " |tee -a $LOG
					echo
					clean_up 0 
					;;
		esac
					
	done

}
DirPage() {

	if [ $UPGRADE_FLAG -eq 1 ]; then

		echo "TAP is installed at : [$InstallDir]" | tee -a $LOG
		return

	else

		echo "Default destination directory for TAP installation: [/usr/bin]" | tee -a $LOG		
		echo -e "Press Y to continue, N to select another path for TAP installation and Q to quit installation : \c " | tee -a $LOG
		read choice
		echo "$choice " >>$LOG
		case "$choice"
		in
			Y|y)	#Default path installation
				echo "TAP will be installed at : [$InstallDir]"
				;;			
					
			N|n)	until [ -n "$validchoice" ]
				do
					echo -e "Please specify destination directory for TAP installation: \c " | tee -a $LOG
					read path
					echo

					if [ ! -d "$path" ]; then
						echo "[$path] is not a directory" | tee -a $LOG

					else
						validchoice=TRUE
						InstallDir=$path/$TAP
						echo "TAP will be installed at : [$InstallDir]" | tee -a $LOG					
					fi

				done
				;;

			Q|q)	#TAP installation is quit
				clean_up 0
				#exit
				;;

			*)
				echo "Please enter a valid choice." | tee -a $LOG
				clean_up 0
				#exit
				;;

		esac

	fi
	
}

#This function is only used for normal NOW installation. Call to this function is to be commented for batch installation.
NOW_PreInstallation() {

	if [ -f $COMMON_FILE ]; then
 
		inst_type_read=s

		if [ -f /etc/TAP_REGISTRY/inst_type  ];then
			echo "Reading value to determine members from TAP REGISTRY ">>$LOG
			inst_type_read=`cat /etc/TAP_REGISTRY/inst_type`
			if [ $inst_type_read = m ];then
				MULTI_TAP=1
				echo "$MULTI_TAP">>$LOG
			fi
		else
			MULTI_TAP=0
			echo " $MULTI_TAP ">>$LOG
		fi

		#Read the TAP path if present

		./config_utility -sg $COMMON_FILE $ROOT_NAME $PATH_PARAM
		value=$?		
		if [ $value -ne 0 ]; then
			echo "Reading of TAP PATH failed. Return value: $value" | tee -a $LOG
			AbortInstall
		fi

		export InstallDir=`cat tap_val.txt`

		echo "Do you wish to upgrade  TAP ?" | tee -a $LOG
		echo -e "Press Y for upgradation of TAP, N for new TAP installation and Q to quit installation/upgradation : \c " | tee -a $LOG

			read choice
			echo $choice >>$LOG

			case "$choice"
			in
				Y|y)	#Upgradation of TAP
					echo "Upgradation will Stop TAP $MARKET for all Brokers. Do you wish to proceed?" | tee -a $LOG
					echo -e "Press Y to continue upgradation of TAP and Q to quit upgradation : \c " | tee -a $LOG

					case "$choice"
					in
						Y|y)	#Upgradation of TAP
							Upgrade_NOWTAP
							;;							
						
						Q|q)	#TAP upgradation is quit.
							clean_up 0
							#exit
							;;

						*)
							echo "Please enter a valid choice." | tee -a $LOG
							clean_up 0
							#exit
							;;
					esac				
				;;			
					
				N|n)	#Menu for entering a broker ID.
					Now_Menu_BROKERID
					;;

				Q|q)	#TAP installation is quit
					clean_up 0
					#exit
					;;

				*)
					echo "Please enter a valid choice." | tee -a $LOG
					clean_up 0
					#exit
					;;

			esac

	else
		#Menu for first broker installation.
		if [ -f /tmp/TAP_REGISTRY/inst_type  ];then
			inst_type_read=s
			echo "Reading value to determine if  members from /tmp TAP REGISTRY ">>$LOG
			inst_type_read=`cat /tmp/TAP_REGISTRY/inst_type`
			if [ $inst_type_read = m ];then
				MULTI_TAP=1
				echo " $MULTI_TAP" >>$LOG
			fi
		else
			MULTI_TAP=0
			echo " $MULTI_TAP" >>$LOG
		fi
		Now_Menu_BROKERID
		DirPage
	fi

}
clean_up() {

		value=$1
		rm -Rf "$SetupFilesPath"
		echo "SetupFiles cleaned up." >> $LOG
 		
		if [ -d /tmp/TAP_REGISTRY ] ; then
			rm -rf /tmp/TAP_REGISTRY
		fi

		if [ $value -ne 0 ] ; then
		echo 	
		echo -n "Installation is in progress ...."
		if [ $MULTI_TAP -eq 0 ];then
			value=`ps -C "tap_ip_monitoring_service_$BROKER_ID" | grep -v PID | awk '{print $1}'| wc -l`
			if [ $value -gt 0 ]; then
				echo "Trying to kill $process_name process" >> $LOG
				kill -9 `ps -C "tap_ip_monitoring_service_$BROKER_ID" | grep -v PID | awk '{print $1}'` >>$LOG 2>>$LOG
				value=$?
				if [ $value -ne 0 ]; then
					echo "Cannot kill tap_ip_monitoring_service_$BROKER_ID process Return value: $value" | tee -a $LOG
					exit
				fi
				echo "Process tap_ip_monitoring_service_$BROKER_ID killed successfully" >> $LOG
		echo -n ".."
		sleep 1 
		
		 "$InstallDir/$BROKER_ID/TAP_MONITORING/BIN/tap_ip_monitoring_service_$BROKER_ID" -c "$InstallDir/$BROKER_ID/TAP_MONITORING/CONFIG/tap_monitoring_$BROKER_ID" &
		#"$InstallDir/$BROKER_ID/run_tap_monitoring_$BROKER_ID.sh"
			value=$?
			if [ $value -ne 0 ]; then
				echo "Unable to start monitoring service, Please start the monitoring service manually." | tee -a $LOG			
			fi	
		echo -n ".."
		sleep 1
		if [ $ipo_mf -eq 1 ] ; then
			"$TAP_IP_PATH/TAP_MONITORING/BIN/tap_ip_monitoring_service" -c "$TAP_IP_PATH/TAP_MONITORING/CONFIG/tap_monitoring" &
			 value=$?
			if [ $value -ne 0 ]; then
				echo "Unable to start monitoring service of tap_ip , Please start the monitoring service manually." | tee -a $LOG			
			fi
		fi	
		sleep 1 
		echo -n ".."
		fi
		fi
			echo -e "\nInstallation Completed. "
		fi
	
		exit
 }
clear
echo "------------------------------Welcome to TAP Installer------------------------------" | tee -a $LOG
echo "It is recommended that, TAP Installation should be done using \"root\" login." | tee -a $LOG
echo "Also $Setup_zip_file and the installer script should be kept in the same directory." | tee -a $LOG
echo
check_tap_mode
NOW_PreInstallation
clear
if [ $CM_INSTALL_FLAG = true ];then
	dos2unix $SetupFilesPath/exe/TAP_CM_7.0.28_Setup.sh 2>>$LOG
	bash $SetupFilesPath/exe/TAP_CM_7.0.28_Setup.sh $MULTI_TAP $InstallDir
	value=$?
	if [ $value -eq 0 ]; then
		echo "Installed CM Market successfully " >>  $LOG
	else
		clean_up 1	
	fi
fi

if [ $FO_INSTALL_FLAG = true ];then
	dos2unix $SetupFilesPath/exe/TAP_FO_7.0.28_Setup.sh 2>>$LOG
	bash $SetupFilesPath/exe/TAP_FO_7.0.28_Setup.sh $MULTI_TAP $InstallDir
	value=$?
	if [ $value -eq 0 ]; then
		echo "Installed FO Market successfully " >>  $LOG
	else
		clean_up 1	
	fi
fi

if [ $CD_INSTALL_FLAG = true ];then
	dos2unix $SetupFilesPath/exe/TAP_CD_7.0.26_Setup.sh 2>>$LOG
	bash $SetupFilesPath/exe/TAP_CD_7.0.26_Setup.sh $MULTI_TAP $InstallDir
	value=$?
	if [ $value -eq 0 ]; then
		echo "Installed CD Market successfully " >> $LOG
	else
		clean_up 1	
	fi
fi

if [ $SLBM_INSTALL_FLAG = true ];then
	dos2unix $SetupFilesPath/exe/TAP_SLBM_7.0.16_Setup.sh 2>>$LOG
	bash $SetupFilesPath/exe/TAP_SLBM_7.0.16_Setup.sh $MULTI_TAP $InstallDir
	value=$?
	if [ $value -eq 0 ]; then
		echo "Installed SLBM Market successfully " >> $LOG
	else
		clean_up 1	
	fi
fi

if [ $RDM_INSTALL_FLAG = true ];then
	dos2unix $SetupFilesPath/exe/TAP_RDM_7.0.14_Setup.sh 2>>$LOG
	bash $SetupFilesPath/exe/TAP_RDM_7.0.14_Setup.sh $MULTI_TAP $InstallDir
	value=$?
	if [ $value -eq 0 ]; then
		echo "Installed RDM Market successfully " >> $LOG
	else
		clean_up 1	
	fi
fi
#echo "BYE"
#read
clean_up 1
