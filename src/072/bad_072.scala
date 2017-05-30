import Array._

//Return two lists, one containing all primes under a limit
//and the other containing all composists under a limit
def sortSieve(limit: Int): (List[Int], List[Int]) = {
  var primeNums: Array[Int] = range(1,limit + 1)
  var compNums: Array[Int] =  range(1,limit + 1)
  for(i <- 0 to limit - 1) compNums(i) = 0

  var i = 1 
  while(i < Math.sqrt(limit)) {
    var mul = i + primeNums(i)

    if(primeNums(i) == 0) mul = limit

    while(mul < limit){
      primeNums(mul) = 0
      compNums(mul) = mul + 1
      mul += i + 1
    }
    i += 1
  }
  (primeNums.toList.distinct diff List(0,1), compNums.toList.distinct diff List(0,1))
}


def factors(max: Int): List[Int] = {
  var factor = Array.fill[Int](10)(0)//Ten unique prime factors allows up to 6.45 billion
  var num = max
  var i = 2
  var count = 1
  while(i <= num){
    if(num % i == 0){
      if(factor(count - 1) != i){
        factor(count) = i
        count += 1
      }
    
      num /= i
      i = 2
    } else {
      i += 1 
    }
  }
  factor.toList.distinct diff List(0)
}

def factor2(limit: Int): Int = {
  var prev = 2
  var num = limit
  var i = 2
  var count = 1
  var powerCount = 1
  var sum = 1
  while(i <= num){
    if(num % i == 0){
      if(i == prev){
        powerCount += 1 
      } else {
        sum *= powerCount
        powerCount = 1
        prev = i
      }
      num /= i
      i = 2
    } else {
      i += 1 
    }
  }
  limit - sum
}

//Returns the number of all numbers under a limit that are not
//mulitples of any prime factors of that limit
def nonFactors(num: Int, factors: List[Int]): Int = {
  var mul = List[Int]()
  for(i <- factors){
    var a = Array.fill[Int](num/i)(0)
    for(j <- 1 to num / i){
      a(j - 1) = i * j
    }
    mul = a.toList ::: mul
  }
  num - mul.distinct.length
}

val max = 1000000
val sortedNums = sortSieve(max)
val primes = sortedNums._1
val comps = sortedNums._2
var d = scala.collection.mutable.Map[Int, Int]();
var sum: Long = 0

primes.foreach(i => sum += i - 1)

for(i <- comps){
  println(i)
  if(i % 2 == 0){
    if(d.contains(i)){
      sum += d(i)
    } else {
      val num = nonFactors(i, factors(i))
      sum += num
      var mul = 2
      while(i * mul <= max){
        d += (i*mul -> num*mul)
        mul *= 2
      }
    }
  }else{
    if(d.contains(i)){
      sum += d(i)
    } else {
      val num = nonFactors(i, factors(i))
      sum += num
      for(prime <- primes.tail.take(200)){
        var mul = prime
        while(i * mul <= max){
          d += (i*mul -> num * mul)
          mul *= prime 
        }
      }
    }
  }
}

println(sum)

/*
comps.foreach{i => sum += nonFactors(i, factors(i))
              println("Composites: " + i)
             }
println(sum)
*/


