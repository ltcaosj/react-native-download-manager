//
//  DownloadManager.swift
//  toeiclistening
//
//  Created by Long Cao on 7/26/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import UIKit
import Alamofire

@objc(LKDownloadManager)
class LKDownloadManager: RCTEventEmitter {
  
  override static func requiresMainQueueSetup() -> Bool {
    return false
  }
  
  // we need to override this method and
  // return an array of event names that we can listen to
  override func supportedEvents() -> [String]! {
    return ["onDownloadProgress"]
  }
  
  @objc
  func clearCacheDirectory(_ directoryPath : String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    FileUtils.deleteDirectory(name: directoryPath, atDirectory: FileManager.SearchPathDirectory.cachesDirectory)
    resolve(true)
  }
    
  @objc
  func deleteFile(_ filePath : String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {    
    FileUtils.deleteFilePath(name: filePath)
   resolve(true)
  }
  @objc
  func download(_ url : String,  toFilePath : String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    let downloadDestination = DownloadRequest.suggestedDownloadDestination(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.allDomainsMask)
    //
    
    Alamofire.SessionManager.default.download(url, to: downloadDestination).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { (progress) in
      //
      } .validate().responseData { ( response ) in
        if let statusCode = response.response?.statusCode {
          if statusCode == 200 { //Download successful
            let filePath = response.destinationURL!.path
            //
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let cacheDirectory = paths[0]
            //
            let toFilePathAbsolute = (cacheDirectory as NSString).appendingPathComponent(toFilePath)
            let toDirectory = (toFilePathAbsolute as NSString).deletingLastPathComponent
            //
            do{
              if !FileManager.default.fileExists(atPath: toDirectory){
                try FileManager.default.createDirectory(atPath: toDirectory, withIntermediateDirectories: true, attributes: nil)
              }
              //
              if FileManager.default.fileExists(atPath: toFilePathAbsolute) {
                _ = FileUtils.deleteFilePath(name: toFilePathAbsolute)
              }
              try FileManager.default.moveItem(atPath: filePath, toPath: toFilePathAbsolute)
              //
              resolve(toFilePathAbsolute)
              
            } catch let error {
              reject("DN_FAIL", "Failed to download the filex1 : \(error.localizedDescription)", nil)
            }
          }
          else{
            reject("DN_FAIL", "Failed to download the filex2", nil)
          }
        }
        else{
          reject("DN_FAIL", "Failed to download the filex3", nil)
        }
    }
  }
  
  @objc
  func downloadWithProgress(_ url : String,  toFilePath : String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
    let downloadDestination = DownloadRequest.suggestedDownloadDestination(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.allDomainsMask)
    //
    Alamofire.download(url, to: downloadDestination).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { (progress) in
      //
      self.sendEvent(withName: "onDownloadProgress", body: ["fractionCompleted": progress.fractionCompleted])
      //
      } .validate().responseData { ( response ) in
        if let statusCode = response.response?.statusCode {
          if statusCode == 200 { //Download successful
            let filePath = response.destinationURL!.path
            //
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let cacheDirectory = paths[0]
            //
            let toFilePathAbsolute = (cacheDirectory as NSString).appendingPathComponent(toFilePath)
            let toDirectory = (toFilePathAbsolute as NSString).deletingLastPathComponent
            //
            do{
              if !FileManager.default.fileExists(atPath: toDirectory){
                try FileManager.default.createDirectory(atPath: toDirectory, withIntermediateDirectories: true, attributes: nil)
              }
              //
              if FileManager.default.fileExists(atPath: toFilePathAbsolute) {
                _ = FileUtils.deleteFilePath(name: toFilePathAbsolute)
              }
              try FileManager.default.moveItem(atPath: filePath, toPath: toFilePathAbsolute)
              //
              resolve(toFilePathAbsolute)
              
            } catch let error {
              reject("DN_FAIL", "Failed to download the file : \(error.localizedDescription)", nil)
            }
          }
          else{
            reject("DN_FAIL", "Failed to download the file", nil)
          }
        }
        else{
          reject("DN_FAIL", "Failed to download the file", nil)
        }
    }
  }
  
}
