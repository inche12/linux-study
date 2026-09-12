{ counter=counter +1 }
{ print $0 }
END { print "****The number of record is " counter }

