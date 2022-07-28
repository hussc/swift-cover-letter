//
//  File.swift
//  
//
//  Created by Hussein on 28/07/2022.
//

import Foundation
import ArgumentParser
import AppKit

extension URL: ExpressibleByArgument {
    public init?(argument: String) {
        self.init(fileURLWithPath: argument)
    }
}

struct GenerateLetter: ParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "generate",
        abstract: "Blah blah blah"
    )
    
    @Argument(help: "The template to use", completion: CompletionKind.file())
    private var template: URL
    
    @Option(name: .shortAndLong, help: "Company Name")
    private var company: String
    
    @Option(name: .shortAndLong, help: "Position name")
    private var position: String
    
    @Option(name: .shortAndLong, help: "Hiring Manager name")
    private var manager: String?
    
    @Option(name: .shortAndLong, help: "name of output file(the command only writes to current directory)")
    private var outputFile: URL?

    
    func run() throws {
        let contents = try String(contentsOf: template)
        
        // replace the contents
        var output = contents
        
        output = output.replacingOccurrences(of: "{{position}}", with: position)
        output = output.replacingOccurrences(of: "{{hiring-manager}}", with: manager ?? "Hiring Manager")
        output = output.replacingOccurrences(of: "{{company}}", with: company)
        
        
        if let outputFile = outputFile {
            try output.write(to: outputFile, atomically: true, encoding: String.Encoding.utf8)
        } else {
            print(output)
        }
    }
}
