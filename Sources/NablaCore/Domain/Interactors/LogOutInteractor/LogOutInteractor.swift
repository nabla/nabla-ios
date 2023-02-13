import Foundation

public protocol LogOutInteractor {
    func execute() async
    
    func addAction(_ action: @escaping () -> Void)
}
