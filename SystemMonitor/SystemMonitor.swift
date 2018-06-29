//
//  SystemMonitor.swift
//  SystemMonitor
//
//  Created by Jacques Lorentz on 24/06/2018.
//  Copyright © 2018 Jacques Lorentz. All rights reserved.
//

import Foundation

enum SystemMonitorError : Error {
    case sysctlError(arg: [Int32], errno: String)
    case hostCallError(arg: Int32, errno: String)
    case conversionFailed(invalidUnit: String)
}

public struct SystemInfos {
    let memory: MemoryUsage
    let processor: CPUInfos
}

class SystemMonitor {
    func getInfos() throws -> SystemInfos {
        return SystemInfos(
            memory: try self.getMemoryInfos(),
            processor: try self.getProcessorInfos()
        )
    }
    
    func getMemoryInfos() throws -> MemoryUsage {
        return MemoryUsage(
            swapUsage: try MemoryHandler.getSwapInfos(),
            ramUsage: try MemoryHandler.getRAMInfos()
        )
    }
    
    func getProcessorInfos() throws -> CPUInfos {
        return CPUInfos(
            usage: try ProcessorHandler.getCPUUsage()
        )
    }
}
