import ApolloCodegenLib
import Foundation

// An object representing the filesystem structure. Allows you to grab references to folders in the filesystem without having to pass them through as environment variables.
struct FileStructure {
    let rootFolderURL: URL
    let codegenFolderUrl: URL
    let cliFolderURL: URL
    let xplatformSchemaFolderUrl: URL

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

        // Set up the folder where you want the typescript CLI to download.
        cliFolderURL = rootFolderURL
            .apollo.childFolderURL(folderName: "ApolloCodegen")
            .apollo.childFolderURL(folderName: "ApolloCLI")
        
        // TODO: Copy server schema inside ios sdk folder
        xplatformSchemaFolderUrl = rootFolderURL
            .apollo.parentFolderURL() // sdk folder
            .apollo.parentFolderURL() // health folder
            .apollo.childFolderURL(folderName: "graphql")
            .apollo.childFolderURL(folderName: "patient")
    }
}

extension FileStructure: CustomDebugStringConvertible {
    var debugDescription: String {
        """
        Root folder URL: \(rootFolderURL)
        ApolloCodgegen folder URL: \(codegenFolderUrl)
        CLI folder URL: \(cliFolderURL)
        XPlatform schema folder URL: \(xplatformSchemaFolderUrl)
        """
    }
}
