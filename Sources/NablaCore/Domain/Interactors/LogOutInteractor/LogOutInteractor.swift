import Foundation

public protocol LogOutInteractor {
    func execute()
    
    func addAction(_ action: @escaping () -> Void)
}
