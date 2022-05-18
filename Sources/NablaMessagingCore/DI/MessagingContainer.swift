import Foundation

class MessagingContainer {
    // MARK: - Initializer

    init(coreContainer: CoreContainer) {
        self.coreContainer = coreContainer
    }

    // MARK: - Public

    private(set) lazy var createConversationInteractor: CreateConversationInteractor = CreateConversationInteractorImpl(
        authenticator: coreContainer.authenticator,
        repository: conversationRepository
    )

    private(set) lazy var watchConversationItemsInteractor: WatchConversationItemsInteractor = WatchConversationItemsInteractorImpl(
        authenticator: coreContainer.authenticator,
        repository: conversationItemRepository
    )

    private(set) lazy var sendMessageInteractor: SendMessageInteractor = SendMessageInteractorImpl(
        authenticator: coreContainer.authenticator,
        repository: conversationItemRepository
    )

    private(set) lazy var retrySendingMessageInteractor: RetrySendingMessageInteractor = RetrySendingMessageInteractorImpl(
        authenticator: coreContainer.authenticator,
        repository: conversationItemRepository
    )

    private(set) lazy var deleteMessageInteractor: DeleteMessageInteractor = DeleteMessageInteractorImpl(
        authenticator: coreContainer.authenticator,
        repository: conversationItemRepository
    )

    private(set) lazy var setIsTypingInteractor: SetIsTypingInteractor = SetIsTypingInteractorImpl(
        authenticator: coreContainer.authenticator,
        repository: conversationItemRepository
    )

    private(set) lazy var markConversationAsSeenInteractor: MarkConversationAsSeenInteractor = MarkConversationAsSeenInteractorImpl(
        authenticator: coreContainer.authenticator,
        repository: conversationItemRepository
    )

    private(set) lazy var watchConversationsInteractor: WatchConversationsInteractor = WatchConversationsInteractorImpl(
        authenticator: coreContainer.authenticator,
        repository: conversationRepository
    )

    private(set) lazy var watchConversationInteractor: WatchConversationInteractor = WatchConversationInteractorImpl(
        authenticator: coreContainer.authenticator,
        repository: conversationRepository
    )

    // MARK: - Private

    private var coreContainer: CoreContainer

    private lazy var conversationRepository: ConversationRepository = ConversationRepositoryImpl(remoteDataSource: conversationRemoteDataSource)

    private lazy var conversationItemRepository: ConversationItemRepository = ConversationItemRepositoryImpl(
        remoteDataSource: conversationItemRemoteDataSource,
        localDataSource: conversationItemLocalDataSource,
        fileUploadRemoteDataSource: fileUploadRemoteDataSource,
        uploadClient: uploadClient,
        logger: coreContainer.logger
    )

    private lazy var conversationRemoteDataSource: ConversationRemoteDataSource = ConversationRemoteDataSourceImpl(
        gqlClient: coreContainer.gqlClient,
        gqlStore: coreContainer.gqlStore
    )

    private lazy var conversationItemRemoteDataSource: ConversationItemRemoteDataSource = ConversationItemRemoteDataSourceImpl(
        gqlClient: coreContainer.gqlClient,
        gqlStore: coreContainer.gqlStore,
        logger: coreContainer.logger
    )

    private lazy var conversationItemLocalDataSource: ConversationItemLocalDataSource = ConversationItemLocalDataSourceImpl()

    private lazy var fileUploadRemoteDataSource: FileUploadRemoteDataSource = FileUploadRemoteDataSourceImpl(uploadClient: uploadClient)

    private lazy var uploadClient: UploadClient = .init(
        httpManager: coreContainer.httpManager,
        authenticator: coreContainer.authenticator
    )
}
