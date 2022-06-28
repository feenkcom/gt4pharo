Class {
	#name : #GtAllSubclassesDefineVariableAdvice,
	#superclass : #GtVariableAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-Advice'
}

{ #category : #accessing }
GtAllSubclassesDefineVariableAdvice >> description [
	^ ('All subclasses of ' , behavior name asString
		, ' define common instance variable'
		, (String
				streamContents: [ :stream | 
					variables size > 1 ifTrue: [ stream nextPut: $s ].
					stream nextPutAll: ' ('.
					variables
						do: [ :each | stream nextPutAll: each ]
						separatedBy: [ stream nextPutAll: ', ' ].
					stream nextPutAll: ').' ])) asRopedText
]

{ #category : #accessing }
GtAllSubclassesDefineVariableAdvice >> name [
	^ 'Variable defined in all subclasses'
]
