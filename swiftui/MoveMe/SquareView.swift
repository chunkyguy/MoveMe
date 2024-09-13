import SwiftUI

struct SquareView: View {
  @State var position: CGPoint
  @State var isSelected = false
  
  var body: some View {
    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
      .scaleEffect(isSelected ? 1.2 : 1, anchor: .center)
      .animation(.easeOut, value: isSelected)
      .frame(width: 100, height: 100)
      .position(position)
      .foregroundStyle(isSelected ? .red : .blue)
      .gesture(
        DragGesture(minimumDistance: 0)
          .onChanged({ value in
            isSelected = true
            position = value.location
          })
          .onEnded({ _ in
            isSelected = false
          })
      )
  }
}

#Preview {
  GeometryReader { geo in
    SquareView(position: CGPoint(
      x: geo.size.width * 0.5,
      y: geo.size.height * 0.5
    ))
  }
}
