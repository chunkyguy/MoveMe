//
//  ViewController.swift
//  MoveMe
//
//  Created by Sidharth Juyal on 12/12/2022.
//

import UIKit

class ViewController: UIViewController {
  
  private var squareVws: [SquareView] = []
  private var selectedVws: [SquareView] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    squareVws = (0..<3).map { idx in
      SquareView(
        frame: CGRect(
          x: view.bounds.midX - 50,
          y: CGFloat.lerp(
            start: (view.bounds.minY + 100),
            end: (view.bounds.maxY - 200),
            factor: CGFloat(idx) / 2
          ),
          width: 100, height: 100
        )
      )
    }
    
    squareVws.forEach { view.addSubview($0) }
    
    let tapGesture = UILongPressGestureRecognizer()
    tapGesture.minimumPressDuration = 0.1
    tapGesture.addTarget(self, action: #selector(handleTap))
    tapGesture.delegate = self
    view.addGestureRecognizer(tapGesture)

    let dragGesture = UIPanGestureRecognizer()
    dragGesture.addTarget(self, action: #selector(handleDrag))
    dragGesture.delegate = self
    view.addGestureRecognizer(dragGesture)
  }
  
    @objc func handleTap(_ sender: UILongPressGestureRecognizer) {
      switch sender.state {
      case .began:
        let pt = sender.location(in: view)
        selectedVws = squareVws.filter { $0.frame.contains(pt) }
        handleGestureEvent(.began)

      case .ended:
        handleGestureEvent(.ended)
        selectedVws = []
        
      default:
        break
      }
    }
  
  @objc func handleDrag(_ sender: UIPanGestureRecognizer) {
    switch sender.state {
    case .changed:
      let translation = sender.translation(in: view)
      handleGestureEvent(.changed(translation))
      sender.setTranslation(.zero, in: view)

    default:
      break
    }
  }
  
  func handleGestureEvent(_ event: GestureEvent) {
    selectedVws.forEach { $0.handleGestureEvent(event) }
  }
}

extension ViewController: UIGestureRecognizerDelegate {
  public func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
    return gestureRecognizer is UILongPressGestureRecognizer
    && otherGestureRecognizer is UIPanGestureRecognizer
  }
}
