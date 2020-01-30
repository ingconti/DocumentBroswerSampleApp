//
//  Logger.swift
//  DocumentBroswerSampleApp
//
//  Created by Enrico Rosignoli on 1/30/20.
//  Copyright © 2020 AimTech. All rights reserved.
//

import Foundation


#if os(tvOS)
#elseif os(iOS)
#elseif os(watchOS)
#elseif os(OSX)
import AppKit
#else
#endif

func DBG_openWriteAndCloseLog( msg : String, withTimestamp bWithTime: Bool){
    #if DEBUG
    Logger.openWriteAndCloseLog(msg: msg, withTimestamp: bWithTime)
    #endif
}




//TODO: create logfile based on date.
// and Zip all logs to be sent.

class Logger {
    
    static let shared = Logger()

    private var logFileH : FileHandle?
    private var _fileName : String?

    private var queue : DispatchQueue?  = nil

    init(){
        /* was:
        self.queue = DispatchQueue(label: "com.aim.Logger",
                                   attributes: .concurrent)
 */
        self.queue = DispatchQueue(label: "com.aim.Logger", qos: .background)
    }
    
    deinit {
        killAllQueues()
    }
    
    
    private final func killAllQueues() {
        self.queue?.suspend()
        self.queue = nil
    }
    
    
    // use let and static to create on start.
    private static let _logDir : String = {
        
        let dirPath = AppBasePath() +  "logs"
        
        let FM = FileManager.default
        var ok = FM.fileExists(atPath: dirPath)
        if (ok == false){
            try? FM.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: [:])
        }
        return dirPath
    }()
    
    

    //TODO: add lock / semaphore. (see init, but pay ATTENTION on locking.. we prefer to use it only on open/write/close)
    func addToLog(_ msg : String, withTimestamp bWithTime: Bool)
    {
        if(logFileH == nil){
            return
        }
        
        let logMsg: String?
        if bWithTime == true {
            let now = Date()
            logMsg = "\(now): \(msg)\n"
        }
        else{
            logMsg = "\(msg)\n"
        }
        
        if let data = logMsg?.data(using: .utf8){
            logFileH!.write(data)
        }
    }
    
    final func fullPath()->String{
        let fp = Logger._logDir + "/" + (_fileName ?? LOG_FNAME)
        return fp
    }
    
    
    
    func startLoggingWithFileName(_ logName : String)->Bool{
        
        let fullPath = self.fullPath()
        
        #if DEBUG
        //    print(fullPath)
        #endif
        
        let FM = FileManager.default
       
        var yetCreated = false
        let exists = FM.fileExists(atPath: fullPath)
        if (exists == false){
            yetCreated = FM.createFile(atPath: fullPath, contents: nil, attributes: nil)
        }
        logFileH = FileHandle(forWritingAtPath: fullPath)
        if(logFileH == nil) {
            NSLog( "Cannot write log file")
            return false
        }
        
        logFileH!.seekToEndOfFile();
       
        if yetCreated{
            let s = AllAppInfo() + "\n" + allDeviceInfo()
            self.addToLog(s, withTimestamp: false)
        }

        self.addToLog("-------------------------------------------------", withTimestamp: false)

        return true
    }
    
    
    
    final func stopLogging(){
        if(logFileH != nil)
        {
            logFileH!.closeFile()
            logFileH = nil
        }
    }
    
    
    class func openWriteAndCloseLog(_ logFileName: String, msg : String, withTimestamp bWithTime: Bool)
    {
        let si = Logger.shared
        si.queue!.sync {
            let ok = si.startLoggingWithFileName(logFileName)
            if ok == false{
                return
            }
            si.addToLog(msg, withTimestamp: bWithTime)
            si.stopLogging()
        }

    }
    
    
    class func openWriteAndCloseLog( msg : String, withTimestamp bWithTime: Bool)
    {
        return openWriteAndCloseLog(LOG_FNAME, msg: msg, withTimestamp: bWithTime)
    }
    
    /* no need
    class func clearLogFilesOlderThanHours(_ hours: Double)->UInt64{
        
        let logDir = _logDir
        let fm = FileManager.default
        let dirContents : ArrOfStrings
        let seconds = hours * 3600
        
        do{
            dirContents = try fm.contentsOfDirectory(atPath: logDir)
            //NSArray * subItems = [fm subpathsAtPath: cacheDir]; use this if You want a recursive scan
        } catch let error {
            #if DEBUG
            print(error.localizedDescription)
            #endif
            return 0
        }
        
        let now = Date()
        
        var totalSize: UInt64 = 0
        
        for path: String in dirContents {
            
            let  fullPath = logDir + "/" + path
            
            do{
                let attributes : NSDictionary = try fm.attributesOfItem(atPath: fullPath) as NSDictionary
                #if DEBUG
                //    print(fullPath)
                #endif
                
                
                //to debug:
                // touch -t 201203101513 "$filename"
                
                let creationDate = (attributes.object(forKey: "NSFileCreationDate") as! Date)
                let ageInSeconds = now.timeIntervalSince(creationDate)
                let ext = (path as NSString).pathExtension.uppercased()
                if ageInSeconds > seconds && ext == "LOG" {
                    try fm.removeItem(atPath: fullPath)
                    if let fileSize = attributes[FileAttributeKey.size] as? NSNumber {
                        totalSize+=fileSize.uint64Value
                    }
                }
                
            } catch _ {
            }
        }
        
        #if DEBUG
        print("cache size: \(totalSize/1024) KB")
        #endif
        
        return totalSize
    }
    
    
    
    #if os(tvOS)
    #elseif os(iOS)
    #elseif os(watchOS)
    #elseif os(OSX)
    static func folderRevealInFinder(){
        let wm = NSWorkspace.shared
        
        let path = _logDir
        wm.openFile(path)
    }
    #else
    #endif
 */
    
}



