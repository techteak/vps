python parser_vlmcsd.py | awk -F'\t' '{print $2}' | sort  | uniq -c | sort -rn 
