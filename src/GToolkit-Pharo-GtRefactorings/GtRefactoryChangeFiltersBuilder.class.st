Class {
	#name : #GtRefactoryChangeFiltersBuilder,
	#superclass : #Object,
	#instVars : [
		'changes'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Changes-View'
}

{ #category : #accessing }
GtRefactoryChangeFiltersBuilder >> availableFilters [
	| classes filterDescriptors |
	filterDescriptors := OrderedCollection new.
	classes := Set new.
	changes
		gtAllChangesDo: [ :each | 
			classes
				addAll: each class withAllSuperclasses;
				addAll: each class class withAllSuperclasses ].
	(Pragma allNamed: #gtRefactoryChangeFilter)
		do: [ :each | 
			(each method gtIsActive and: [ classes includes: each methodClass ])
				ifTrue: [ each method numArgs = 0
						ifTrue: [ filterDescriptors
								add: ((each method methodClass isInstanceSide
										ifTrue: [ each methodClass basicNew ]
										ifFalse: [ each methodClass soleInstance ])
										perform: each methodSelector) ].
					each method numArgs = 1
						ifTrue: [ filterDescriptors
								add: ((each method methodClass isInstanceSide
										ifTrue: [ each methodClass basicNew ]
										ifFalse: [ each methodClass soleInstance ])
										perform: each methodSelector
										with: changes) ] ] ].
	^ filterDescriptors sort: [ :a :b | a order < b order ]
]

{ #category : #accessing }
GtRefactoryChangeFiltersBuilder >> changes [
	^ changes
]

{ #category : #accessing }
GtRefactoryChangeFiltersBuilder >> changes: anObject [
	changes := anObject
]
