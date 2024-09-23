//
//  BubuleSort.swift
//  Sorting
//
//  Created by Nikolay Scherbakov on 23.09.2024.
//


protocol Bubble {
  func configure(with index: Int) -> [Int]
  func nextStepTapped() -> SortItem
  func previousStepTapped() -> SortItem
  func currentArray() -> [Int]
}

class BubbleSort: Bubble {
  private var array: [Int] = []
  private var modifiedArray: [Int] = []
  private var step = 0
  
  func configure(with index: Int) -> [Int] {
    array = (0..<index).map { $0 }.shuffled()
    return array
  }
  
  func nextStepTapped() -> SortItem {
    modifiedArray = array
    step += 1
    
    var currentStep = 0
    var currentIndex = 0
    var nextIndex = 0
    var shouldSwipe = false
    
    
    for i in 0..<modifiedArray.count {
      if currentStep == step {
        break
      }
      
      for j in 0..<modifiedArray.count-i-1 {
    
        currentIndex = j
        nextIndex = j + 1
        currentStep += 1
        
        if modifiedArray[j] > modifiedArray[j+1] {
          shouldSwipe = true
          
          let temp = modifiedArray[j]
          modifiedArray[j] = modifiedArray[j+1]
          modifiedArray[j+1] = temp
        } else {
          shouldSwipe = false
        }
        
        if currentStep  == step {
          break
        }
      }
    }

    return .init(
      currentIndex: currentIndex,
      nextIndex: nextIndex,
      colorCurrentIndex: .green,
      colorNextIndex: shouldSwipe ? .green : .yellow,
      shouldSwipe: shouldSwipe
    )
  }
  
  func currentArray() -> [Int] {
    return modifiedArray
  }
  
  func previousStepTapped() -> SortItem {
    return .init(currentIndex: 0, nextIndex: 0, colorCurrentIndex: .black, colorNextIndex: .black, shouldSwipe: false)
  }
}
