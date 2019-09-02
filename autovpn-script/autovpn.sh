#!/bin/bash

# A script which tries to establish VPN connection at every 20 seconds.
# Written by Ertuğrul Harman @ http://ertugrulharman.com/en
# 18.03.2016

# Keep a log.
exec > >(tee -i ~/.autovpn.log)
exec 2>&1

# Enter all your VPN servers' UUID values here.
# Use "nmcli c show --active" command to learn UUID's of active VPN connections.
# They will be used in the order given here.
# You may enter as many servers as you like. More the better.
vpn=("........-....-....-....-............"
"........-....-....-....-............"
"........-....-....-....-............")

# Optional: You may enter server locations or names here. 
# They are used in log file and command output.
vpn_name=("Netherlands" "Switzerland" "United Kingdom")

# Keep the number of alternatives in memory.
vpn_count=${#vpn[@]}

# This defines maximum attempt number to prevent infinite connection failure.
# Connection failure to all defined VPN servers counts only 1 attempt in this regard.
max_attempt=20

# Implemantation begins.

printf "\nVPN auto connection script started at $(date +"%F %T").\nIts log file is located at ~/autovpn.log\nIt will only report when no connection is found.\n"

for (( m=1; m<$max_attempt; m++ ));
    do
     #printf "\n$(date +"%F %T") Waiting for 10 seconds before VPN connection check.\n"
    sleep 10
    is_connected=$( nmcli c show --active | grep tun0 )
     if [ "$is_connected" = "" ]; 
        then 
        printf "\n$(date +"%F %T") : VPN connection is not active!\n"
        printf "$vpn_count VPN servers will be reached in given order to make a VPN connection.\n"
        printf "If none of them works this whole process will start over for $(($max_attempt-$m)) times.\n"
        
        for (( i=0; i<${vpn_count}; i++ ));
            do
            printf "\n*** Connecting to "${vpn_name[$i]}"... ***\n"
             nmcli c up ${vpn[$i]}
             if [ $? -eq 0 ];
                 then
                 printf "\n*** Connected to "${vpn_name[$i]}"! ***\n\nIt will be periodically checked to see if it is still connected.\n"
                break
                 fi
             done
          else
         #printf "$(date +"%F %T") Check result: VPN is already connected.\n"
         m=$((m - 1))
         fi
         #printf "$(date +"%F %T") Loop is ending. Waiting for 10 seconds.\n"
     sleep 10
     done