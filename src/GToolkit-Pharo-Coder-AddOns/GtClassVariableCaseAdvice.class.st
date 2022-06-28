Class {
	#name : #GtClassVariableCaseAdvice,
	#superclass : #GtVariableAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-Advice'
}

{ #category : #accessing }
GtClassVariableCaseAdvice >> description [
	^ (behavior name asString , ' has class variable'
		, (variables size > 1 ifTrue: [ 's' ] ifFalse: [ '' ])
		, ' that start with lowercase letters '
		, (String
				streamContents: [ :stream | 
					stream nextPutAll: '('.
					variables
						do: [ :each | stream nextPutAll: each ]
						separatedBy: [ stream nextPutAll: ', ' ].
					stream nextPutAll: ').' ])) asRopedText
]

{ #category : #accessing }
GtClassVariableCaseAdvice >> name [
	^ 'Class variable name should start with uppercase letters'
]
