import Foundation
import NablaUtils

class DataSourceAssembly: Assembly {
    // MARK: - Assembly

    func assemble(resolver: Resolver) {
        resolver.register(type: ConversationItemRemoteDataSource.self) {
            ConversationItemRemoteDataSourceImpl()
        }
        resolver.register(type: ConversationItemLocalDataSource.self) {
            ConversationItemLocalDataSourceImpl()
        }
    }
}
