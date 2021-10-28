Class {
	#name : #GtPharoTestCaseStateFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'resultState',
		'coder'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #accessing }
GtPharoTestCaseStateFilter class >> defaultState [

	^ GtPharoMethodAllState
]

{ #category : #accessing }
GtPharoTestCaseStateFilter class >> filterDescriptorFor: aMethodsCoder [

	^ (GtFilterDescriptor
		   creator: [ :value | 
			   self new
				   resultStateString: value;
				   coder: aMethodsCoder ]
		   named: 'Tests'
		   order: 13
		   completion: (GtStringsCompletionStrategy new completions:
				    (GtPrefixTree withAll: GtPharoMethodTestCaseState allLabels))
		   emptyDefaultValue: self defaultState label) beNotDefault
]

{ #category : #comparing }
GtPharoTestCaseStateFilter >> = anObject [

	^ self class = anObject class and: [ 
		  self resultState = anObject resultState and: [ 
			  self coder = anObject coder ] ]
]

{ #category : #accessing }
GtPharoTestCaseStateFilter >> coder [

	^ coder
]

{ #category : #accessing }
GtPharoTestCaseStateFilter >> coder: aMethodsCoder [

	coder := aMethodsCoder
]

{ #category : #accessing }
GtPharoTestCaseStateFilter >> filterValueString [

	^ self resultState label
]

{ #category : #comparing }
GtPharoTestCaseStateFilter >> hash [

	^ (self class hash bitXor: self resultState hash) bitXor: self coder hash
]

{ #category : #accessing }
GtPharoTestCaseStateFilter >> includesMethod: aCompiledMethod [

	| aMethodCoder |
	((aCompiledMethod methodClass inheritsFrom: TestCase) and: [ 
		 aCompiledMethod selector isTestSelector ]) ifFalse: [ ^ false ].

	self coder ifNil: [ ^ true ].
	self resultState ifNil: [ ^ true ].

	aMethodCoder := self coder coderFor: aCompiledMethod.

	^ self resultState includesCoder: aMethodCoder
]

{ #category : #printing }
GtPharoTestCaseStateFilter >> printOn: aStream [

	super printOn: aStream.
	self resultState ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		print: self resultState;
		nextPut: $)
]

{ #category : #accessing }
GtPharoTestCaseStateFilter >> resultState [

	^ resultState
]

{ #category : #accessing }
GtPharoTestCaseStateFilter >> resultState: aState [

	resultState := aState
]

{ #category : #accessing }
GtPharoTestCaseStateFilter >> resultStateString: aString [

	self resultState:
		(GtPharoMethodTestCaseState stateFromLabel: aString)
]
