//
//  SquareView.swift
//  MoveMe
//
//  Created by Sidharth Juyal on 12/12/2022.
//

import UIKit

enum GestureEvent {
  case began
  case changed(CGPoint)
  case ended
}

struct SquareViewProps {
  var color = UIColor.blue
  var scale: CGFloat = 1.0
  var position: CGPoint
}

class SquareView: UIView {
  
  private var props: SquareViewProps {
    didSet {
      setNeedsLayout()
    }
  }
  
  override init(frame: CGRect) {
    props = SquareViewProps(position: CGPoint(x: frame.midX, y: frame.midY))
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    backgroundColor = props.color
    center = props.position
    transform = CGAffineTransform(scaleX: props.scale, y: props.scale)
  }
  
  func handleGestureEvent(_ event: GestureEvent) {
    switch event {
    case .began:
      resetProps(SquareViewProps(
        color: .red,
        scale: 1.2,
        position: props.position
      ))
      
    case .changed(let translation):
      props.position = CGPoint.add(translation, props.position)
      
    case .ended:
      resetProps(SquareViewProps(position: props.position))
    }
  }
  
  private func resetProps(_ props: SquareViewProps) {
    self.props = props
    UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState]) {
      self.layoutIfNeeded()
    }
  }
}
