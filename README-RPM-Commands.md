Command Breakdown 
<hr>
<p>
  <ul>
    <li> rpm -qa : Lists all installed RPM packages. </li>
    <li> --queryformat '%{SIZE} %{NAME}\n': Formats the output to show the package size in bytes followed by the package name, each on a new line. </li>
    <li> | sort -nr: 	Pipes the output to the sort command, which sorts the packages numerically (-n) and in reverse order (-r, largest first). </li>
    <li> | head -n 25: 	Displays only the top 25 results. </li>
    <li> | awk '{printf "%.2f MB - %s\n", $1/1048576, $2}': Uses awk to convert the size from bytes (the %{SIZE} output) to megabytes. </li> 
    						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	(by dividing by 1048576, which is 1024*1024) and formats the output to two decimal places. 
  </ul>
</p>
