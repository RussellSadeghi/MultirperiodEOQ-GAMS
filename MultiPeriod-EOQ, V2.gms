SETS
t time period               /0*5/;

PARAMETER
d(t)        Demand          /1 10.0 ,2 15.0 ,3 9.2 ,4 4.6 ,5 8.1/
c           Cost            /3.2/
h_pos       Holding cost    /0.5/
h_neg       shortage cost   /1.4/
P           maximum Production amount /10/
;


VARIABLE
Obj
I(t)
;
NONNEGATIVE VARIABLE
x
I_pos
I_neg
;

Binary Variable
y(t) ;

EQUATION
ObjectiveFunction        'Objective Function',
co1(t),
co2(t),
co3(t),
co4(t)
;

ObjectiveFunction  .. Obj    =e= SUM(t, c*y(t))+SUM(t, h_pos*I_pos(t))+SUM(t, h_neg*I_neg(t)) ;
co1(t)      .. I('0') =e=5;
co2(t)      .. I(t)   =e= I(t-1) + x(t) - d(t);
co3(t)      .. I(t)   =e= I_pos(t) -I_neg(t);
co4(t)      .. x(t)   =l= P*y(t);



*option
*InitialInventory(t)$i('0')=0 ;

MODEL MultiPeriodEOQ /all/;
SOLVE MultiPeriodEOQ using MINLP min Obj;
DISPLAY t, c, d, h_pos, h_neg, Obj.l, I.l , y.l , x.l;
