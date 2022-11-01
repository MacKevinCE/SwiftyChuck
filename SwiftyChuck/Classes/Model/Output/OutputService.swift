//
//  OutputService.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

struct OutputService: OutputProtocol, OutputEquatable {
    let id: UUID
    let type: ChuckLevel
    let colorText: String
    let title: String
    let previewAttributed: NSMutableAttributedString
    let detailTabs: [DetailTabs]
    
    init(service: InputService) {
        self.id = service.id
        self.type = service.type
        self.colorText = service.colorText
        self.title = service.endPoint.resumen()
        self.previewAttributed = OutputService.getPreview(service)
        self.detailTabs = [
            DetailTabs(name: "RESUME", attributed: OutputService.getResume(service)),
            DetailTabs(name: "REQUEST", attributed: OutputService.getRequest(service)),
            DetailTabs(name: "RESPONSE", attributed: OutputService.getResponse(service)),
            DetailTabs(name: "All", attributed: OutputService.getAll(service))
        ]
    }
    
    private static func getPreview(_ service: InputService) -> NSMutableAttributedString {
        let colorText = UIColor(hexString: service.colorText)
        let colorState: UIColor = (colorText == .black) ? .green : colorText
        return service.state
            .initAttributeIndentation(indentation: 35)
            .addAttributeText(color: colorState, font: .semibold16)
            .printSpacer().printSpacer()
            .addTextWithAttributeText(text: service.method.uppercased(), color: colorText, font: .semibold14)
            .printSpacer().printSpacer()
            .addTextWithAttributeText(text: service.endPoint.resumen(), color: colorText, font: .regular14)
            .printEnter().printTab().printTab().printSpacer()
            .addTextWithAttributeText(text: service.time.toString(), color: .gray, font: .regular12)
    }
    
    private static func getAll(_ service: InputService) -> NSMutableAttributedString {
        var pares: [ParString] = []
        pares.append(ParString(key: "ID", value: service.id.uuidString))
        pares.append(ParString(key: "Method", value: service.method))
        pares.append(ParString(key: "URL", value: service.url))
        pares.append(ParString(key: "Error", value: service.error))
        pares.append(ParString(key: "Request Headers", value: service.headersResquest.toString()))
        pares.append(ParString(key: "Request Body", value: service.request))
        pares.append(ParString(key: "Response Status", value: service.state))
        pares.append(ParString(key: "Response Headers", value: service.headersResponse.toString()))
        pares.append(ParString(key: "Response Body", value: service.response))
        pares.append(ParString(key: "File", value: service.file))
        pares.append(ParString(key: "Function", value: service.function))
        pares.append(ParString(key: "Line", value: String(service.line)))
        pares.append(ParString(key: "Time", value: service.time.toString(with: .iso8601)))
        
        return pares.reduce()
    }
    
    private static func getResume(_ service: InputService) -> NSMutableAttributedString {
        let colorText = UIColor(hexString: service.colorText)
        let colorState = (colorText == .black) ? .green : colorText
        
        var attributeText = empty.initAttributeText(font: .regular14)
            .printTitleChuck("URL")
            .printEnter()
            .addTextWithAttributeText(text: service.state, color: colorState, font: .semibold14)
            .printSpacer().printSpacer()
            .addAttributeIndentation(indentation: 35)
            .addTextWithAttributeText(text: service.method.uppercased(), color: colorText, font: .semibold14)
            .printSpacer().printSpacer()
            .addTextWithAttributeText(text: service.url, color: colorText, font: .regular14)
            .printEnter()
        
        if let err = service.error.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("ERROR", color: .red)
                .printEnter()
                .addTextWithAttributeText(text: err, color: .red, font: .regular14)
                .printEnter()
        }
        
        if let typeRequest = service.typeRequest.null(),
           let typeResponse = service.typeResponse.null()
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
        
        if let request = service.request.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("REQUEST")
                .printEnter()
                .printJSONForChuck(request)
                .printEnter()
        }
        if let response = service.response.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("RESPONSE")
                .printEnter()
                .printJSONForChuck(response)
                .printEnter()
        }
        return attributeText
    }
    
    private static func getRequest(_ service: InputService) -> NSMutableAttributedString {
        var attributeText = empty.initAttributeText(font: .regular14)
        
        if let request = service.request.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("REQUEST BODY")
                .printEnter()
                .printJSONForChuck(request)
                .printEnter()
        }
        if service.headersResquest.count > 0 {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("REQUEST HEADER")
                .printEnter()
            service.headersResquest.forEach {
                attributeText = attributeText
                    .printParStringForChuck($0)
                    .printEnter()
            }
        }
        return attributeText
    }
    
    private static func getResponse(_ service: InputService) -> NSMutableAttributedString {
        var attributeText = empty.initAttributeText(font: .regular14)
        
        if let response = service.response.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("RESPONSE BODY")
                .printEnter()
                .printJSONForChuck(response)
                .printEnter()
        }
        if service.headersResponse.count > 0 {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("RESPONSE HEADER")
                .printEnter()
            service.headersResponse.forEach {
                attributeText = attributeText
                    .printParStringForChuck($0)
                    .printEnter()
            }
        }
        return attributeText
    }
}
