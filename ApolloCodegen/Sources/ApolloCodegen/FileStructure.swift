import ApolloCodegenLib
import Foundation

// An object representing the filesystem structure. Allows you to grab references to folders in the filesystem without having to pass them through as environment variables.
struct FileStructure {
    let rootFolderURL: URL
    let codegenFolderUrl: URL
    let gqlFolderURL: URL
    let cliFolderURL: URL

    init() throws {
        // Grab the parent folder of this file on the filesystem
        let parentFolderOfScriptFile = FileFinder.findParentFolder()
        CodegenLogger.log("Parent folder of script file: \(parentFolderOfScriptFile)")

        // Use that to calculate the source root for both your main project and this codegen project.
        // NOTE: You may need to change this if your project has a different structure than the suggested structure.
        codegenFolderUrl = parentFolderOfScriptFile
            .apollo.parentFolderURL() // Result: Sources folder
            .apollo.parentFolderURL() // Result: ApolloCodegen folder
        
        rootFolderURL = codegenFolderUrl
            .apollo.parentFolderURL() // Result: root folder
        
        gqlFolderURL = rootFolderURL
            .apollo.childFolderURL(folderName: "Sources")
            .apollo.childFolderURL(folderName: "NablaMessagingCore")
            .apollo.childFolderURL(folderName: "Data")
            .apollo.childFolderURL(folderName: "GQL")

        // Set up the folder where you want the typescript CLI to download.
        cliFolderURL = rootFolderURL
            .apollo.childFolderURL(folderName: "ApolloCodegen")
            .apollo.childFolderURL(folderName: "ApolloCLI")
    }
}

extension FileStructure: CustomDebugStringConvertible {
    var debugDescription: String {
        """
        Root folder URL: \(rootFolderURL)
        ApolloCodgegen folder URL: \(codegenFolderUrl)
        GQL folder URL: \(gqlFolderURL)
        CLI folder URL: \(cliFolderURL)
        """
    }
}
