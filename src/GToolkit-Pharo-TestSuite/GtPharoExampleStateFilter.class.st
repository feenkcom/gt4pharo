Class {
	#name : #GtPharoExampleStateFilter,
	#superclass : #GtSearchPragmasFilter,
	#instVars : [
		'resultState',
		'pharoExampleSuite'
	],
	#category : #'GToolkit-Pharo-TestSuite-Filters'
}

{ #category : #defaults }
GtPharoExampleStateFilter class >> defaultState [
	^ GtFilterExampleAllState default
]

{ #category : #comparing }
GtPharoExampleStateFilter >> = anObject [
	^ super = anObject and: [ 
		self resultState = anObject resultState and: [ 
			self coder = anObject coder ] ]
]

{ #category : #accessing }
GtPharoExampleStateFilter >> filterValueString [
	^ self resultState label
]

{ #category : #comparing }
GtPharoExampleStateFilter >> hash [
	^ (super hash bitXor: self resultState hash) 
		bitXor: self coder hash
]

{ #category : #testing }
GtPharoExampleStateFilter >> includesMethod: aCompiledMethod [
	^ (super includesMethod: aCompiledMethod)
		and: [ self satisfiesFilter: aCompiledMethod ]
]

{ #category : #initialization }
GtPharoExampleStateFilter >> initialize [
	super initialize.

	symbol := #gtExample.
	resultState := self class defaultState
]

{ #category : #accessing }
GtPharoExampleStateFilter >> pharoExampleSuite [

	^ pharoExampleSuite
]

{ #category : #accessing }
GtPharoExampleStateFilter >> pharoExampleSuite: anObject [

	pharoExampleSuite := anObject
]

{ #category : #accessing }
GtPharoExampleStateFilter >> resultState [
	<return: #GtExampleState>
	^ resultState
]

{ #category : #'api - initialization' }
GtPharoExampleStateFilter >> resultState: aGtFilterExampleStatus [
	resultState := aGtFilterExampleStatus
]

{ #category : #'api - initialization' }
GtPharoExampleStateFilter >> resultStateString: aString [
	self resultState: (GtExampleState default stateFromLabel: aString)
]

{ #category : #testing }
GtPharoExampleStateFilter >> satisfiesFilter: aCompiledMethod [
	| anExample |

	anExample := self pharoExampleSuite exampleWithResultForMethod: aCompiledMethod.
	anExample ifNil: [ ^ false ].
	^ self resultState includesExampleWithResult: anExample
]
