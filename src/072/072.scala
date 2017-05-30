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

def phi(num: Int, factors: List[Int]): Int = {
  var ans = num.toDouble
  factors.foreach{i => ans *= (1 - 1/i.toDouble)
  }

  ans.toInt
}

val max = 1000000
val sortedNums = sortSieve(max)
val primes = sortedNums._1
val comps = sortedNums._2
var sum: Long = 0

primes.foreach(i => sum += i - 1)

comps.foreach{i => sum += phi(i, factors(i))}

println(sum)

