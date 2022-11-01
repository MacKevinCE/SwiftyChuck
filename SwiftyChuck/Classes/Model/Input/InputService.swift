//
//  InputService.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

struct InputService: InputProtocol, InputEquatable {
    let id: UUID
    let file: String
    let function: String
    let line: Int
    let type: ChuckLevel
    let colorText: String
    let state: String
    let method: String
    let url: String
    let endPoint: String
    let typeRequest: String
    let headersResquest: [ParString]
    let request: String
    let typeResponse: String
    let headersResponse: [ParString]
    let response: String
    let error: String
    let time: Date

    init(
        _ urlResponse: URLResponse?,
        _ request: URLRequest?,
        _ data: Data?,
        _ error: Error? = nil,
        _ typeRequest: String? = nil,
        _ typeResponse: String? = nil,
        _ file: String,
        _ function: String,
        _ line: Int
    ) {
        let response = urlResponse as? HTTPURLResponse
        self.id = UUID()
        self.file = file
        self.function = function
        self.line = line
        self.type = .service
        self.colorText = getColor(response)
        self.state = getState(response)
        self.method = getMethod(request)
        self.url = getUrl(request)
        self.endPoint = getEndPoint(request)
        self.typeRequest = typeRequest ?? empty
        self.headersResquest = getHeadersRequest(request)
        self.request = getRequest(request)
        self.typeResponse = typeResponse ?? empty
        self.headersResponse = getHeadersResponse(response)
        self.response = getResponse(data)
        self.error = getError(error)
        self.time = Date()
    }

    func output() -> OutputProtocol {
        return OutputService(service: self)
    }
}

struct ParString: Codable, Hashable {
    let key: String
    let value: String
}

func getState(_ response: HTTPURLResponse?) -> String {
    response?.statusCode.description ?? "RIP"
}

func getColor(_ response: HTTPURLResponse?) -> String {
    if let status = response?.statusCode {
        switch status {
        case 200: return UIColor.black.toHexString()
        case 201 ... 299: return UIColor.green.toHexString()
        case 300 ... 399: return UIColor.blue.toHexString()
        case 400 ... 499: return UIColor.orange.toHexString()
        default: return UIColor.red.toHexString()
        }
    } else {
        return UIColor.red.toHexString()
    }
}

func getMethod(_ request: URLRequest?) -> String {
    request?.httpMethod ?? "T_T"
}

func getUrl(_ request: URLRequest?) -> String {
    request?.debugDescription ?? "~/<¡_¡>"
}

func getEndPoint(_ request: URLRequest?) -> String {
    getUrl(request).replacingOccurrences(of: SwiftyChuck.baseURL, with: "~")
}

func getRequest(_ request: URLRequest?) -> String {
    return getResponse(request?.httpBody)
}

func getHeadersRequest(_ request: URLRequest?) -> [ParString] {
    request?.allHTTPHeaderFields?.map { ParString(key: $0.key, value: $0.value) } ?? []
}

func getResponse(_ data: Data?) -> String {
    let pretty = data?.prettyPrintedJSONString?.null()
    let normal = data.map { String(decoding: $0, as: UTF8.self) }
    let final = normal?.replacingOccurrences(of: "&", with: "\n").null()
    return pretty ?? final ?? "None"
}

func getHeadersResponse(_ response: HTTPURLResponse?) -> [ParString] {
    response?.allHeaderFields.map { ParString(key: $0.key.description, value: ($0.value as AnyObject).description ?? empty) } ?? []
}

func getError(_ error: Error?) -> String {
    error?.localizedDescription ?? empty
}
