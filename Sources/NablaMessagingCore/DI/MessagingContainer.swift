import Foundation
import NablaCore

public class MessagingContainer {
    // MARK: - Public
    
    public let coreContainer: CoreContainer
    public let logger: Logger
    
    // MARK: - Internal
    
    let gqlClient: GQLClient
    let logOutInteractor: LogOutInteractor
    let startConversationInteractor: StartConversationInteractor
    let createConversationInteractor: CreateConversationInteractor
    let watchConversationItemsInteractor: WatchConversationItemsInteractor
    let sendMessageInteractor: SendMessageInteractor
    let retrySendingMessageInteractor: RetrySendingMessageInteractor
    let deleteMessageInteractor: DeleteMessageInteractor
    let setIsTypingInteractor: SetIsTypingInteractor
    let markConversationAsSeenInteractor: MarkConversationAsSeenInteractor
    let watchConversationsInteractor: WatchConversationsInteractor
    let watchConversationInteractor: WatchConversationInteractor
    let gateKeepers: GateKeepers
    
    // MARK: Initializer

    init(
        coreContainer: CoreContainer
    ) {
        self.coreContainer = coreContainer
        
        logger = coreContainer.logger
        gqlClient = coreContainer.gqlClient
        gateKeepers = GateKeepersImpl(coreContainer: coreContainer)
        
        conversationLocalDataSource = ConversationLocalDataSourceImpl()
        conversationRemoteDataSource = ConversationRemoteDataSourceImpl(
            gqlClient: coreContainer.gqlClient,
            gqlStore: coreContainer.gqlStore
        )
        conversationItemLocalDataSource = ConversationItemLocalDataSourceImpl()
        conversationItemRemoteDataSource = ConversationItemRemoteDataSourceImpl(
            gqlClient: coreContainer.gqlClient,
            gqlStore: coreContainer.gqlStore,
            logger: coreContainer.logger
        )
        fileUploadRemoteDataSource = FileUploadRemoteDataSourceImpl(uploadClient: coreContainer.uploadClient)
        
        conversationRepository = ConversationRepositoryImpl(
            remoteDataSource: conversationRemoteDataSource,
            localDataSource: conversationLocalDataSource,
            fileUploadDataSource: fileUploadRemoteDataSource,
            uuidGenerator: coreContainer.uuidGenerator
        )
        conversationItemRepository = ConversationItemRepositoryImpl(
            itemsRemoteDataSource: conversationItemRemoteDataSource,
            itemsLocalDataSource: conversationItemLocalDataSource,
            fileUploadRemoteDataSource: fileUploadRemoteDataSource,
            conversationLocalDataSource: conversationLocalDataSource,
            conversationRemoteDataSource: conversationRemoteDataSource,
            logger: coreContainer.logger
        )
        
        logOutInteractor = coreContainer.logOutInteractor
        startConversationInteractor = StartConversationInteractorImpl(
            repository: conversationRepository
        )
        createConversationInteractor = CreateConversationInteractorImpl(
            authenticator: coreContainer.authenticator,
            repository: conversationRepository
        )
        watchConversationsInteractor = WatchConversationsInteractorImpl(
            authenticator: coreContainer.authenticator,
            repository: conversationRepository
        )
        watchConversationInteractor = WatchConversationInteractorImpl(
            authenticator: coreContainer.authenticator,
            repository: conversationRepository
        )
        watchConversationItemsInteractor = WatchConversationItemsInteractorImpl(
            authenticator: coreContainer.authenticator,
            itemsRepository: conversationItemRepository,
            conversationsRepository: conversationRepository,
            gateKeepers: gateKeepers,
            logger: logger
        )
        sendMessageInteractor = SendMessageInteractorImpl(
            authenticator: coreContainer.authenticator,
            itemsRepository: conversationItemRepository,
            conversationsRepository: conversationRepository
        )
        retrySendingMessageInteractor = RetrySendingMessageInteractorImpl(
            authenticator: coreContainer.authenticator,
            itemsRepository: conversationItemRepository,
            conversationsRepository: conversationRepository
        )
        deleteMessageInteractor = DeleteMessageInteractorImpl(
            authenticator: coreContainer.authenticator,
            itemsRepository: conversationItemRepository,
            conversationsRepository: conversationRepository
        )
        setIsTypingInteractor = SetIsTypingInteractorImpl(
            authenticator: coreContainer.authenticator,
            repository: conversationRepository
        )
        markConversationAsSeenInteractor = MarkConversationAsSeenInteractorImpl(
            authenticator: coreContainer.authenticator,
            repository: conversationRepository
        )
    }

    // MARK: - Private

    private let conversationRepository: ConversationRepository
    private let conversationItemRepository: ConversationItemRepository
    private let conversationLocalDataSource: ConversationLocalDataSource
    private let conversationRemoteDataSource: ConversationRemoteDataSource
    private let conversationItemRemoteDataSource: ConversationItemRemoteDataSource
    private let conversationItemLocalDataSource: ConversationItemLocalDataSource
    private let fileUploadRemoteDataSource: FileUploadRemoteDataSource
}
