Class {
	#name : #GtSearchInheritedMethodsFilter,
	#superclass : #GtSearchMethodsInClassFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchInheritedMethodsFilter >> defaultFilterScope [
	^ AsyncBehaviorAllSortedInheritedMethodsStream forBehavior: filterClass
]

{ #category : #accessing }
GtSearchInheritedMethodsFilter >> filterValueString [
	^ upToSuperclass name
]

{ #category : #printing }
GtSearchInheritedMethodsFilter >> gtDisplayOn: stream [
	stream
		print: filterClass;
		nextPutAll: ' inheritedMethods'.
		
	self includeSuperclass ifTrue: [ 
		stream 
			nextPutAll: ' up to '; 
			print: upToSuperclass ]
]

{ #category : #accessing }
GtSearchInheritedMethodsFilter >> includesMethod: aCompiledMethod [
	| methodClass |
	filterClass ifNil: [ ^ false ].
	methodClass := aCompiledMethod methodClass.
	^ (super includesMethod: aCompiledMethod)
		or: [ (aCompiledMethod origin name sameContentAs:  #TraitedClass) not
				and: [ (includeSubclasses
						and: [ methodClass classSide includesBehavior: filterClass classSide ])
						or: [ includeSuperclass
								and: [ (filterClass classSide isTrait ifFalse: [ filterClass classSide includesBehavior: methodClass classSide ] ifTrue: [ filterClass classSide == methodClass classSide ])
										and: [ upToSuperclass superclass isNil
												or: [ (upToSuperclass superclass classSide includesBehavior: methodClass classSide)
														not ] ] ] ] ] ]
]

{ #category : #accessing }
GtSearchInheritedMethodsFilter >> methodsDo: aBlock [
	super methodsDo: aBlock.
	filterClass classSide methods do: aBlock.
	includeSuperclass ifTrue: [ filterClass classSide superclass methods do: aBlock ].
	includeSubclasses
		ifTrue: [ (filterClass classSide allSubclasses flatCollect: #methods) do: aBlock ]
]
