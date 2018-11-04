//
//  RecognitionAnalyzer.swift
//  CUU
//
//  Created by Lara Marie Reimer on 19.07.18.
//

import Foundation

class RecognitionAnalyzer {
    let content: String
    
    init(with content: String) {
        self.content = content
    }
    
    func analyze(with completion:@escaping (_ result: String, _ prediction: String, _ isLast: Bool) -> Void) {
        // First, break the content down into sentences.
        let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
        tagger.string = content
        
        let range = NSRange(location: 0, length: content.utf16.count)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
        
        if #available(iOS 11.0, *) {
            tagger.enumerateTags(in: range, unit: .sentence, scheme: .tokenType, options: options) { tag, tokenRange, stop in
                
                let token = (content as NSString).substring(with: tokenRange)
                let isLast = tokenRange.contains(content.count - 1)
                
                var prediction = ""
                do {
                    prediction = try SentenceClassifier_TA_1().prediction(Content: bow(text: token)).Classified
                } catch {
                    print("Error prediction token: " + token)
                }
                
                // Do something with each token
                completion(token, prediction, isLast)
            }
        }
    }
    
    func bow(text: String) -> [String: Double] {
        // Now, create bags of word which we can analyze with our model.
        var bagOfWords = [String: Double]()
        
        let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
        let range = NSRange(location: 0, length: text.utf16.count)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
        tagger.string = text
        
        if #available(iOS 11.0, *) {
            tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { _, tokenRange, _ in
                let word = (text as NSString).substring(with: tokenRange)
                if bagOfWords[word] != nil {
                    bagOfWords[word]! += 1
                } else {
                    bagOfWords[word] = 1
                }
            }
        }
        
        return bagOfWords
    }
}
