while(1)
{
  $d1 = int(rand(1)*9)+1;
  $d2 = int(rand(1)*3)+1;
  $b  = ($d1 >= $d2);
  $m++;
  $s++ if $b;
  $a = sprintf("%5.3f", $s/$m);
  print "$d1 >= $d2 ? $b ! $m/$s = $a\n";
  exit 0 if $m > 10000;
}

