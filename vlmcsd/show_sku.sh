python parser_vlmcsd.py | awk -F'\t' '{print $NF}' | sort  | uniq -c | sort -rn 
