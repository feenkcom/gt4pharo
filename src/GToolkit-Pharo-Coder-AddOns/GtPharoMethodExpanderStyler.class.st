Class {
	#name : #GtPharoMethodExpanderStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'variableBindings',
		'lastIndex',
		'evaluationContext'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Expander'
}

{ #category : #'as yet unclassified' }
GtPharoMethodExpanderStyler >> = anObject [
	^self class == anObject class
]

{ #category : #'as yet unclassified' }
GtPharoMethodExpanderStyler >> hash [
	^self class hash
]

{ #category : #initialization }
GtPharoMethodExpanderStyler >> initialize [
	super initialize.
	
	lastIndex := 0.
]

{ #category : #private }
GtPharoMethodExpanderStyler >> nextIndex [
	^ lastIndex := (lastIndex ifNil: [ 0 ]) + 1
]

{ #category : #'api - styling' }
GtPharoMethodExpanderStyler >> style: aText ast: theAst [
	variableBindings := self coderViewModel compositeVariableBindingsForStyling.
	evaluationContext := self coderViewModel evaluationContext.
	lastIndex := 0.
	[ super style: aText ast: theAst ]
		ensure: [ 
			variableBindings := nil.
			evaluationContext := nil ]
]

{ #category : #visiting }
GtPharoMethodExpanderStyler >> visitMessage: aMessage [
	| aMethodClass anAttribute aBuilder aClass aSelfObject aLookupStartClass |
	self visitProgram: aMessage.
	aMessage parent isNil ifTrue: [ ^ self ].
	aSelfObject := self coderViewModel selfObject.
	aClass := aSelfObject
			ifNil: [ self coderViewModel explicitProviderClass
					ifNil: [ self coderViewModel coderModel behavior ] ]
			ifNotNil: [ :theSelfObject | theSelfObject class ].
	aLookupStartClass := (aMessage parent receiver isVariable
			and: [ aMessage parent receiver isSuper ])
			ifTrue: [ self coderViewModel behavior ifNil: [ aClass ] ]
			ifFalse: [ aClass ].

	aMethodClass := GtPharoProgramNode
			typeOf: aMessage parent receiver
			in: aLookupStartClass
			bindings: variableBindings.

	aMethodClass ifNil: [ ^ self ].
	(aMethodClass canUnderstand: aMessage selector) ifFalse: [ ^ self ].

	anAttribute := GtPharoMethodExpanderAttribute
			forClass: aMethodClass
			andSelector: aMessage selector.
	anAttribute id: (GtPharoMethodExpanderId indexed: self nextIndex).
	aBuilder := GtPharoReceiverAndArgumentBindingsBuilder new
			parentCoderViewModel: coderViewModel;
			parentEvaluationContext: evaluationContext;
			parentSelfObjectHolder: coderViewModel selfObjectHolder;
			parentMessage: aMessage;
			parentExplicitProviderClass: self coderViewModel explicitProviderClass;
			parentExample: (coderViewModel example ifNil: [ coderViewModel parentExample ]);
			parentTestCase: (coderViewModel testCase ifNil: [ coderViewModel parentTestCase ]).
	anAttribute argumentBindingsBuilder: aBuilder.
	text
		attribute: anAttribute
		from: aMessage selectorParts last stopPosition
		to: aMessage selectorParts last stopPosition
]
