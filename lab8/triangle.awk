#!/usr/bin/awk -f

function area(a,b) {
	return (a*b)/2
}

function perimetr(a,b,c) {
	return a+b+c
}

BEGIN {
	print "Введите длины катетор a и b:"
}

{
	a = $1
	b = $2
	c = sqrt(a*a+b*b)
	print "Площадь:", area(a,b)
	print "Периметр:", perimetr(a,b,c)
}
EOF
