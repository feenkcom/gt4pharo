Class {
	#name : #GtSearchClass,
	#superclass : #Object,
	#instVars : [
		'methodClass',
		'group'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchClass >> group [

	^ group
]

{ #category : #accessing }
GtSearchClass >> group: aGroupResult [

	group := aGroupResult
]

{ #category : #accessing }
GtSearchClass >> gtCodeStructureChildren [

	^ self methods
]

{ #category : #accessing }
GtSearchClass >> gtCodeStructureName [

	^ self methodClass name
]

{ #category : #accessing }
GtSearchClass >> methodClass [

	^ methodClass
]

{ #category : #accessing }
GtSearchClass >> methodClass: aClass [

	methodClass := aClass
]

{ #category : #accessing }
GtSearchClass >> methods [

	| aResult |
	aResult := OrderedCollection new.

	self group do: [ :eachMethod | 
		| aSearchMethod aMethodClass |
		aMethodClass := eachMethod methodClass.

		aMethodClass = self methodClass ifTrue: [ 
			(aResult anySatisfy: [ :eachSearchMethod | 
				 eachSearchMethod method = eachMethod ]) ifFalse: [ 
				aSearchMethod := GtSearchMethod new
					                 method: eachMethod;
					                 group: self group.
				aResult add: aSearchMethod ] ] ].

	^ aResult
]
