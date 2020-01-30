//
//  UtilsAndOthers.swift
//  DocumentBroswerSampleApp
//
//  Created by Enrico Rosignoli on 1/29/20.
//  Copyright © 2020 AimTech. All rights reserved.
//

import Foundation



// MARK: path to dir:

func documentsDir() ->String{
    
    var documentsDir = ""
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    documentsDir = paths[0]
    
    
    return documentsDir
}


let LOG_FNAME = "log.log"


func AppBasePath()->String{
    let fp = documentsDir() + "/" 
    return fp
}


func allDeviceInfo()->String{
    return ""
}

func AllAppInfo()->String{
    return ""
}


func openWriteAndCloseLog(msg : String, withTimestamp bWithTime: Bool){
    
    Logger.openWriteAndCloseLog(msg: msg, withTimestamp: bWithTime)
    
}





