//
//  HistoricalEvent.swift
//  BoutTime
//
//  Created by Aaron on 5/3/16.
//  Copyright © 2016 Aaron A. All rights reserved.
//

import Foundation
import GameplayKit

class HistoricalEvent: Equatable, CustomStringConvertible {
    let event: String
    let date: Int
    
    var description: String {
        return "\(event)"
    }
    
    init(event: String, date: Int) {
        self.event = event
        self.date = date
    }
}


func == (lhs: HistoricalEvent, rhs: HistoricalEvent) -> Bool {
    return lhs.date == rhs.date && lhs.event == rhs.event
}

// Data Set
let georgeWashington = HistoricalEvent(event:"George Washington", date: 1789)
let johnAdams = HistoricalEvent(event:"John Adams", date: 1797)
let thomasJefferson = HistoricalEvent(event:"Thomas Jefferson", date: 1801)
let jamesMadison = HistoricalEvent(event:"James Madison", date: 1809)
let jamesMonroe = HistoricalEvent(event:"James Monroe", date: 1817)
let johnQuincyAdams = HistoricalEvent(event:"John Quincy Adams", date: 1825)
let andrewJackson = HistoricalEvent(event:"Andrew Jackson", date: 1829)
let martinVanBuren = HistoricalEvent(event:"Martin Van Buren", date: 1837)
let williamHenryHarrison = HistoricalEvent(event:"William Henry Harrison", date: 1841)
let johnTyler = HistoricalEvent(event:"John Tyler", date: 1842)
let jamesKPolk = HistoricalEvent(event:"James K. Polk", date: 1845)
let zacharyTaylor = HistoricalEvent(event:"Zachary Taylor", date: 1849)
let millardFillmore = HistoricalEvent(event:"Millard Fillmore", date: 1850)
let franklinPierce = HistoricalEvent(event:"Franklin Pierce", date: 1853)
let jamesBuchanan = HistoricalEvent(event:"James Buchanan", date: 1857)
let abrahamLincoln = HistoricalEvent(event:"Abraham Lincoln", date: 1861)
let andrewJohnson = HistoricalEvent(event:"Andrew Johnson", date: 1865)
let ulyssesSGrant = HistoricalEvent(event:"Ulysses S. Grant", date: 1869)
let rutherfordBHayes = HistoricalEvent(event:"Rutherford B. Hayes", date: 1877)
let jamesAGarfield = HistoricalEvent(event:"James A. Garfield", date: 1881)
let chesterAArthur = HistoricalEvent(event:"Chester A. Arthur", date: 1882)
let groverCleveland1 = HistoricalEvent(event:"Grover Cleveland 1st term", date: 1885)
let benjaminHarrison = HistoricalEvent(event:"Benjamin Harrison", date: 1889)
let groverCleveland2 = HistoricalEvent(event:"Grover Cleveland 2nd term", date: 1893)
let williamMckinley = HistoricalEvent(event:"William McKinley", date: 1897)
let theodoreRoosevelt = HistoricalEvent(event:"Theodore Roosevelt", date: 1901)
let williamHowardTaft = HistoricalEvent(event:"William Howard Taft", date: 1909)
let woodrowWilson = HistoricalEvent(event:"Woodrow Wilson", date: 1913)
let warrenGHarding = HistoricalEvent(event:"Warren G. Harding", date: 1921)
let calvinCoolidge = HistoricalEvent(event:"Calvin Coolidge", date: 1923)
let herbertHoover = HistoricalEvent(event:"Herbert Hoover", date: 1929)
let franklinDRoosevelt = HistoricalEvent(event:"Franklin D. Roosevelt", date: 1933)
let harrySTruman = HistoricalEvent(event:"Harry S. Truman", date: 1945)
let dwightDEisenhower = HistoricalEvent(event:"Dwight D Eisenhower", date: 1953)
let johnFKennedy = HistoricalEvent(event:"John F. Kennedy", date: 1961)
let lyndonBJohnson = HistoricalEvent(event:"Lyndon B. Johnson", date: 1963)
let richardNixon = HistoricalEvent(event:"Richard Nixon", date: 1969)
let geraldFord = HistoricalEvent(event:"Gerald Ford", date: 1974)
let jimmyCarter = HistoricalEvent(event:"Jimmy Carter", date: 1977)
let ronaldReagan = HistoricalEvent(event:"Ronald Reagan", date: 1981)
let georgeHWBush = HistoricalEvent(event: "George H. W. Bush", date: 1989)
let billClinton = HistoricalEvent(event: "Bill Clinton", date: 1993)
let georgeWBush = HistoricalEvent(event: "George W. Bush", date: 2001)
let barackObama = HistoricalEvent(event: "Barack Obama", date: 2009)



var appleProducts = [georgeWashington, johnAdams, thomasJefferson, jamesMadison, jamesMonroe, johnQuincyAdams, andrewJackson,martinVanBuren, williamHenryHarrison, johnTyler, jamesKPolk, zacharyTaylor, millardFillmore, franklinPierce, jamesBuchanan, abrahamLincoln, andrewJohnson, ulyssesSGrant, rutherfordBHayes, jamesAGarfield, chesterAArthur, groverCleveland1, benjaminHarrison, groverCleveland2, williamMckinley, theodoreRoosevelt, williamHowardTaft, woodrowWilson, warrenGHarding, calvinCoolidge, herbertHoover, franklinDRoosevelt, harrySTruman, dwightDEisenhower, johnFKennedy, lyndonBJohnson, richardNixon, geraldFord,jimmyCarter, ronaldReagan, georgeHWBush, billClinton, georgeWBush,barackObama]



