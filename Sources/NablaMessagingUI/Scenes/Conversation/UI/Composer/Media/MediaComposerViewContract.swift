import Foundation

protocol MediaComposerViewContract: AnyObject {
    func configure(with viewModels: [MediaComposerItemViewModel])
    func emptyMedias()
}
