wordcount=$(wc -l /home/hamza/wrk/gcide-word-list.txt | cut -f1 -d' ')
random_num=$(shuf -i 1-$wordcount -n1)
awk -v line=$random_num 'NR==line' /usr/share/stardict/dic/gcide-word-list.txt
