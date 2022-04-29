#if DEBUG
    import SwiftUI
    
    struct UIViewPreview: UIViewRepresentable {
        let viewBuilder: () -> UIView
        
        init(_ viewBuilder: @escaping () -> UIView) {
            self.viewBuilder = viewBuilder
        }
        
        func makeUIView(context _: Context) -> some UIView {
            viewBuilder()
        }
        
        func updateUIView(_: UIViewType, context _: Context) {
            // Not needed
        }
    }
#endif
