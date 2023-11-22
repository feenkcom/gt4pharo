Extension { #name : #Object }

{ #category : #'*GToolkit-Pharo-Extensions' }
Object >> gtCustomSystemIconNameOrNil [
	"Returns the name of the system icon only if the system icon has a custom name, otherwise it returns nil. This was added so that in coder we only show the icon name when a class has a custom icon."
	| currentIconName |
	
	currentIconName := self systemIconName.
	(currentIconName isNil or: [ currentIconName isEmpty ]) ifTrue: [ ^ nil ].
	
	(currentIconName = Object systemIconName or: [ 
		currentIconName = AbstractLayout systemIconName ])
			ifTrue: [ 
				"We consider the system icons for normal and abstract classes as custom."
				^ nil ].
	
	^ currentIconName
]

{ #category : #'*GToolkit-Pharo-Extensions' }
Object >> gtSafeIconNamed: anIconName [
	^ [ self iconNamed: anIconName ] 
		on: Error
		do: [ :error | 
			Smalltalk ui icons iconNamed: #smallWarningIcon ]
]
