assert(b) = { if(!(b), error("assertion failed")); }
p=polcyclo(3,-465859^1048576);
print(#digits(p));
E=(p-1)/4;
\r a
\r b
\r c
\r d
\r e
\r f
print(valuation(E,2));
print(binary(p)[39488365..#binary(E)]);
print(a^2%p==b," 0");
print((7*b^2)%p==c," 1");
print(c^2%p==d," 0");
print(d^2%p==e," 0");
print(e^2%p==f," 0");
a=(7*f^2)%p;
b=(7*a^2)%p;
c=b^2%p;
d=(7*c^2)%p;
for(i=1,valuation(E,2),c=d;d=c^2%p);
write("/dev/stderr", Str("p=polcyclo(3,-465859^1048576);\nsqrtm1=", d, ";\nprint(sqrtm1^2%p==p-1);"));
print(d^2%p==p-1);
print("done");
