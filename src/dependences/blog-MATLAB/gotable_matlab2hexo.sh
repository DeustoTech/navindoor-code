# $1 int file .md
fail_lines_1=`cat -n $1 | grep -B1  "%{" | awk '{print $1}' | grep -v '\-\-'`
fail_lines_2=`cat -n $1 | grep -A1  "%}" | awk '{print $1}' | grep -v '\-\-'`

fail_lines=`echo $fail_lines_1 $fail_lines_2`
python /Users/jesusoroya/Documents/GitHub/DeustoTech-PIBA-BLUE/navindoor/src/hexo/gotable_matlab2hexo.py $1 $fail_lines 