//
//  Document.swift
//  Doc-BasedAppDemo
//
//  Created by zz on 18/09/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

import UIKit

class Document: UIDocument {
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
    }
}

