import Foundation

let arr = [
    3, 4, -9, 12, 15, 6
]

func plusMinus(arr: [Int]) -> Void {
   var positiveCount = 0
   var negativeCount = 0
   var zeroCount = 0
   
   for i in arr {
       if i > 0 {
           positiveCount += 1
       }
       else if i < 0 {
           negativeCount += 1
       }else{
           zeroCount += 1
       }
   }
  
  let totalCount = Double(arr.count)
  
  // Ratios
 let positiveRatio = Double(positiveCount) / totalCount
 let negativeRatio = Double(negativeCount) / totalCount
 let zeroRatio = Double(zeroCount) / totalCount
 
 print(String(format: "%.6f", positiveRatio ))
 print(String(format: "%.6f", negativeRatio ))
 print(String(format: "%.6f", zeroRatio ))
 
}

guard let n = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
else { fatalError("Bad input") }

guard let arrTemp = readLine()?.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression) else { fatalError("Bad input") }

let arr2: [Int] = arrTemp.split(separator: " ").map {
    if let arrItem = Int($0) {
        return arrItem
    } else { fatalError("Bad input") }
}

guard arr2.count == n else { fatalError("Bad input") }

plusMinus(arr: arr)
