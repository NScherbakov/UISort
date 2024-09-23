//
//  Untitled.swift
//  Sorting
//
//  Created by Nikolay Scherbakov on 23.09.2024.
//

protocol Sortable {
  func bubbleSortConfiguration(for index: Int) -> [Int]
  func nextStepTapped() -> SortItem
  func previousStepTapped() -> SortItem
  func currentArray() -> [Int]
}

struct SortModel: Sortable {
  private var currentSort: Bubble = BubbleSort()
  
  func bubbleSortConfiguration(for index: Int) -> [Int] {
   return currentSort.configure(with: index)
  }
  
  func nextStepTapped() -> SortItem {
    currentSort.nextStepTapped()
  }
  
  func previousStepTapped() -> SortItem  {
    currentSort.previousStepTapped()
  }
  
  func currentArray() -> [Int] {
    currentSort.currentArray()
  }
}
