import Foundation
import SwiftUI

extension View
{
  func onDoubleClick(handler: @escaping () -> Void) -> some View
  {
    modifier(DoubleClickHandler(handler: handler))
  }
}

struct DoubleClickHandler: ViewModifier
{
  let handler: () -> Void
  func body(content: Content) -> some View
  {
    content.overlay
    {
      DoubleClickListeningViewRepresentable(handler: handler)
    }
  }
}

struct DoubleClickListeningViewRepresentable: NSViewRepresentable
{
  let handler: () -> Void
  func makeNSView(context: Context) -> DoubleClickListeningView
  {
    DoubleClickListeningView(handler: handler)
  }
  func updateNSView(_ nsView: DoubleClickListeningView, context: Context) {}
}

class DoubleClickListeningView: NSView
{
  let handler: () -> Void
  init(handler: @escaping () -> Void)
  {
    self.handler = handler
    super.init(frame: .zero)
  }

  required init?(coder: NSCoder)
  {
    fatalError("init(coder:) has not been implemented")
  }

  override func mouseDown(with event: NSEvent)
  {
    super.mouseDown(with: event)
    if event.clickCount == 2
    {
      handler()
    }
  }
}
