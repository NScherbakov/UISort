//
//  ViewController.swift
//  Sorting
//
//  Created by Nikolay Scherbakov on 23.09.2024.
//

import UIKit

protocol SortView: AnyObject {
  func disableNextStep()
  func disablePreviousStep()
}

private struct Consts {
  static let defaultColor = UIColor.gray
}

class ViewController: UIViewController {
  @IBOutlet private weak var sortView: UIView!
  @IBOutlet private weak var nextButton: UIButton!
  
  private var presenter: SortPresenterProtocol = SortPresenter()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configurePrensenter()
    presenter.viewDidLoad()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    guard sortView.subviews.isEmpty else { return }
    configureSortView()
  }
  
  @IBAction private func nextStep() {
    nextButton.isEnabled = false
    
    let item = presenter.nextStepTapped()
    print(item)
    updateSortedView(with: item) { [weak self] in
      self?.nextButton.isEnabled = true
      self?.configureSortView()
    }
  }
  
  @IBAction private func previousStep() {
    
  }
}

extension ViewController: SortView {
  func disableNextStep() {
    
  }
  
  func disablePreviousStep() {
    
  }
}

private extension ViewController {
  func configurePrensenter() {
    presenter.view = self
  }
  
  func configureSortView() {
    sortView.subviews.forEach { $0.removeFromSuperview() }
    
    for index in 0..<presenter.bubbleItemsCount() {
      let itemWidth = sortView.frame.width/10
      
      let label = UILabel()
      label.textAlignment = .center
      label.text = "\(presenter.itemAt(index: index))"
      label.frame = CGRect(
        x: CGFloat(index) * sortView.frame.width/10,
        y: 0,
        width: itemWidth,
        height: sortView.frame.height
      )
      label.backgroundColor = Consts.defaultColor
      sortView.addSubview(label)
    }
  }
  
  func updateSortedView(with item: SortItem, completion: (() -> Void)?) {
    sortView.subviews.forEach { $0.backgroundColor = Consts.defaultColor }
    
    let firstView = sortView.subviews[item.currentIndex]
    firstView.backgroundColor = item.colorCurrentIndex
    
    let secondView = sortView.subviews[item.nextIndex]
    secondView.backgroundColor = item.colorNextIndex
    
    if item.shouldSwipe {
      print("Will Swipe")
      
      let firstViewFrame = firstView.frame
      let secodnViewFrame = secondView.frame
      
      UIView.animate(withDuration: 2) {
        firstView.frame = secodnViewFrame
        secondView.frame = firstViewFrame
      } completion: { _ in
        completion?()
        firstView.backgroundColor = Consts.defaultColor
        secondView.backgroundColor = Consts.defaultColor
      }
    } else {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        completion?()
      }
    }
  }
}
