# 11887192-digit-prime

This is followup work on repo [9383761-digit-prime](https://github.com/Hermann-SW/9383761-digit-prime), which was largest known prime =1 (mod 4) at the time it was started.

On 7/25/2023 new proven prime became published largest known prime =1 (mod 4):  
```
pi@pi400-64:~ $ gp -q
? p=polcyclo(3,-465859^1048576);
? #digits(p)
11887192
? print(fromdigits(digits(p)[1..5])," ... ",fromdigits(digits(p)[#digits(p)-4..#digits(p)]));
17395 ... 74241
? 
```
https://t5k.org/primes/lists/all.txt
```
-----  ------------------------------- -------- ----- ---- --------------
 rank  description                     digits   who   year comment
-----  ------------------------------- -------- ----- ---- --------------
...
    7d Phi(3,-465859^1048576)          11887192 L4561 2023 Generalized unique
...
   10  10223*2^31172165+1               9383761 SB12  2016 
...
```

While first patched version of LLR software  
https://mersenneforum.org/showpost.php?p=635873&postcount=8  
was able to determine sqrt\(-1\) \(mod 4\) for 9,383,761-digit prime in 10:45:01h on AMD 7600X CPU PC with 6 LLR threads, expected runtime for this project (with different patch)  
https://mersenneforum.org/showpost.php?p=635984&postcount=6  
is 6.7 days (after nearly two thirds finished already):  
```
$ bc -ql
(39488394-25030000)*0.01455/(24*3600)
2.43483371180555555555
(39488394-25030000)*0.01455/(24*3600)+4+5.55/24
6.66608371180555555555
```
```
pi@pi400-64:~/RSA_numbers_factored/pari $ ssh hermann@7600x uptime
 14:46:02 up 4 days,  5:33,  0 users,  load average: 5.16, 4.66, 4.51
pi@pi400-64:~/RSA_numbers_factored/pari $ ssh hermann@7600x 'sed "s/^M/\n/g" nohup.out | tail -4'
465859^2097152-465859^1048576+1, bit: 25000000 / 39488394 [63.30%].  Time per bit: 14.580 ms.
465859^2097152-465859^1048576+1, bit: 25010000 / 39488394 [63.33%].  Time per bit: 14.551 ms.
465859^2097152-465859^1048576+1, bit: 25020000 / 39488394 [63.36%].  Time per bit: 14.560 ms.
465859^2097152-465859^1048576+1, bit: 25030000 / 39488394 [63.38%].  Time per bit: 14.485 ms.
pi@pi400-64:~/RSA_numbers_factored/pari $ 
```

Power consumption is 12.36KWh in 4.23 days, or 121.7W on average; slightly more than displayed 120W. Photo from part of [Basement ceiling computing center](https://github.com/Hermann-SW/9383761-digit-prime#basement-ceiling-computing-center-for-70-days).
![20230814_144944.part.33%.jpg](20230814_144944.part.33%25.jpg)  

