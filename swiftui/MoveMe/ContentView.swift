import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack {
      ForEach(0..<3) { idx in
        GeometryReader { geometry in
          SquareView(position: CGPoint(
            x: geometry.size.width * 0.5,
            y: geometry.size.height * (CGFloat(idx +  1) / 4.0)
          ))
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
