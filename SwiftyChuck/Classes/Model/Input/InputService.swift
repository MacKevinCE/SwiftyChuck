//
//  InputService.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

struct InputService: InputProtocol {
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

    func output() -> any OutputProtocol {
        return OutputService(service: self)
    }

    func getTabPreview() -> NSMutableAttributedString {
        let colorText = UIColor(hexString: self.colorText)
        let colorState: UIColor = (colorText == .black) ? .green : colorText
        return "\(self.state)"
            .initAttributeIndentation(indentation: 35)
            .addAttributeText(color: colorState, font: .semibold16)
            .printSpacer().printSpacer()
            .addTextWithAttributeText(text: self.method.uppercased(), color: colorText, font: .semibold14)
            .printSpacer().printSpacer()
            .addTextWithAttributeText(text: self.endPoint.resumen(), color: colorText, font: .regular14)
            .printEnter().printTab().printTab().printSpacer()
            .addTextWithAttributeText(text: self.time.toString(), color: .gray, font: .regular12)
    }

    func getTabAll() -> NSMutableAttributedString {
        var pares: [ParString] = []
        pares.append(ParString(key: "ID", value: self.id.uuidString))
        pares.append(ParString(key: "Method", value: self.method))
        pares.append(ParString(key: "URL", value: self.url))
        pares.append(ParString(key: "Error", value: self.error))
        pares.append(ParString(key: "Request Headers", value: self.headersResquest.toString()))
        pares.append(ParString(key: "Request Body", value: self.request))
        pares.append(ParString(key: "Response Status", value: self.state))
        pares.append(ParString(key: "Response Headers", value: self.headersResponse.toString()))
        pares.append(ParString(key: "Response Body", value: self.response))
        pares.append(ParString(key: "File", value: self.file))
        pares.append(ParString(key: "Function", value: self.function))
        pares.append(ParString(key: "Line", value: String(self.line)))
        pares.append(ParString(key: "Time", value: self.time.toString(with: .iso8601)))

        return pares.reduce()
    }

    func getTabResume() -> NSMutableAttributedString {
        let colorText = UIColor(hexString: self.colorText)
        let colorState = (colorText == .black) ? .green : colorText

        var attributeText = empty.initAttributeText(font: .regular14)
            .printTitleChuck("URL")
            .printEnter()
            .addTextWithAttributeText(text: self.state, color: colorState, font: .semibold14)
            .printSpacer().printSpacer()
            .addAttributeIndentation(indentation: 35)
            .addTextWithAttributeText(text: self.method.uppercased(), color: colorText, font: .semibold14)
            .printSpacer().printSpacer()
            .addTextWithAttributeText(text: self.url, color: colorText, font: .regular14)
            .printEnter()

        if let err = self.error.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("ERROR", color: .red)
                .printEnter()
                .addTextWithAttributeText(text: err, color: .red, font: .regular14)
                .printEnter()
        }

        if let typeRequest = self.typeRequest.null(),
           let typeResponse = self.typeResponse.null()
        {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("TYPE")
                .printEnter()
                .printParStringForChuck(ParString(key: "TYPE REQUEST", value: typeRequest))
                .printEnter()
                .printParStringForChuck(ParString(key: "TYPE RESPONSE", value: typeResponse))
                .printEnter()
        }

        if let request = self.request.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("REQUEST")
                .printEnter()
                .printJSONForChuck(request)
                .printEnter()
        }
        if let response = self.response.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("RESPONSE")
                .printEnter()
                .printJSONForChuck(response)
                .printEnter()
        }
        return attributeText
    }

    func getTabRequest() -> NSMutableAttributedString {
        var attributeText = empty.initAttributeText(font: .regular14)

        if let request = self.request.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("REQUEST BODY")
                .printEnter()
                .printJSONForChuck(request)
                .printEnter()
        }
        if self.headersResquest.count > 0 {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("REQUEST HEADER")
                .printEnter()
            self.headersResquest.forEach {
                attributeText = attributeText
                    .printParStringForChuck($0)
                    .printEnter()
            }
        }
        return attributeText
    }

    func getTabResponse() -> NSMutableAttributedString {
        var attributeText = empty.initAttributeText(font: .regular14)

        if let response = self.response.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("RESPONSE BODY")
                .printEnter()
                .printJSONForChuck(response)
                .printEnter()
        }
        if self.headersResponse.count > 0 {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("RESPONSE HEADER")
                .printEnter()
            self.headersResponse.forEach {
                attributeText = attributeText
                    .printParStringForChuck($0)
                    .printEnter()
            }
        }
        return attributeText
    }
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
