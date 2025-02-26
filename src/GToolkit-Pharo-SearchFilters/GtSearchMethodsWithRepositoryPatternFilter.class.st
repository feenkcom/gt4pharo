Class {
	#name : #GtSearchMethodsWithRepositoryPatternFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'pattern'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #'instance creation' }
GtSearchMethodsWithRepositoryPatternFilter class >> pattern: aString [
	^ self new
		pattern: aString;
		yourself
]

{ #category : #comparing }
GtSearchMethodsWithRepositoryPatternFilter >> = anObject [
	^ self class = anObject class
		and: [ self pattern asLowercase = anObject pattern asLowercase ]
]

{ #category : #accessing }
GtSearchMethodsWithRepositoryPatternFilter >> defaultFilterScope [
	^ (((AsyncImageRepositoriesStream new select: [ :eachRepository | (eachRepository name asLowercase indexOfSubCollection: pattern asLowercase) > 0 ])
		collect: [ :eachPackage | AsyncRepositoryBehaviorsStream forRepository: eachPackage ]) flatten
			collect: [ :eachBehavior | AsyncBehaviorAllLocalMethodsStream forBehavior: eachBehavior ])
				flatten
]

{ #category : #accessing }
GtSearchMethodsWithRepositoryPatternFilter >> filterValueString [
	^ self pattern
]

{ #category : #printing }
GtSearchMethodsWithRepositoryPatternFilter >> gtDisplayOn: stream [
	stream
		nextPutAll: self pattern printString;
		nextPutAll: ' repositories matching'
]

{ #category : #comparing }
GtSearchMethodsWithRepositoryPatternFilter >> hash [
	^ self class hash bitXor: self pattern asLowercase hash
]

{ #category : #testing }
GtSearchMethodsWithRepositoryPatternFilter >> includesMethod: aCompiledMethod [
	| repository |
	repository := aCompiledMethod package repository.
	repository ifNil: [ ^ false ].
	^ pattern isEmpty or: [ (repository name asLowercase indexOfSubCollection: pattern asLowercase) > 0 ]
]

{ #category : #accessing }
GtSearchMethodsWithRepositoryPatternFilter >> pattern [
	^ pattern
]

{ #category : #accessing }
GtSearchMethodsWithRepositoryPatternFilter >> pattern: aString [
	pattern := aString
]
