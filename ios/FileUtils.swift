import Foundation

class FileUtils {
  
    class func fullPath(name : String, atDirectory: FileManager.SearchPathDirectory)->String
    {
        var paths = NSSearchPathForDirectoriesInDomains(atDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths[0]
        return (documentsDirectory as NSString).appendingPathComponent(name)
    }
    
    class func filePath(fileName : String, atDirectory: FileManager.SearchPathDirectory)->String
    {
        var paths = NSSearchPathForDirectoriesInDomains(atDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths[0]
        return (documentsDirectory as NSString).appendingPathComponent(fileName)
    }
    
    class func deleteFilePath(fileName : String, atDirectory: FileManager.SearchPathDirectory)->Bool
    {
        var paths = NSSearchPathForDirectoriesInDomains(atDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths[0]
        let fullPath = (documentsDirectory as NSString).appendingPathComponent(fileName)
        //
        do {
            try FileManager.default.removeItem(atPath: fullPath)
            return true
        }
        catch{
            return true
        }
    }
    
    class func deleteFilePath(name : String)->Bool
    {
        do {
            try FileManager.default.removeItem(atPath: name)
            return true
        }
        catch{
            return true
        }
    }
    
    class func createDirectory(name: String, atDirectory: FileManager.SearchPathDirectory) throws ->String{
        var paths = NSSearchPathForDirectoriesInDomains(atDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths[0]
        let path = (documentsDirectory as NSString).appendingPathComponent(name)
        //
        try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        //
        return path
    }
    
    class func deleteDirectory(name : String, atDirectory: FileManager.SearchPathDirectory)->Bool
    {
        var paths = NSSearchPathForDirectoriesInDomains(atDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths[0]
        let fullPath = (documentsDirectory as NSString).appendingPathComponent(name)
        //
        do {
            try FileManager.default.removeItem(atPath: fullPath)
            return true
        }
        catch{
            return true
        }
    }
    
    class func deleteAllFiles(containFileNames : [String], atDirectory: FileManager.SearchPathDirectory)->Bool
    {
        var paths = NSSearchPathForDirectoriesInDomains(atDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths[0]
        //
        do {
            let fm = FileManager.default
            let files = try fm.contentsOfDirectory(atPath: documentsDirectory)
            for fileName in files {
                let fullPath = (documentsDirectory as NSString).appendingPathComponent(fileName)
                if isStringListContainedIn(stringList: containFileNames, str: fullPath)
                {
                    try FileManager.default.removeItem(atPath: fullPath)
                }
            }
            //
            return true
        }
        catch{
            return true
        }
    }
    
    class func isStringListContainedIn(stringList: [String], str: String)->Bool {
        for s in stringList {
            if str.contains(s) {
                return true
            }
        }
        //
        return false
    }
    
    class func isDirectoryExisting(name : String, atDirectory: FileManager.SearchPathDirectory)->Bool
    {
        var paths = NSSearchPathForDirectoriesInDomains(atDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths[0]
        let fullPath = (documentsDirectory as NSString).appendingPathComponent(name)
        //
        return FileManager.default.fileExists(atPath: fullPath)
    }
}
