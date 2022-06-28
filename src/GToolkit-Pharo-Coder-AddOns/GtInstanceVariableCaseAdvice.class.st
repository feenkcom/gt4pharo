Class {
	#name : #GtInstanceVariableCaseAdvice,
	#superclass : #GtVariableAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-Advice'
}

{ #category : #accessing }
GtInstanceVariableCaseAdvice >> description [
	^ (behavior name asString , ' has instance variable'
		, (variables size > 1 ifTrue: [ 's' ] ifFalse: [ '' ])
		, ' that start with uppercase letters '
		, (String
				streamContents: [ :stream | 
					stream nextPutAll: '('.
					variables
						do: [ :each | stream nextPutAll: each ]
						separatedBy: [ stream nextPutAll: ', ' ].
					stream nextPutAll: ').' ])) asRopedText
]

{ #category : #accessing }
GtInstanceVariableCaseAdvice >> name [
	^ 'Instance variable name should start with lowercase letters'
]
