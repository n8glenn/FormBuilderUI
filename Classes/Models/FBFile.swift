//
//  FBFile.swift
//  FormBuilder
//
//  Created by Nathan Glenn on 5/3/18.
//  Copyright © 2018 Nathan Glenn. All rights reserved.
//

import Foundation 

public class FBFile: NSObject
{
    public var lines:[FBFileLine] = []
    
    public override init()
    {
        super.init()

    }
    
    public init(file:String)
    {
        super.init()
        self.load(file: file)
    }
    
    public func load(file: String)
    {
        var path:URL? = nil
        path = Bundle.main.url(forResource: file, withExtension: "spec")
        if (path == nil)
        {
            let bundle = Bundle.init(for: self.classForCoder)
            path = bundle.url(forResource: file, withExtension: "spec")
        }
        if (path == nil)
        {
            let bundle = Bundle.init(for: self.classForCoder)
            if let bundleURL = bundle.url(forResource: "FormBuilderUI", withExtension: "bundle") {
                let podBundle = Bundle(url: bundleURL)
                path = podBundle?.url(forResource: file, withExtension: "spec")
            }
        }
        if (path == nil) {
            return
        }
        
        do {
            let content = try String(contentsOf: path!, encoding: .utf8)
            var textlines = content.split(separator: "\n")
            var continued:Bool = false
            while (textlines.count > 0)
            {
                let line:FBFileLine = FBFileLine.init(line: (textlines.first?.description)!, continued: continued)
                continued = line.continued
                lines.append(line)
                textlines.removeFirst()
            }
        } catch _ as NSError {
            return
        }
    }

    public init(path: String)
    {
        super.init()
        do {
            let content:String = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            var textlines = content.split(separator: "\n")
            var continued:Bool = false
            while (textlines.count > 0)
            {
                let line:FBFileLine = FBFileLine.init(line: (textlines.first?.description)!, continued: continued)
                continued = line.continued
                lines.append(line)
                textlines.removeFirst()
            }
        } catch _ as NSError {
            return
        }
    }
}
