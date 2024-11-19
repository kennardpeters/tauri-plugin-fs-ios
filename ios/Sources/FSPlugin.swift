import SwiftRs
import Tauri
import UIKit
import WebKit
import Foundation

class PingArgs: Decodable {
  let value: String?
}

class FSArgs: Decodable {
  let path: String?
  let contents: String?
}

class RenameArgs: Decodable {
  let path: String?
  let newPath: String?
}

class FSPlugin: Plugin {
  @objc public func ping(_ invoke: Invoke) throws {
    //parse args
    let args = try invoke.parseArgs(PingArgs.self)
    invoke.resolve(["value": args.value ?? ""])
  }
  
  @objc public func createFile(_ invoke: Invoke) throws {
    //parse args
    let args = try invoke.parseArgs(FSArgs.self) 

    //perform argument validation here:
    guard let pathString = args.path else {
      invoke.reject("Could not parse path from FSArgs")
      return
    }
    
    if pathString == "" {
      invoke.reject("Path cannot be empty")
      return
    }
    
    guard let contents = args.contents else {
      invoke.reject("Could not parse contents from FSArgs")
      return
    }

    //Initialize file manager and access documents url
    let fm = FileManager.default
    guard let documentsURL = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
      invoke.reject("Could not open Documents directory")
      return
    }


    //Append fileName to documents path component
    let fileURL = documentsURL.appendingPathComponent(pathString)
    do {
      try contents.write(to: fileURL, atomically: true, encoding: .utf8)
    } catch {
      invoke.reject("Could not write to file \(fileURL.path)")
    }

