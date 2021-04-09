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
GtPharoMethodsDefinition >> addMethod: aSourceCode protocol: aProtocol [
	definitions := definitions copyWith: (GtPharoMethodDefinition new
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
