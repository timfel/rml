package Main


function Z
  input Real x;
  output Real out1;
  output Integer out2;
  output String out3;
algorithm
  (out1, out2, out3) := matchcontinue x
    local Real xx;
    case (xx) then (1.0, 1, realString(int_real(1)));
  end matchcontinue;
end Z;

function factorial
  input Integer inValue;
  output Integer outValue;
algorithm
  outValue := matchcontinue inValue
    local Integer n;
    case 0 then 1;
    case n then if n>0 then n*factorial(n-1) else 1;
  end matchcontinue;
end factorial;

function facFailSafe
  input Integer inValue;
algorithm
  _ :=
  matchcontinue inValue
    local Integer n, result;
          String str_result;
    case n
      equation
        str_result = intString(factorial(n));
        print("Res: "); print(str_result); print ("\n");
      then ();
    case n
      equation
       failure(result = factorial(n));
       print ("Cannot apply factorial function to n."); print("\n");
      then ();
  end matchcontinue;
end facFailSafe;


function test
  input String s;
  output Integer x;
algorithm
  x := matchcontinue s
         case "one" then if 1 > 0 then 1 else if 2 > 0 then 2 else 3;
         case "two" then 2;
         case "three" then 3;
         case _ then 0;
         else 0;
       end matchcontinue;
end test;

function error  "Print error messages str1 and str2, and fail"
  input String str1;
  input String str2;
  output String v;
algorithm 
  print("Error  ");
  print(str1);  print(" ");
  print(str2);  print("\n");
  str1 ==& str2 := true;
  v := if str1 ==& str2 then "bla1" else "bla2";
  //fail();
end error;


function main
 input list<String> arg;
algorithm
 _ := 
 match arg
  case (n_str::_) 
   local 
    Integer i; 
    String i_str;
    Integer n; 
    String n_str;
    Boolean z;
   equation
    n = stringInt(n_str)+2*4/2-1;
    print (intString(n+3) +& "\n" +& "\t" +& intString(10));
    print(if 1+3 > 1*4 then "true\n" else "false\n");
    z = stringInt("1") * 10 <> 1 + 3 + 5 * 10;
    print(if z then "true\n" else "false\n");
    n = 1 + 2 + 3;
    print (intString(n) +& "\n"); 
    /* i = factorial(n); */
    facFailSafe(n);
    /* 
    str = intString(i);
    print(str); 
    */
 then ();
 end match; 
end main;

end Main;

