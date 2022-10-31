//
//  BaseDestination.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Dispatch
import Foundation


/// destination which all others inherit from. do not directly use
open class BaseDestination {
    /// runs in own serial background thread for better performance
    open var asynchronously = true

    // each destination instance must have an own serial queue to ensure serial output
    // GCD gives it a prioritization between User Initiated and Utility
    var queue: DispatchQueue? // dispatch_queue_t?

    public init() {
        let uuid = NSUUID().uuidString
        let queueLabel = "swiftybeaver-queue-" + uuid
        queue = DispatchQueue(label: queueLabel, target: queue)
    }

    /// send / store the formatted log message to the destination
    /// returns the formatted log message for processing by inheriting method
    /// and for unit tests (nil if error)
    func send(_ chuck: InputProtocol, thread: String) -> String? {
        DispatchQueue.main.async {
            guard SwiftyChuck.isDetecting else { return }
            if let service = chuck as? InputService {
                SwiftyChuck.dataChuck.append(OutputService(service: service))
            } else if let log = chuck as? InputLog {
                SwiftyChuck.dataChuck.append(OutputLog(log: log))
            } else if let vc = chuck as? InputARC {
                SwiftyChuck.dataChuck.append(OutputARC(arc: vc))
            }
        }
        return nil
    }

}
