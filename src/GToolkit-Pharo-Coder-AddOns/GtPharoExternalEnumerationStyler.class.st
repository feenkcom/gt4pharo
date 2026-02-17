Class {
	#name : #GtPharoExternalEnumerationStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'isInReturn',
		'isInstanceSide'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Color'
}

{ #category : #initialization }
GtPharoExternalEnumerationStyler >> initialize [
	super initialize.
	
	isInReturn := false.
	isInstanceSide := false
]

{ #category : #'instance creation' }
GtPharoExternalEnumerationStyler >> newButtonAttribute: aValue [
	^ GtButtonAttribute new
		beAppend;
		stencil: [ BrButton new 
			aptitude: BrGlamorousLinkSquaredButtonWithLabelAptitude new;
			beSmallSize;
			margin: (BlInsets top: 0 left: 0 bottom: 0 right: 0);
			padding: (BlInsets top: 0 left: 5 bottom: 0 right: 5);
			model: aValue;
			label: ('= {1}' format: { aValue printString });
			action: [ :aButton | aButton phlow spawnObject: aButton model ] ]
]

{ #category : #'instance creation' }
GtPharoExternalEnumerationStyler >> noValuesAttribute [
	^ (GtSourceCoderErrorAttribute for: 'Enumaration must have at least one value') openOnFirstShow: false
]

{ #category : #styling }
GtPharoExternalEnumerationStyler >> styleValueDeclarations: splitValues [
	| previousValue |
	previousValue := -1.
	splitValues
		do: [ :eachValues | 
			| eachLiteralValues eachAssoc |
			eachLiteralValues := eachValues collect: [ :each | each literalValue ].

			eachAssoc := [ GtExternalEnumeration
					parseVariant: eachLiteralValues
					previousValue: previousValue ]
					on: Error
					do: [ :anError | 
						| errorAttribute |
						errorAttribute := BlTextDecorationAttribute new underline
								color: BlTheme default editor pharoErrorTokenForeground.

						self
							attribute: errorAttribute
							from: eachValues first startPosition
							to: eachValues last stopPosition.

						^ self ].

		eachValues size = 1
			ifTrue: [ self
							attribute: (self newButtonAttribute: eachAssoc value)
							from: eachValues last startPosition
							to: eachValues last stopPosition. ].
			
		previousValue := eachAssoc value ]
]

{ #category : #generated }
GtPharoExternalEnumerationStyler >> visitArrayLiteral: anArrayLiteral [
	| hasLastComma literalValue splitValues |
	super visitArrayLiteral: anArrayLiteral.
	
	isInReturn ifFalse: [ ^ self ].
	
	anArrayLiteral values ifEmpty: [
		^ self
			attribute: self noValuesAttribute
			from: anArrayLiteral arrayStop startPosition
			to: anArrayLiteral arrayStop stopPosition ].
	
	literalValue := anArrayLiteral literalValue.
	hasLastComma := literalValue last = #,.
	
	splitValues := (anArrayLiteral values splitOn: [ :each | each literalValue = #, ]).
	(hasLastComma and: [ splitValues last isEmpty ])
		ifTrue: [ splitValues := splitValues allButLast ].
	
	self styleValueDeclarations: splitValues
]

{ #category : #generated }
GtPharoExternalEnumerationStyler >> visitMethod: aMethod [
	| behavior |

	aMethod selector = #externalDeclaration
		ifFalse: [ ^ self ].

	behavior := self coderViewModel coderModel behavior.
	isInstanceSide := behavior isInstanceSide.
		
	(behavior instanceSide inheritsFrom: GtExternalEnumeration)
		ifFalse: [ ^ self ].
		
	super visitMethod: aMethod
]

{ #category : #generated }
GtPharoExternalEnumerationStyler >> visitReturn: aReturn [
	| wasInReturn |
	
	wasInReturn := isInReturn.
	isInReturn := true.
	[ 
		super visitReturn: aReturn.
	] ensure: [ isInReturn := wasInReturn ]
	
]
