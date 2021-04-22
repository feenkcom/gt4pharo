Class {
	#name : #GtPharoMethodsDefinition,
	#superclass : #GtCompositeDefinition,
	#category : #'GToolkit-Pharo-Metamodels-Method - Definitions'
}

{ #category : #'instance creation' }
GtPharoMethodsDefinition class >> fromClass: aClass [
	^ self new fromClass: aClass
]

{ #category : #'instance creation' }
GtPharoMethodsDefinition class >> fromTrait: aTrait [
	^ self new fromTrait: aTrait
]

{ #category : #adding }
GtPharoMethodsDefinition >> addMethod: aNewMethodDefinition [
	self
		methodNamed: aNewMethodDefinition selector
		ifFound: [ :anExistingMethod |
			anExistingMethod
				protocol: aNewMethodDefinition protocol;
				sourceCode: aNewMethodDefinition sourceCode ]
		ifNone: [ definitions := definitions copyWith: aNewMethodDefinition ]
]

{ #category : #adding }
GtPharoMethodsDefinition >> addMethod: aSourceCode protocol: aProtocol [
	self addMethod: (GtPharoMethodDefinition new
		sourceCode: aSourceCode;
		protocol: aProtocol)
]

{ #category : #'api - accepting' }
GtPharoMethodsDefinition >> createChange [
	| aCompositeChange |

	aCompositeChange := RBCompositeRefactoryChange named: 'Add methods'.
	self do: [ :eachMethod | aCompositeChange addChange: eachMethod createChange ].

	^ aCompositeChange
]

{ #category : #'api - accepting' }
GtPharoMethodsDefinition >> differenceWith: aGtMethodsDefinition [
	| theDifference |

	theDifference := GtMethodsDefinitionDifference new.

	GtCodeDefinitionDifference
		difference: self all
		with: aGtMethodsDefinition all
		identity:  [ :eachMethod | eachMethod selector ]
		equals: [ :previousMethod :newMethod |
			previousMethod protocol = newMethod protocol
				and: [ previousMethod sourceCode = newMethod sourceCode ] ]
		addedDo: [ :eachMethod | theDifference add: (GtMethodAddedDifference new method: eachMethod) ]
		modifiedDo: [ :eachMethod | theDifference add: (GtMethodModifiedDifference new method: eachMethod) ]
		removedDo: [ :eachMethod | theDifference add: (GtMethodRemovedDifference new method: eachMethod) ].
		
	^ theDifference
]

{ #category : #'instance creation' }
GtPharoMethodsDefinition >> fromClass: aClass [
	definitions := aClass localMethods collect: [ :eachCompiledMethod |
		(GtPharoMethodDefinition fromCompiledMethod: eachCompiledMethod) parent: self ]
]

{ #category : #'instance creation' }
GtPharoMethodsDefinition >> fromTrait: aTrait [
	definitions := aTrait localMethods collect: [ :eachCompiledMethod |
		(GtPharoMethodDefinition fromCompiledMethod: eachCompiledMethod) parent: self ]
]

{ #category : #'api - accessing' }
GtPharoMethodsDefinition >> methodNamed: aSelector [
	^ self
		methodNamed: aSelector
		ifFound: #yourself
		ifNone: [ KeyNotFound signalFor: aSelector in: self  ]
]

{ #category : #'api - accessing' }
GtPharoMethodsDefinition >> methodNamed: aSelector ifFound: ifFoundBlock ifNone: ifNoneBlock [
	^ self definitions
		detect: [ :eachMethod | eachMethod selector = aSelector ]
		ifFound: ifFoundBlock
		ifNone: ifNoneBlock
]
