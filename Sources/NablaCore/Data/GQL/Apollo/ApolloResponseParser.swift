import Apollo
import Foundation
#if canImport(ApolloWebSocket)
    import ApolloWebSocket
#endif

enum ApolloResponseParser {
    static func parse<Data>(_ response: Result<GraphQLResult<Data>, Error>, logger: Logger) -> Result<Data, GQLError> {
        switch response {
        case let .failure(error):
            let parsed = parse(error, logger: logger)
            return .failure(parsed)
        case let .success(result):
            return parse(result, logger: logger)
        }
    }

    static func parse<Data>(_ result: GraphQLResult<Data>, logger: Logger) -> Result<Data, GQLError> {
        if let error = result.errors?.first {
            let parsed = parse(error, logger: logger)
            return .failure(parsed)
        }
        if let data = result.data {
            return .success(data)
        }
        return .failure(.emptyServerResponse)
    }
    
    static func parse(_ error: Error, logger: Logger) -> GQLError {
        if let graphqlError = error as? Apollo.GraphQLError {
            switch graphqlError.errorName {
            case "ENTITY_NOT_FOUND":
                return .entityNotFound(message: graphqlError.message)
            case "INTERNAL_SERVER_ERROR":
                return .serverError(message: graphqlError.message)
            case "PERMISSION_REQUIRED":
                return .permissionRequired(message: graphqlError.message)
            default:
                break
            }
            switch graphqlError.classification {
            case "ValidationError":
                return .incompatibleServerSchema(message: graphqlError.message)
            default:
                break
            }
            return .serverError(message: graphqlError.message)
        } else if let authenticationError = error as? AuthenticationError {
            return .authenticationError(authenticationError)
        } else if let websocketError = error as? WebSocketError {
            switch websocketError.kind {
            case .networkError, .upgradeError, .unprocessedMessage, .serializedMessageError:
                return .networkError(message: websocketError.errorDescription)
            case .errorResponse, .neitherErrorNorPayloadReceived:
                return .serverError(message: websocketError.errorDescription)
            }
        } else if let wserror = error as? WebSocket.WSError {
            return .networkError(message: wserror.message)
        } else if let responseCodeError = error as? ResponseCodeInterceptor.ResponseCodeError {
            switch responseCodeError {
            case let .invalidResponseCode(response, _):
                guard let statusCode = response?.statusCode else { return .networkError(message: responseCodeError.errorDescription) }
                switch statusCode {
                case 401: return .authenticationError(AuthorizationDeniedError(reason: responseCodeError))
                case 407, 408: return .networkError(message: responseCodeError.errorDescription)
                case 400 ..< 500: return .serverError(message: responseCodeError.errorDescription)
                case 500...: return .serverError(message: responseCodeError.errorDescription)
                default: return .unknownError
                }
            }
        } else if let sessionClientError = error as? URLSessionClient.URLSessionClientError {
            return .networkError(message: sessionClientError.errorDescription)
        }
        let nsError = error as NSError
        if nsError.domain == NSPOSIXErrorDomain {
            switch nsError.code {
            case 61: return .networkError(message: nsError.localizedDescription)
            default: break
            }
        }
        logger.warning(message: "Unhandled error type", error: error, extra: ["type": type(of: error)])
        return .unknownError
    }
}

private extension Apollo.GraphQLError {
    var errorName: String? {
        extensions?["errorName"] as? String
    }
    
    var classification: String? {
        extensions?["classification"] as? String
    }
}
