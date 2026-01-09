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
			(each method gtIsActive
				and: [ each method numArgs = 0 and: [ classes includes: each methodClass ] ])
				ifTrue: [ filterDescriptors
						add: (each method methodClass isInstanceSide
								ifTrue: [ each methodClass basicNew perform: each methodSelector ]
								ifFalse: [ each methodClass soleInstance perform: each methodSelector ]) ] ].
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
