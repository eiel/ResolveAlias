import Foundation

func resolveFinderAlias(_ url: URL) -> String? {

    var isAliasOfAny: AnyObject?
    do {
        try (url as NSURL).getResourceValue(&isAliasOfAny, forKey: URLResourceKey.isAliasFileKey)
        guard let isAlias = isAliasOfAny as? Bool else {
            return nil
        }
        if isAlias {
            do {
                let original = try URL(resolvingAliasFileAt: url, options: NSURL.BookmarkResolutionOptions())
                return original.path
            } catch let error as NSError {
                print(error)
            }
        }
    } catch _ {}

    return nil
}

class StandardErrorOutputStream: TextOutputStream {
    func write(_ string: String) {
        let stderr = FileHandle.standardError
        if let odata = string.data(using: String.Encoding.utf8) {
            stderr.write(odata)
        }
    }
}

let arguments: [String] = CommandLine.arguments

let filePath = arguments[1]
let aliasURL = URL(fileURLWithPath: filePath)

if let url = resolveFinderAlias(aliasURL) {
    print(url)
} else {
    var standardError = StandardErrorOutputStream()
    print("Not alias file: \(filePath)", to: &standardError)
    exit(1)
}
