
def add(x:Double, y:Double) : Double = return x + y
def sub(x:Double, y:Double) : Double = return x - y
def mul(x:Double, y:Double) : Double = return x * y
def div(x:Double, y:Double) : Double = return x / y
val operations = Map[Any, (Double,Double) => Double]("+" -> add, "-" -> sub, "*" -> mul, "/" -> div)
val symbols = List("+","-","*","/")
//var opCombo = (symbols ::: symbols ::: symbols).combinations(3).map((i) => i.permutations)

def postfix(l: List[String]): Double = {
  var stack = List[Double]() 
  try{
    for(i <- l){
      if(operations.keySet.exists(_ == i)){
        val temp1= stack(0)
        val temp2= stack(1)
        if(i == "/" && temp1 == 0) return 0.0 //Prevent divisions by zero
        stack = List(operations(i)(temp2, temp1)) ::: stack.drop(2)
      } 
      else {
        stack = List(i.toDouble) ::: stack
      }
    }
  }
  catch{
    case e: Exception => return 0.0
  }
  stack(0)
}

/*
def cons(l: List[Int], length: Int): Int = {
  if(l(0) != length + 1) length
  else if(l.length != 1) cons(l.tail, length + 1)
  else length + 1
  
}
*/
def cons(l: List[Int]): Int = {
  var prev = 0
  var length = 0
  for(i <- l){
    if(i == prev + 1){
      length += 1 
      prev += 1
    }else{
      return length
    }
  }
  length
}

def getLength(a: Int, b: Int, c: Int, d: Int): Int = {
  var numList = List[Int]()
  var opCombo = (symbols ::: symbols ::: symbols).combinations(3).map((i) => i.permutations)
  for(combos <- opCombo){
    for(sequence <- combos){
      for(i <- (sequence ::: List(a.toString, b.toString, c.toString, d.toString)).permutations){
        val num = postfix(i)
        if(num == num.floor && num > 0 && numList.contains(num.toInt) == false){
          numList = List(num.toInt) ::: numList 
        }
      }
    }
  }
  cons(numList.sorted)
}

var max = 0
var ans = 0
for(d <- 4 to 9){
  for(c <- 3 to d-1){
    for(b <- 2 to c-1){
      for(a <- 1 to b-1){
        val l = getLength(a,b,c,d)
        if(l > max){
          ans = a * 1000 + b * 100 + c * 10 + d
          max = l
        }
      }
    }
  }
}
println(ans)
