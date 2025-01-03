//
//  FBSettings.swift
//  FormBuilder
//
//  Created by Nathan Glenn on 1/21/18.
//  Copyright © 2018 Nathan Glenn. All rights reserved.
//

import Foundation

open class FBSettings: NSObject
{
    var editable:Bool = true
    var formats:Dictionary<String, String> = Dictionary<String, String>()
    var optionSet:Dictionary<String, FBOptionSet> = Dictionary<String, FBOptionSet>()
    
    open func load(file: String)
    {
        let settingsFile:FBFile = FBFile(file: file)
        
        var i:Int = 0
        
        while (i < settingsFile.lines.count)
        {
            switch (settingsFile.lines[i].keyword)
            {
            case FBKeyWord.Format:
                let indentLevel:Int = settingsFile.lines[i].indentLevel
                let spaceLevel:Int = settingsFile.lines[i].spaceLevel
                i += 1
                var key:String? = nil
                var value:String? = nil
                while (i < settingsFile.lines.count)
                {
                    if ((settingsFile.lines[i].indentLevel > indentLevel) ||
                        (settingsFile.lines[i].spaceLevel > spaceLevel) ||
                        (settingsFile.lines[i].keyword == FBKeyWord.None))
                    {
                        if (settingsFile.lines[i].keyword == FBKeyWord.Id)
                        {
                            key = settingsFile.lines[i].value
                        }
                        if (settingsFile.lines[i].keyword == FBKeyWord.Value)
                        {
                            value = settingsFile.lines[i].value
                        }
                        i += 1
                    }
                    else
                    {
                        break
                    }
                }
                if (key != nil && value != nil)
                {
                    self.formats.updateValue(value!, forKey: key!)
                }
                
                break
            case FBKeyWord.OptionSet:
                let indentLevel:Int = settingsFile.lines[i].indentLevel
                let spaceLevel:Int = settingsFile.lines[i].spaceLevel
                i += 1
                var optionSetRange = (i, i)
                var optionId:String = ""
                var inOption:Bool = false
                while (i < settingsFile.lines.count)
                {
                    if ((settingsFile.lines[i].indentLevel > indentLevel) ||
                        (settingsFile.lines[i].spaceLevel > spaceLevel) ||
                        (settingsFile.lines[i].keyword == FBKeyWord.None))
                    {
                        if ((settingsFile.lines[i].keyword == FBKeyWord.Id) && !inOption)
                        {
                            optionId = settingsFile.lines[i].value
                        }
                        else if (settingsFile.lines[i].keyword == FBKeyWord.Option)
                        {
                            inOption = true
                        }
                        i += 1
                    }
                    else
                    {
                        break
                    }
                }
                optionSetRange.1 = i - 1
                self.optionSet[optionId] = FBOptionSet(field: nil, file: settingsFile, lines: optionSetRange)
                break
            default:
                i += 1
                
                break
            }
        }
    }
    
    open func load(path: String)
    {
        let settingsFile:FBFile = FBFile(path: path)
        
        var i:Int = 0
        
        while (i < settingsFile.lines.count)
        {
            switch (settingsFile.lines[i].keyword)
            {
            case FBKeyWord.Format:
                let indentLevel:Int = settingsFile.lines[i].indentLevel
                let spaceLevel:Int = settingsFile.lines[i].spaceLevel
                i += 1
                var key:String? = nil
                var value:String? = nil
                while (i < settingsFile.lines.count)
                {
                    if ((settingsFile.lines[i].indentLevel > indentLevel) ||
                        (settingsFile.lines[i].spaceLevel > spaceLevel) ||
                        (settingsFile.lines[i].keyword == FBKeyWord.None))
                    {
                        if (settingsFile.lines[i].keyword == FBKeyWord.Id)
                        {
                            key = settingsFile.lines[i].value
                        }
                        if (settingsFile.lines[i].keyword == FBKeyWord.Value)
                        {
                            value = settingsFile.lines[i].value
                        }
                        i += 1
                    }
                    else
                    {
                        break
                    }
                }
                if (key != nil && value != nil)
                {
                    self.formats.updateValue(value!, forKey: key!)
                }
                
                break
            case FBKeyWord.OptionSet:
                let indentLevel:Int = settingsFile.lines[i].indentLevel
                let spaceLevel:Int = settingsFile.lines[i].spaceLevel
                i += 1
                var optionSetRange = (i, i)
                var optionId:String = ""
                var inOption:Bool = false
                while (i < settingsFile.lines.count)
                {
                    if ((settingsFile.lines[i].indentLevel > indentLevel) ||
                        (settingsFile.lines[i].spaceLevel > spaceLevel) ||
                        (settingsFile.lines[i].keyword == FBKeyWord.None))
                    {
                        if ((settingsFile.lines[i].keyword == FBKeyWord.Id) && !inOption)
                        {
                            optionId = settingsFile.lines[i].value
                        }
                        else if (settingsFile.lines[i].keyword == FBKeyWord.Option)
                        {
                            inOption = true
                        }
                        i += 1
                    }
                    else
                    {
                        break
                    }
                }
                optionSetRange.1 = i - 1
                self.optionSet[optionId] = FBOptionSet(field: nil, file: settingsFile, lines: optionSetRange)
                break
            default:
                i += 1
                
                break
            }
        }
    }

    public init(file: String)
    {
        super.init()

        self.load(file: file)
    }
}
