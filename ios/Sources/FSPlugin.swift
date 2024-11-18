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
    invoke.resolve(["value": args.contents ?? ""])
  }

  @objc public func writeFile(_ invoke: Invoke) throws {
    let args = try invoke.parseArgs(FSArgs.self)
    invoke.resolve(["value": args.contents ?? ""])
  }
  
  @objc public func appendToFile(_ invoke: Invoke) throws {
    let args = try invoke.parseArgs(FSArgs.self)
    invoke.resolve(["value": args.contents ?? ""])
  }

  @objc public func deleteFile(_ invoke: Invoke) throws {
    let args = try invoke.parseArgs(FSArgs.self)
    invoke.resolve(["value": args.contents ?? ""])
  }
  
  @objc public func createDir(_ invoke: Invoke) throws {
  }
  
  @objc public func readDir(_ invoke: Invoke) throws {
    let args = try invoke.parseArgs(FSArgs.self)
    invoke.resolve(["value": args.contents ?? ""])
  }

  @objc public func updateDir(_ invoke: Invoke) throws {
    let args = try invoke.parseArgs(FSArgs.self)
    invoke.resolve(["value": args.contents ?? ""])
  }

  @objc public func deleteDir(_ invoke: Invoke) throws {
    let args = try invoke.parseArgs(FSArgs.self)
    invoke.resolve(["value": args.contents ?? ""])
  }
}

@_cdecl("init_plugin_fs_ios")
func initPlugin() -> Plugin {
  return FSPlugin()
}
