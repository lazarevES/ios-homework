//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Егор Лазарев on 15.09.2022.
//

import Foundation
import LocalAuthentication

class LocalAuthorizationService {
	
	private var context = LAContext()
	private let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
	private var canUseBiometrics = false
	private var callback: ((Bool) -> Void)?
	
	func canUseBiometricalAuthentication() -> Bool {
		var error: NSError?
		canUseBiometrics = context.canEvaluatePolicy(policy, error: &error)
		if let error = error {
			print(error.localizedDescription)
		}
		return canUseBiometrics
	}
	
	func isFaceID() -> Bool {
		context.biometryType == .faceID
	}
	
	func useBiometricalAuthentication(callback: @escaping (Bool) -> Void) {
		self.callback = callback
		context.evaluatePolicy(policy,
							   localizedReason: "Авторизуйтесь для входа") { [weak self] result, error in
			if let error = error {
				print(error.localizedDescription)
			}
			
			if let callback = self?.callback {
				callback(result)
			}
		}
	}
	
}
