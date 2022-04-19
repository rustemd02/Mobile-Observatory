//
//  PresenterProtocols.swift
//  Mobile-Observatory
//
//  Created by andrewoch on 07.04.2022.
//

import Foundation
import UIKit

protocol LoginPresenterInput {
    
}

protocol RegistrationPresenterInput {

}

protocol LoginPresenterOutput {
    func wantsToOpenRegistrtion()
    func didLogin()
}

protocol RegistrationPresenterOutput {
    func wantsToOpenLogin()
    func didRegister()
}
