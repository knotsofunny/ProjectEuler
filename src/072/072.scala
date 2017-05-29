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

/*
def compSieve(limit: Int, factors: List[Int]): Int = {
  var nums: Array[Int] = range(0, limit)

  for(factor <- factors){
    var i = factor
    while(i < limit){
      nums(i) = 0
      i += factor
    }
  } 
  var sum = 0
  (nums.toList.distinct diff List(0)).foreach(i => sum += 1)
  sum
}
*/
//Returns the number of all numbers under a limit that are not
//mulitples of any prime factors of that limit


//TODO: subtracting factors to0 many times
//ex: If factors are (2,3) 6 gets counted twice
def nonFactors(limit: Int, factors: List[Int]): Int = {
  var count: Int = limit + (factors.length - 1)
  factors.foreach(i => count -= limit / i)
  count
}

def factors(max: Int): List[Int] = {
  var list = Array.fill[Int](10)(0)//Ten unique prime factors allows up to 6.45 billion
  var num = max
  var i = 2
  var count = 1
  while(i <= num){
    if(num % i == 0){
      if(list(count - 1) != i){
        list(count) = i
        count += 1
      }
    
      num /= i
      i = 2
    } else {
      i += 1 
    }
  }
  list.toList.distinct.sorted diff List(0)
}

val sortedNums = sortSieve(13)
val primes = sortedNums._1
val comps = sortedNums._2

var sum: Long = 0

primes.foreach(i => sum += i - 1)
comps.foreach{i => sum += nonFactors(i, factors(i))
              println("Composites: " + i)
             }
println(sum)
