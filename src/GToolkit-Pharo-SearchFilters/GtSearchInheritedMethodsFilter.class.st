Class {
	#name : #GtSearchInheritedMethodsFilter,
	#superclass : #GtSearchMethodsInClassFilter,
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #accessing }
GtSearchInheritedMethodsFilter >> defaultFilterScope [
	^ AsyncBehaviorAllSortedInheritedMethodsStream forBehavior: class
]

{ #category : #accessing }
GtSearchInheritedMethodsFilter >> filterValueString [
	^ upToSuperclass name
]

{ #category : #accessing }
GtSearchInheritedMethodsFilter >> includesMethod: aCompiledMethod [
	| methodClass |
	methodClass := aCompiledMethod methodClass.
	^ (super includesMethod: aCompiledMethod)
		or: [ aCompiledMethod isFromTrait not
				and: [ (includeSubclasses
						and: [ methodClass classSide includesBehavior: class classSide ])
						or: [ includeSuperclass
								and: [ (class classSide includesBehavior: methodClass classSide)
										and: [ upToSuperclass superclass isNil
												or: [ (upToSuperclass superclass classSide includesBehavior: methodClass classSide)
														not ] ] ] ] ] ]
]

{ #category : #accessing }
GtSearchInheritedMethodsFilter >> methodsDo: aBlock [
	super methodsDo: aBlock.
	class classSide methods do: aBlock.
	includeSuperclass ifTrue: [ class classSide superclass methods do: aBlock ].
	includeSubclasses
		ifTrue: [ (class classSide allSubclasses flatCollect: #methods) do: aBlock ]
]
