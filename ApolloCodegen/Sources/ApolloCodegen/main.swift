import ApolloCodegenLib
import ArgumentParser
import Foundation

// An outer structure to hold all commands and sub-commands handled by this script.
struct SwiftScript: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: """
        A swift-based utility for performing Apollo-related tasks.

        NOTE: If running from a compiled binary, prefix subcommands with `swift-script`. Otherwise use `swift run ApolloCodegen [subcommand]`.
        """,
        subcommands: [GenerateCode.self]
    )

    /// The sub-command to actually generate code.
    struct GenerateCode: ParsableCommand {
        @Argument() var packageName: String
        
        static var configuration = CommandConfiguration(
            commandName: "generate",
            abstract: "Generates swift code from your schema + your operations based on information set up in the `GenerateCode` command."
        )

        mutating func run() throws {
            CodegenLogger.level = .error
            
            let supportedPackageNames = ["NablaCore", "NablaMessagingCore", "NablaScheduling"]
            guard supportedPackageNames.contains(packageName) else {
                throw CommandError(message: "Unknown package name \"\(packageName)\". Supported package names are: \(supportedPackageNames)")
            }
            
            try codegen(packageName: packageName)
        }
        
        private func codegen(packageName: String) throws {
            let fileStructure = try FileStructure()
            CodegenLogger.log("File structure: \(fileStructure)")
            
            let packageFolder = fileStructure.rootFolderURL
                .childFolderURL(folderName: "Sources")
                .childFolderURL(folderName: packageName)
            
            let gqlFolder = packageFolder
                .childFolderURL(folderName: "Data")
                .childFolderURL(folderName: "GQL")
            
            let folderForInputs = gqlFolder
                .childFolderURL(folderName: "Schema")

            let folderForSPMOutputs = gqlFolder
                .childFolderURL(folderName: "Generated")
                .childFolderURL(folderName: "SPM")
            
            let folderForCocoapodsOutputs = gqlFolder
                .childFolderURL(folderName: "Generated")
                .childFolderURL(folderName: "Cocoapods")

            let build = { (folder: URL, cocoapods: Bool) throws in
                try ApolloCodegen.build(
                    with: .init(
                        schemaName: "GQL",
                        input: .init(
                            schemaPath: fileStructure.xplatformSchemaFolderUrl.appendingPathComponent("patient-sdk.graphql").path,
                            operationSearchPaths: ["\(folderForInputs.path)/**/*.graphql"]
                        ),
                        output: .init(
                            schemaTypes: .init(
                                path: folder.path,
                                moduleType: .embeddedInTarget(name: packageName)
                            )
                        ),
                        options: .init(
                            cocoapodsCompatibleImportStatements: cocoapods
                        )
                    )
                )
            }
            try build(folderForSPMOutputs, false)
            try build(folderForCocoapodsOutputs, true)
        }
    }
}

// This will set up the command and parse the arguments when this executable is run.
SwiftScript.main()

extension URL {
    static func multiple(_ strings: [String]) -> URL? {
        URL(string: strings.joined(separator: ","))
    }
}

struct CommandError: Error {
    let message: String
}
