//
//  SortPresenter.swift
//  Sorting
//
//  Created by Nikolay Scherbakov on 23.09.2024.
//

protocol SortPresenterProtocol {
  var view: SortView? {get set}
  func bubbleItemsCount() -> Int
  func itemAt(index: Int) -> Int
  func viewDidLoad()
  func nextStepTapped() -> SortItem
  func previousStepTapped() -> SortItem
}

class SortPresenter: SortPresenterProtocol {
  weak var view: SortView?
  private var array: [Int] = []
  private let sortModel: Sortable = SortModel()
  
  func viewDidLoad() {
    array = sortModel.bubbleSortConfiguration(for: 10)
  }
  
  func itemAt(index: Int) -> Int {
    return array[index]
  }
  
  func bubbleItemsCount() -> Int {
    return array.count
  }
  
  func nextStepTapped() -> SortItem {
    let item = sortModel.nextStepTapped()
    array = sortModel.currentArray()
    return item
  }
  
  func previousStepTapped() -> SortItem {
    // TO DO DOESNT WORK NOW
    let item = sortModel.previousStepTapped()
    array = sortModel.currentArray()
    
    return item
  }
}
