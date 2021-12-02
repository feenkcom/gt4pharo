Class {
	#name : #GtSearchPackage,
	#superclass : #Object,
	#instVars : [
		'package',
		'group'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchPackage >> classes [

	| aResult |
	aResult := OrderedCollection new.

	self group do: [ :eachMethod | 
		eachMethod package = self package ifTrue: [ 
			| aSearchClass aMethodClass |
			aMethodClass := eachMethod methodClass.

			(aResult anySatisfy: [ :eachSearchClass | 
				 eachSearchClass methodClass = aMethodClass ]) ifFalse: [ 
				aSearchClass := GtSearchClass new
					                methodClass: aMethodClass;
					                group: self group.
				aResult add: aSearchClass ] ] ].

	^ aResult
]

{ #category : #accessing }
GtSearchPackage >> group [

	^ group
]

{ #category : #accessing }
GtSearchPackage >> group: aGroupResult [

	group := aGroupResult
]

{ #category : #accessing }
GtSearchPackage >> gtCodeStructureChildren [

	^ self classes
]

{ #category : #accessing }
GtSearchPackage >> gtCodeStructureName [

	^ self package name
]

{ #category : #accessing }
GtSearchPackage >> gtFilter [

	^ self group & self package name gtPackageMatches
]

{ #category : #accessing }
GtSearchPackage >> package [

	^ package
]

{ #category : #accessing }
GtSearchPackage >> package: aRPackage [

	package := aRPackage
]
