import ArgumentParser

struct CoverLetterGenerator: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "coverletter",
        abstract: "A way to generate cover letter with company name",
        subcommands: [GenerateLetter.self]
    )
    
    init() { }
}

CoverLetterGenerator.main()
