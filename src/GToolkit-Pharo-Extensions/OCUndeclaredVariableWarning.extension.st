Extension { #name : #OCUndeclaredVariableWarning }

{ #category : #'*GToolkit-Pharo-Extensions' }
OCUndeclaredVariableWarning >> errorMessage [
	^ self 
		forPharo12: [
			'Undeclared temp: ', self node  name ] 
		forPharo11AndPharo10: [ super errorMessage ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
OCUndeclaredVariableWarning >> location [
	^ self 
		forPharo12: [
			self node sourceInterval first ] 
		forPharo11AndPharo10: [ super location ]
]
