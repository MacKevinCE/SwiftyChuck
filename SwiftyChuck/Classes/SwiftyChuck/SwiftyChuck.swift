//
//  SwiftyBeaver.swift
//  SwiftyBeaver
//
//  Created by Sebastian Kreutzberger (Twitter @skreutzb) on 28.11.15.
//  Copyright © 2015 Sebastian Kreutzberger
//  Some rights reserved: http://opensource.org/licenses/MIT
//
//
//  SwiftyChuck.swift
//  SwiftyChuck
//
//  Update by Mc Kevin on 14/07/22.
//

import Foundation

open class SwiftyChuck {
    static let destination = BaseDestination()
    public private(set) static var isEnabled: Bool = false
    public private(set) static var baseURL: String = empty
    public private(set) static var enverimoment: String = empty
    private(set) static var enableType: [ChuckLevel] = ChuckLevel.allCases
    static var isDetecting: Bool = true
    static var searchText: String = empty
    static var searchTextDetail: String = empty
    static var tabControl: Int = .zero
    static var tabControlDetail: Int = .zero
    static var dataChuck: [any OutputProtocol] = []

    // MARK: Setting Handling

    open class func setBaseURL(_ baseURL: String) {
        self.baseURL = baseURL
    }

    open class func setEnverimoment(_ enverimoment: String) {
        self.enverimoment = enverimoment
    }

    open class func isEnabled(_ isEnabled: Bool) {
        self.isEnabled = isEnabled
    }

    open class func setEnableType(_ enableType: [ChuckLevel]) {
        self.enableType = enableType.isEmpty ? ChuckLevel.allCases : enableType
        self.enableType.uniqued()
    }

    open class func addEnableType(_ enableType: ChuckLevel) {
        self.enableType.append(enableType)
        self.enableType.uniqued()
    }

    open class func addEnableType(_ enableType: [ChuckLevel]) {
        self.enableType.append(contentsOf: enableType)
        self.enableType.uniqued()
    }

    // MARK: Method Handling

    open class func resetChuck() {
        searchText = empty
        searchTextDetail = empty
        tabControl = .zero
        tabControlDetail = .zero
        dataChuck.removeAll()
    }

    open class func remove(_ id: UUID) {
        guard let index = dataChuck.firstIndex(where: { $0.id == id }) else { return }
        dataChuck.remove(at: index)
    }

    open class func removeChuck(_ chuck: (any OutputProtocol)?) {
        guard let id = chuck?.id else { return }
        remove(id)
    }

    /// returns the current thread name
    open class func threadName() -> String {
        if Thread.isMainThread {
            return ""
        } else {
            let name = __dispatch_queue_get_label(nil)
            return String(cString: name, encoding: .utf8) ?? Thread.current.description
        }
    }

    // MARK: Chucks add

    /// log something generally unimportant (lowest priority)
    open class func print(_ items: Any..., separator: String = " ", terminator: String = "\n",
                          file: String = #file, function: String = #function, line: Int = #line)
    {
        custom(InputLog(items, separator: separator, terminator: terminator, .print, file, function, line))
    }

    /// log something which help during debugging (low priority)
    open class func debug(_ items: Any..., separator: String = " ", terminator: String = "\n",
                          file: String = #file, function: String = #function, line: Int = #line)
    {
        custom(InputLog(items, separator: separator, terminator: terminator, .debug, file, function, line))
    }

    /// log something which you are really interested but which is not an issue or error (normal priority)
    open class func info(_ items: Any..., separator: String = " ", terminator: String = "\n",
                         file: String = #file, function: String = #function, line: Int = #line)
    {
        custom(InputLog(items, separator: separator, terminator: terminator, .info, file, function, line))
    }

    /// log something which may cause big trouble soon (high priority)
    open class func warning(_ items: Any..., separator: String = " ", terminator: String = "\n",
                            file: String = #file, function: String = #function, line: Int = #line)
    {
        custom(InputLog(items, separator: separator, terminator: terminator, .warning, file, function, line))
    }

    /// log something which will keep you awake at night (highest priority)
    open class func error(_ items: Any..., separator: String = " ", terminator: String = "\n",
                          file: String = #file, function: String = #function, line: Int = #line)
    {
        custom(InputLog(items, separator: separator, terminator: terminator, .error, file, function, line))
    }

    /// log something which you are really interested but which is not an issue or error (normal priority)
    open class func service(_ urlResponse: URLResponse?,
                            _ request: URLRequest?,
                            _ data: Data?,
                            _ error: Error? = nil,
                            _ typeRequest: String? = nil,
                            _ typeResponse: String? = nil,
                            file: String = #file, function: String = #function, line: Int = #line)
    {
        custom(InputService(urlResponse, request, data, error, typeRequest, typeResponse, file, function, line))
    }

    open class func classInit(_ id: UUID, _ anyObject: AnyObject, file: String = #file, function: String = #function, line: Int = #line) {
        return custom(InputARC(id, anyObject, .inital, file, function, line))
    }

    /// custom logging to manually adjust values, should just be used by other frameworks
    open class func custom(_ chuck: any InputProtocol) {
        dispatch_send(chuck, thread: threadName())
    }

    /// internal helper which dispatches send to dedicated queue if minLevel is ok
    class func dispatch_send(_ chuck: any InputProtocol, thread: String) {
        guard let queue = destination.queue else { return }

        if destination.asynchronously {
            queue.async {
                _ = destination.send(chuck, thread: thread)
            }
        } else {
            queue.sync {
                _ = destination.send(chuck, thread: thread)
            }
        }
    }

    static func openViewChuckDebug() {
        guard let owner = UIApplication.rootViewController else { return }
        let final = owner.presentedViewController ?? owner
        let navigation = UINavigationController(rootViewController: ChuckDebugAssembly.build())
        navigation.isNavigationBarHidden = true
        final.present(navigation, animated: true, completion: nil)
    }
}
