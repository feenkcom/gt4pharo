Extension { #name : #RBAbstractClass }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBAbstractClass >> gtDirectlyDefinesMethod: aSelector [
	self isDefined
		ifTrue: [ (self hasRemoved: aSelector) ifTrue: [ ^ false ].
			((self realClass includesSelector: aSelector)
				and: [ (self realClass >> aSelector) isFromTrait not ]) ifTrue: [ ^ true ] ].
	^ newMethods notNil and: [ newMethods includesKey: aSelector ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBAbstractClass >> gtSelectorsReferToInstanceVariable: aString do: aBlock [
	newMethods
		ifNotNil: [ newMethods
				do: [ :each | (each refersToVariable: aString) ifTrue: [ aBlock value: each selector ] ] ].
	self isDefined ifFalse: [ ^ self ].
	self realClass
		slotNamed: aString
		ifFound: [ :slot | 
			self realClass selectors
				do: [ :sel | 
					((self hasRemoved: sel) or: [ self newMethods includesKey: sel ])
						ifFalse: [ (slot isAccessedIn: self realClass >> sel) ifTrue: [ aBlock value: sel ] ] ] ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBAbstractClass >> gtSelectorsReferToSymbol: aSelector do: aBlock [
	| specialIndex |
	newMethods
		ifNotNil: [ newMethods
				do: [ :each | (each refersToSymbol: aSelector) ifTrue: [ aBlock value: each selector ] ] ].
	self isDefined ifFalse: [ ^ self ].
	specialIndex := Smalltalk specialSelectorIndexOrNil: aSelector.
	self realClass methods
		do: [ :method | 
			| sel |
			sel := method selector.
			((self hasRemoved: sel) or: [ self newMethods includesKey: sel ])
				ifFalse: [ (method hasSelector: aSelector specialSelectorIndex: specialIndex)
						ifTrue: [ aBlock value: sel ] ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBAbstractClass >> gtWithAllSubclassesDo: aBlock [
	aBlock value: self.
	self subclassesDo: [ :each | each gtWithAllSubclassesDo: aBlock ]
]
