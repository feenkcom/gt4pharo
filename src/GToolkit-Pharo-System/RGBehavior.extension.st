Extension { #name : #RGBehavior }

{ #category : #'*GToolkit-Pharo-System' }
RGBehavior >> asRingDefinition [
	"Answer the receiver as a RGClassDefinition"
	| ringDefinition |

	ringDefinition := (RGClassDefinition named: self name).
	self 
		forPharo12: [
			ringDefinition
				package: (RGPackageDefinition 
					named: self package name asSymbol);
				packageTag: self packageTag ] 
		forPharo11AndPharo10: [
			ringDefinition
				category: self category;
				package: (RGPackageDefinition 
					named: self category asSymbol) ].
	ringDefinition
		superclassName: (self superclass
			ifNil: [ nil printString ]
			ifNotNil: [ self superclass name ]);
		traitCompositionSource: self traitCompositionString;
		addInstanceVariables: self instVarNames;
		addClassVariables: self classVarNames;
		addSharedPools: self sharedPoolNames;
		comment: self comment content;
		definitionSource: self definitionString;
		withMetaclass.
	ringDefinition classSide
		traitCompositionSource: self classSide traitCompositionString;
		definitionSource: self classSide definitionString;
		addInstanceVariables: self classSide instVarNames.
	^ ringDefinition
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
