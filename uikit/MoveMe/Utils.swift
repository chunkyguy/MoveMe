import Foundation
import UIKit

extension CGPoint {
  static func add(_ left: CGPoint, _ right: CGPoint) -> CGPoint {
    CGPoint(
      x: left.x + right.x,
      y: left.y + right.y
    )
  }
}

extension CGFloat {
  static func lerp(start: CGFloat, end: CGFloat, factor: CGFloat) -> CGFloat {
    (start * (1.0 - factor)) + (end * factor)
  }
}
