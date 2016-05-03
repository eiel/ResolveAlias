import Foundation

func resolveFinderAlias(url:NSURL) -> String? {
    
    var isAlias : AnyObject?
    do {
        try url.getResourceValue(&isAlias, forKey: NSURLIsAliasFileKey)
        if isAlias as! Bool {
            do {
                let original = try NSURL(byResolvingAliasFileAtURL: url, options: NSURLBookmarkResolutionOptions())
                return original.path!
            } catch let error as NSError {
                print(error)
            }
        }
    } catch _ {}
    
    return nil
}

class StandardErrorOutputStream: OutputStreamType {
    func write(string: String) {
        let stderr = NSFileHandle.fileHandleWithStandardError()
        if let odata = string.dataUsingEncoding(NSUTF8StringEncoding) {
            stderr.writeData(odata)
        }
    }
}

let arguments :[String] = Process.arguments

let filePath = arguments[1]
let aliasURL = NSURL.fileURLWithPath(filePath)

if let url = resolveFinderAlias(aliasURL) {
    print(url)
} else {
    var standardError = StandardErrorOutputStream()
    print("Not alias file: \(filePath)", toStream: &standardError)
    exit(1)
}