    invoke.resolve(["value": "success from mobile"])
  }
  
  @objc public func readFile(_ invoke: Invoke) throws {
    let args = try invoke.parseArgs(FSArgs.self)
    
    //perform argument validation here:
    guard let pathString = args.path else {
      invoke.reject("Could not parse path from FSArgs")
      return
    }

    if pathString == "" {
      invoke.reject("Path cannot be empty")
      return
    }
    
    //Initialize file manager and access documents url
    let fm = FileManager.default
    guard let documentsURL = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
      invoke.reject("Could not open Documents directory")
      return
    }
    
    let fileURL = documentsURL.appendingPathComponent(pathString)
    
    do {
      let fileContent = try String(contentsOf: fileURL, encoding: .utf8)
      let unwrappedContent = fileContent.data(using: .utf8)!

      let response = String(data: unwrappedContent, encoding: .utf8)!
      //let msg = "File contents written and retrieved successfully: \(response)"
      invoke.resolve(["value": response ?? ""])
    } catch {
      invoke.reject("Could not read from file \(fileURL.path)")
    }
    
  }

  @objc public func writeFile(_ invoke: Invoke) throws {
    //needed?
    //parse args
    let args = try invoke.parseArgs(FSArgs.self) 

    //perform argument validation here:
    guard let pathString = args.path else {
      invoke.reject("Could not parse path from FSArgs")
      return
    }
    
    if pathString == "" {
      invoke.reject("Path cannot be empty")
      return
    }
    
    guard let contents = args.contents else {
      invoke.reject("Could not parse contents from FSArgs")
      return
    }
    
    if contents == "" {
      invoke.reject("Contents cannot be empty")
      return
    }

    //Initialize file manager and access documents url
    let fm = FileManager.default
    guard let documentsURL = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
      invoke.reject("Could not open Documents directory")
      return
    }


    //Append fileName to documents path component
    let fileURL = documentsURL.appendingPathComponent(pathString)
    do {
      try contents.write(to: fileURL, atomically: true, encoding: .utf8)
      invoke.resolve(["value": "successfully wrote to \(fileURL.path)"])
    } catch {
      invoke.reject("Could not write to file \(fileURL.path)")
    }

  }
  
  @objc public func appendToFile(_ invoke: Invoke) throws {
    let args = try invoke.parseArgs(FSArgs.self)

    //perform argument validation here:
    guard let pathString = args.path else {
      invoke.reject("Could not parse path from FSArgs")
      return
    }

    if pathString == "" {
      invoke.reject("Path cannot be empty")
      return
    }
    
    //perform argument validation here:
    guard let contentString = args.contents else {
      invoke.reject("Could not parse contents from FSArgs")
      return
    }

    if contentString == ""  {
      invoke.reject("Content cannot be empty")
      return
    }
    
    //Initialize file manager and access documents url
    let fm = FileManager.default
    guard let documentsURL = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
      invoke.reject("Could not open Documents directory")
      return
    }
    
    let fileURL = documentsURL.appendingPathComponent(pathString)
    
    //open file
    var existingContent = ""
    do {
      let fileContent = try String(contentsOf: fileURL, encoding: .utf8)
      let unwrappedContent = fileContent.data(using: .utf8)!

      existingContent = String(data: unwrappedContent, encoding: .utf8)!
    } catch {
      invoke.reject("Could not read from file \(fileURL.path)")
    }

    //append contents to existing file contents
    existingContent += contentString
    
    //save file
    do {
      try existingContent.write(to: fileURL, atomically: true, encoding: .utf8)
      invoke.resolve(["value": "successfully appended to \(fileURL.path)"])
    } catch {
      invoke.reject("Could not write to file \(fileURL.path)")
    }
  }

  @objc public func deleteFile(_ invoke: Invoke) throws {
    let args = try invoke.parseArgs(FSArgs.self)
    
    //perform argument validation here:
    guard let pathString = args.path else {
      invoke.reject("Could not parse path from FSArgs")
      return
    }

    if pathString == "" {
      invoke.reject("Path cannot be empty")
      return
    }
    
    //Initialize file manager and access documents url
    let fm = FileManager.default
    guard let documentsURL = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
      invoke.reject("Could not open Documents directory")
      return
    }
    
    let fileURL = documentsURL.appendingPathComponent(pathString)

    if !fm.fileExists(atPath: fileURL.path) {
      invoke.resolve(["value": "file did not exist"])
    }
    
    do {
      try fm.removeItem(at: fileURL)
      invoke.resolve(["value": "successfully removed"])
    } catch {
      invoke.reject("Could not delete file \(fileURL.path)")
    }
  }
  
  @objc public func createDir(_ invoke: Invoke) throws {
    let args = try invoke.parseArgs(FSArgs.self)
    
    //perform argument validation here:
    guard let pathString = args.path else {
      invoke.reject("Could not parse path from FSArgs")
      return
    }

    if pathString == "" {
      invoke.reject("Path cannot be empty")
      return
    }
    
    //Initialize file manager and access documents url
    let fm = FileManager.default
    guard let documentsURL = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
      invoke.reject("Could not open Documents directory")
      return
    }
    
    let newDirectoryURL = documentsURL.appendingPathComponent(pathString)

    do {
      try fm.createDirectory(at: newDirectoryURL, withIntermediateDirectories: true, attributes: nil)
      invoke.resolve(["value": "successfully created directory: \(newDirectoryURL.path)"])
    } catch {
      invoke.reject("Could not create directory")
      return
    }
  }
  
  @objc public func listDir(_ invoke: Invoke) throws {
    let args = try invoke.parseArgs(FSArgs.self)
    
    //perform argument validation here:
    guard let pathString = args.path else {
      invoke.reject("Could not parse path from FSArgs")
      return
    }

    //If path is empty it will the documents directory

    //Initialize file manager and access documents url
    let fm = FileManager.default
    guard let documentsURL = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
      invoke.reject("Could not open Documents directory")
      return
    }

    var fileURL: URL;

    if pathString == "" {
      fileURL = documentsURL;
    } else {
      fileURL = documentsURL.appendingPathComponent(pathString)
    }

    do {
      let directoryList = try fm.contentsOfDirectory(atPath: fileURL.path)

      var dirString = ""
      for item in directoryList {
        dirString += "\(item), "
      }
      
      invoke.resolve(["value": "\(dirString)"])
      return
      
    } catch {
      invoke.reject("Could not read directory: \(fileURL)")
    }

  }

  @objc public func renameDir(_ invoke: Invoke) throws {
    let args = try invoke.parseArgs(RenameArgs.self)
    
    //perform argument validation here:
    guard let pathString = args.path else {
      invoke.reject("Could not parse path from RenameArgs")
      return
    }
    
    if pathString == "" {
      invoke.reject("Path cannot be empty")
      return
    }

    //perform argument validation here:
    guard let newPathString = args.newPath else {
      invoke.reject("Could not parse newPath from RenameArgs")
      return
    }
    
    if newPathString == "" {
      invoke.reject("newPath cannot be empty")
      return
    }

    
    //Initialize file manager and access documents url
    let fm = FileManager.default
    guard let documentsURL = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
      invoke.reject("Could not open Documents directory")
      return
    }
    
    let currDirectoryURL = documentsURL.appendingPathComponent(pathString)
    let newDirectoryURL = documentsURL.appendingPathComponent(newPathString)

    do {
      try fm.moveItem(at: currDirectoryURL, to: newDirectoryURL)
      invoke.resolve(["value": "successfully renamed directory: \(newDirectoryURL.path)"])
    } catch {
      invoke.reject("Could not rename directory")
      return
    }
  }

  @objc public func deleteDir(_ invoke: Invoke) throws {
    let args = try invoke.parseArgs(FSArgs.self)
    
    //perform argument validation here:
    guard let pathString = args.path else {
      invoke.reject("Could not parse path from FSArgs")
      return
    }

    if pathString == "" {
      invoke.reject("Path cannot be empty")
      return
    }
    
    //Initialize file manager and access documents url
    let fm = FileManager.default
    guard let documentsURL = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
      invoke.reject("Could not open Documents directory")
      return
    }
    
    let fileURL = documentsURL.appendingPathComponent(pathString)

    do {
      try fm.removeItem(at: fileURL)
      invoke.resolve(["value": "successfully deleted directory: \(fileURL.path)"])
    } catch {
      invoke.reject("Could not delete directory")
      return
    }
  }
}

@_cdecl("init_plugin_fs_ios")
func initPlugin() -> Plugin {
  return FSPlugin()
}
