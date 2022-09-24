//
//  StatusCode+Helpers.swift
//  SportsNews
//
//  Created by Naveen George Thoppan on 11/08/2022.
//

import Foundation

typealias StatusCode = Int

extension StatusCode {

    var isSuccess: Bool {
        (200..<300).contains(self)
    }

}
