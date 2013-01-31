srun=1
while [ $srun -eq 1 ]; do
	cpvar=$(ps `pgrep -x StataSE` -o pcpu | tail -n 1)
	echo $cpvar
	bccmp=$(echo "$cpvar > 6.5" | bc)
	if [ $bccmp -eq 1 ]; then
		sleep 5
	else
		srun=0
	fi
done

terminal-notifier -title "Stata is finished" -message "Your program is done."

