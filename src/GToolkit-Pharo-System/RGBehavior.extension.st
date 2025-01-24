Extension { #name : #RGBehavior }

{ #category : #'*GToolkit-Pharo-System' }
RGBehavior >> asRingDefinition [
	"Answer the receiver as a RGClassDefinition"
	| ring |

	ring := (RGClassDefinition named: self name)
		category: self category;
		superclassName: (self superclass
			ifNil: [ nil printString ]
			ifNotNil: [ self superclass name ]);
		traitCompositionSource: self traitCompositionString;
		addInstanceVariables: self instVarNames;
		addClassVariables: self classVarNames;
		addSharedPools: self sharedPoolNames;
		comment: self comment;
		definitionSource: self definitionString;
		package: self package;
		withMetaclass.
	ring classSide
		traitCompositionSource: self classSide traitCompositionString;
		definitionSource: self classSide definitionString;
		addInstanceVariables: self classSide instVarNames.
	^ ring
]

{ #category : #'*GToolkit-Pharo-System' }
RGBehavior >> inheritsFrom: aClass [ 
	<gtPharoPatch: #Pharo>
	"Answer whether the argument, aClass, is on the receiver's superclass 
	chain."
	| aSuperclass |

	aSuperclass := self superclass.
	[ aSuperclass == nil ]
		whileFalse: [
			| aNextSuperclass |
			aSuperclass == aClass
				ifTrue: [ ^true ].
				
			aNextSuperclass := aSuperclass superclass.
			(aNextSuperclass isNil or: [ aNextSuperclass == aSuperclass ])
				ifTrue: [ ^ false ].
			aSuperclass := aNextSuperclass ].
	^false
]

{ #category : #'*GToolkit-Pharo-System' }
RGBehavior >> subclasses [
	<gtPharoPatch: #Pharo>
	
	^ self backend forBehavior subclassesFor: self
]
