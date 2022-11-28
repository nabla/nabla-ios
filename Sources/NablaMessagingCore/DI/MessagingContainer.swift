import Foundation
import NablaCore

public class MessagingContainer {
    // MARK: - Public
    
    public let coreContainer: CoreContainer
    
    public var logger: Logger {
        coreContainer.logger
    }
    
    // MARK: - Internal
    
    var gqlClient: GQLClient {
        coreContainer.gqlClient
    }
    
    var logOutInteractor: LogOutInteractor {
        coreContainer.logOutInteractor
    }

    private(set) lazy var createConversationInteractor: CreateConversationInteractor = CreateConversationInteractorImpl(
        authenticator: coreContainer.authenticator,
        repository: conversationRepository
    )
    
    private(set) lazy var createDraftConversationInteractor: CreateDraftConversationInteractor = CreateDraftConversationInteractorImpl(
        repository: conversationRepository
    )

    private(set) lazy var watchConversationItemsInteractor: WatchConversationItemsInteractor = WatchConversationItemsInteractorImpl(
        authenticator: coreContainer.authenticator,
        itemsRepository: conversationItemRepository,
        conversationsRepository: conversationRepository
    )

    private(set) lazy var sendMessageInteractor: SendMessageInteractor = SendMessageInteractorImpl(
        authenticator: coreContainer.authenticator,
        itemsRepository: conversationItemRepository,
        conversationsRepository: conversationRepository
    )

    private(set) lazy var retrySendingMessageInteractor: RetrySendingMessageInteractor = RetrySendingMessageInteractorImpl(
        authenticator: coreContainer.authenticator,
        itemsRepository: conversationItemRepository,
        conversationsRepository: conversationRepository
    )

    private(set) lazy var deleteMessageInteractor: DeleteMessageInteractor = DeleteMessageInteractorImpl(
        authenticator: coreContainer.authenticator,
        itemsRepository: conversationItemRepository,
        conversationsRepository: conversationRepository
    )

    private(set) lazy var setIsTypingInteractor: SetIsTypingInteractor = SetIsTypingInteractorImpl(
        authenticator: coreContainer.authenticator,
        repository: conversationRepository
    )

    private(set) lazy var markConversationAsSeenInteractor: MarkConversationAsSeenInteractor = MarkConversationAsSeenInteractorImpl(
        authenticator: coreContainer.authenticator,
        repository: conversationRepository
    )

    private(set) lazy var watchConversationsInteractor: WatchConversationsInteractor = WatchConversationsInteractorImpl(
        authenticator: coreContainer.authenticator,
        repository: conversationRepository
    )

    private(set) lazy var watchConversationInteractor: WatchConversationInteractor = WatchConversationInteractorImpl(
        authenticator: coreContainer.authenticator,
        repository: conversationRepository
    )
    
    private(set) lazy var gateKeepers: GateKeepers = .init(supportVideoCallActionRequests: self.coreContainer.videoCallClient != nil)
    
    // MARK: Initializer

    init(
        coreContainer: CoreContainer
    ) {
        self.coreContainer = coreContainer
    }

    // MARK: - Private

    private lazy var conversationRepository: ConversationRepository = ConversationRepositoryImpl(
        remoteDataSource: conversationRemoteDataSource,
        localDataSource: conversationLocalDataSource,
        fileUploadDataSource: fileUploadRemoteDataSource
    )

    private lazy var conversationItemRepository: ConversationItemRepository = ConversationItemRepositoryImpl(
        itemsRemoteDataSource: conversationItemRemoteDataSource,
        itemsLocalDataSource: conversationItemLocalDataSource,
        fileUploadRemoteDataSource: fileUploadRemoteDataSource,
        conversationLocalDataSource: conversationLocalDataSource,
        conversationRemoteDataSource: conversationRemoteDataSource,
        logger: coreContainer.logger
    )
    
    private lazy var conversationLocalDataSource: ConversationLocalDataSource = ConversationLocalDataSourceImpl()

    private lazy var conversationRemoteDataSource: ConversationRemoteDataSource = ConversationRemoteDataSourceImpl(
        gqlClient: coreContainer.gqlClient,
        asyncGqlClient: coreContainer.gqlClient,
        gqlStore: coreContainer.gqlStore
    )

    private lazy var conversationItemRemoteDataSource: ConversationItemRemoteDataSource = ConversationItemRemoteDataSourceImpl(
        gqlClient: coreContainer.gqlClient,
        asyncGqlClient: coreContainer.gqlClient,
        gqlStore: coreContainer.gqlStore,
        logger: coreContainer.logger
    )

    private lazy var conversationItemLocalDataSource: ConversationItemLocalDataSource = ConversationItemLocalDataSourceImpl()

    private lazy var fileUploadRemoteDataSource: FileUploadRemoteDataSource = FileUploadRemoteDataSourceImpl(uploadClient: coreContainer.uploadClient)
}
