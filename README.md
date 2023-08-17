## Motivation

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
is 6.7 days.

## after nearly two thirds finished  

Computation was started with this command, to ensure that no remote connection issues can affect the multi-day computation:  
```
nohup ./sllr64 -t6 -d -q"465859^2097152-465859^1048576+1" 2>err
```

After nearly two thirds of computation all looked good for expected 6.7 days finish:  
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


## 6.7 days computation completed

Computation completed a bit too early, with no final result reported:  
```
hermann@7600x:~$ sed "s/^M/\n/g" nohup.out | tail -3
465859^2097152-465859^1048576+1, bit: 39460000 / 39488394 [99.92%].  Time per bit: 14.621 ms.
465859^2097152-465859^1048576+1, bit: 39470000 / 39488394 [99.95%].  Time per bit: 14.614 ms.
465859^2097152-465859^1048576+1, bit: 39480000 / 39488394 [99.97%].  Time per bit: 14.677 ms.
hermann@7600x:~$ 
```

Ooops, malloc() failure (PC has 32GB RAM):  
```
hermann@7600x:~$ tail -7 err | cut -b-60
\\ 39488364: 0x00000592919bb453cb58dd620f6980aec5445fe0e75b6
\\ 39488365: 0x000000b48a7d907b58427e712a2335ff318856a082e05
\\ 39488366: 0x000002168b6ec1b262c7c7da1ab053cdfeda4d15850f1
\\ 39488367: 0x00000252ac7ba323af80fdf80b8924b93a321e735007d
\\ 39488368: 0x0000012e3316c8caebb10a7263980abb8f9a851810794
\\ 39488369: 0x0000025ee11aff02460ef1c829e0b70df0009a960755b
malloc(): invalid size (unsorted)
hermann@7600x:~$ 
```

It was a good decision to write out the last 100 computed values, most of them got saved:  
```
hermann@7600x:~$ wc --lines err
78 err
hermann@7600x:~$ 
```

Extract the last 6 written values into PARI/GP variables a..f in files a.gp, ..., f.gp:  
```
hermann@7600x:~$ tail -7 err | head -1 | sed "s/^.*:/a =/;s/$/;/" > a.gp
hermann@7600x:~$ tail -6 err | head -1 | sed "s/^.*:/b =/;s/$/;/" > b.gp
hermann@7600x:~$ tail -5 err | head -1 | sed "s/^.*:/c =/;s/$/;/" > c.gp
hermann@7600x:~$ tail -4 err | head -1 | sed "s/^.*:/d =/;s/$/;/" > d.gp
hermann@7600x:~$ tail -3 err | head -1 | sed "s/^.*:/e =/;s/$/;/" > e.gp
hermann@7600x:~$ tail -2 err | head -1 | sed "s/^.*:/f =/;s/$/;/" > f.gp
hermann@7600x:~$ head --bytes 20 f.gp; echo -n " ... "; tail --bytes 20 f.gp
f = 0x0000025ee11aff ... 53b871008dd0b854ed;
hermann@7600x:~$
```

I had to patch LLR with a=7, because the chosen a=3 is no quadratice non-residue (mod p):  
```
hermann@7600x:~$ head -2 err
nohup: ignoring input and appending output to 'nohup.out'
a=7
hermann@7600x:~$ 
```

Complete determination of *sqrt(-1) (mod p)* with PARI/GP script [final.gp](final.gp):  
```
hermann@7600x:~$ gp -q < final.gp 2> sqrtm1.gp
11887192
20
[0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
1 0
1 1
1 0
1 0
1 0
1
done
hermann@7600x:~$
```

The ouput of the last 25 bits of exponent *(p-1)/4* shows where we are, and verifies the leftmost 5 bits "01000":  
```
print(a^2%p==b," 0");
print((7*b^2)%p==c," 1");
print(c^2%p==d," 0");
print(d^2%p==e," 0");
print(e^2%p==f," 0");
```

Next the "1101" pattern has to be processed;  
```
a=(7*f^2)%p;
b=(7*a^2)%p;
c=b^2%p;
d=(7*c^2)%p;
```

Finally the last 20 squarings are without multiply because of the trailing 0s, and *d* is verified to be *sqrt(-1) (mod p)*:  
```
for(i=1,valuation(E,2),c=d;d=c^2%p);
write("/dev/stderr", Str("p=polcyclo(3,-465859^1048576);\nsqrtm1=", d, ";\nprint(sqrtm1^2%p==p-1);"));
print(d^2%p==p-1);
print("done");
```

Running the generated more than 11MB script sqrtm1.gp does verify *sqrt(-1) (mod p)* standalone:  
```
hermann@7600x:~$ gp -q < sqrtm1.gp
1
hermann@7600x:~$ du -sb sqrtm1.gp 
11887256	sqrtm1.gp
hermann@7600x:~$ 
```

```
hermann@7600x:~$ cut -b-60 sqrtm1.gp 
p=polcyclo(3,-465859^1048576);
sqrtm1=17395442163066427324040959475309270144292372123046979
print(sqrtm1^2%p==p-1);
hermann@7600x:~$ 
```


Total power consumption is 19.3KWh in 6,7 days, or 120.02W on average:  
![20230817_013700.part.25%.jpg](20230817_013700.part.25%25.jpg)
