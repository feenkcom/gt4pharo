Class {
	#name : #GtCodeDefinitionDifference,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #enumerating }
GtCodeDefinitionDifference class >> difference: aCollectionOfDefinitions with: anOtherCollectionOfDefinitions added: anIdentityBlock do: anAddedBlock modified: aComparisonBlock do: aRenamedBlock removedDo: aRemovedBlock [
	| myOriginalIdentityMap myComparisonMap otherComparisonMap addedDefs removedDefs modifiedDefs |
	
	myOriginalIdentityMap := (aCollectionOfDefinitions
		select: [ :each | (anIdentityBlock value: each) isNotNil ]
		thenCollect: [ :each | (anIdentityBlock value: each) -> each ]) asOrderedDictionary.

	myComparisonMap := (aCollectionOfDefinitions collect: [ :each | (aComparisonBlock value: each) -> each ]) asOrderedDictionary.
	otherComparisonMap := (anOtherCollectionOfDefinitions collect: [ :each | (aComparisonBlock value: each) -> each ]) asOrderedDictionary.
	
	addedDefs := OrderedCollection new.
	modifiedDefs := OrderedCollection new.
	removedDefs := OrderedCollection new.
	
	Array streamContents: [ :aStream | anOtherCollectionOfDefinitions do: [ :otherDef |
		myOriginalIdentityMap
			at: otherDef name
			ifPresent: [ :myPresentDef |
				(myPresentDef name = otherDef name)
					ifFalse: [
						myComparisonMap
							at: myPresentDef originalName
							ifPresent: [  ]
							ifAbsent: [ modifiedDefs add: myPresentDef ]
						 ].
			]
			ifAbsent: [
				myComparisonMap
					at: otherDef name
					ifAbsent: [ removedDefs add: otherDef ] ] ] ].
		
	aCollectionOfDefinitions do: [ :eachMyDef |
		otherComparisonMap
			at: eachMyDef name
			ifAbsent: [
				(modifiedDefs includes: eachMyDef)
					ifFalse: [ addedDefs add: eachMyDef ] ] ].
		
	addedDefs do: anAddedBlock.
	modifiedDefs do: aRenamedBlock.
	removedDefs do: aRemovedBlock
]

{ #category : #enumerating }
GtCodeDefinitionDifference class >> difference: aCollectionOfDefinitions with: anOtherCollectionOfDefinitions addedDo: anAddedBlock removedDo: aRemovedBlock [
	"I do not try to find renamed differences and only rely on #name.
	Basically, renames are remove + add"
	| myNameMap otherNameMap addedDefs removedDefs |
	
	myNameMap := (aCollectionOfDefinitions collect: [ :each | each name -> each ]) asOrderedDictionary.
	otherNameMap := (anOtherCollectionOfDefinitions collect: [ :each | each name -> each ]) asOrderedDictionary.
	
	addedDefs := OrderedCollection new.
	removedDefs := OrderedCollection new.
	
	Array streamContents: [ :aStream | anOtherCollectionOfDefinitions do: [ :otherDef |
		myNameMap
			at: otherDef name
			ifAbsent: [ removedDefs add: otherDef ] ] ].

	aCollectionOfDefinitions do: [ :eachMyDef |
		otherNameMap
			at: eachMyDef name
			ifAbsent: [ addedDefs add: eachMyDef ] ].
		
	addedDefs do: anAddedBlock.
	removedDefs do: aRemovedBlock
]

{ #category : #enumerating }
GtCodeDefinitionDifference class >> difference: aCollectionOfDefinitions with: anOtherCollectionOfDefinitions addedDo: anAddedBlock renamedDo: aRenamedBlock removedDo: aRemovedBlock [
	| myOriginalNameMap myNameMap otherNameMap addedDefs removedDefs renamedDefs |
	
	myOriginalNameMap := (aCollectionOfDefinitions
		select: [ :each | each originalName isNotNil ]
		thenCollect: [ :each | each originalName -> each ]) asOrderedDictionary.
		
	myNameMap := (aCollectionOfDefinitions collect: [ :each | each name -> each ]) asOrderedDictionary.
	otherNameMap := (anOtherCollectionOfDefinitions collect: [ :each | each name -> each ]) asOrderedDictionary.
	
	addedDefs := OrderedCollection new.
	renamedDefs := OrderedCollection new.
	removedDefs := OrderedCollection new.
	
	Array streamContents: [ :aStream | anOtherCollectionOfDefinitions do: [ :otherDef |
		myOriginalNameMap
			at: otherDef name
			ifPresent: [ :myPresentDef |
				(myPresentDef name = otherDef name)
					ifFalse: [
						myNameMap
							at: myPresentDef originalName
							ifPresent: [  ]
							ifAbsent: [ renamedDefs add: myPresentDef ]
						 ].
			]
			ifAbsent: [
				myNameMap
					at: otherDef name
					ifAbsent: [ removedDefs add: otherDef ] ] ] ].
		
	aCollectionOfDefinitions do: [ :eachMyDef |
		otherNameMap
			at: eachMyDef name
			ifAbsent: [
				(renamedDefs includes: eachMyDef)
					ifFalse: [ addedDefs add: eachMyDef ] ] ].
		
	addedDefs do: anAddedBlock.
	renamedDefs do: aRenamedBlock.
	removedDefs do: aRemovedBlock
]

{ #category : #enumerating }
GtCodeDefinitionDifference class >> difference: aCollectionOfDefinitions with: anOtherCollectionOfDefinitions identity: anIdentityBlock equals: aComparisonBlock addedDo: anAddedBlock modifiedDo: aModifiedBlock removedDo: aRemovedBlock [
	| myComparisonMap otherComparisonMap addedDefs removedDefs modifiedDefs |
	
	myComparisonMap := (aCollectionOfDefinitions collect: [ :each | (anIdentityBlock value: each) -> each ]) asOrderedDictionary.
	otherComparisonMap := (anOtherCollectionOfDefinitions collect: [ :each | (anIdentityBlock value: each) -> each ]) asOrderedDictionary.
	
	addedDefs := OrderedCollection new.
	modifiedDefs := OrderedCollection new.
	removedDefs := OrderedCollection new.
	
	anOtherCollectionOfDefinitions do: [ :otherDef |
		myComparisonMap
			at: (anIdentityBlock value: otherDef)
			ifPresent: [ :myPresentDef |
				(aComparisonBlock value: myPresentDef value: otherDef)
					ifFalse: [ modifiedDefs add: myPresentDef ] ]
			ifAbsent: [ removedDefs add: otherDef ] ].
		
	aCollectionOfDefinitions do: [ :eachMyDef |
		otherComparisonMap
			at: (anIdentityBlock value: eachMyDef)
			ifAbsent: [
				(modifiedDefs includes: eachMyDef)
					ifFalse: [ addedDefs add: eachMyDef ] ] ].
		
	addedDefs do: anAddedBlock.
	modifiedDefs do: aModifiedBlock.
	removedDefs do: aRemovedBlock
]

{ #category : #converting }
GtCodeDefinitionDifference >> asClassRefactorings: aClass [
	^ self asClassRefactorings: aClass in: RBNamespace new
]

{ #category : #converting }
GtCodeDefinitionDifference >> asClassRefactorings: aClass in: anRBModel [
	^ #()
]

{ #category : #testing }
GtCodeDefinitionDifference >> hasDifference [
	<return: #Boolean>
	
	^ true
]
