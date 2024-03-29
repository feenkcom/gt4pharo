Class {
	#name : #GtSearchMethodsWithPackagePatternFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'pattern'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #'instance creation' }
GtSearchMethodsWithPackagePatternFilter class >> pattern: aString [
	^ self new
		pattern: aString;
		yourself
]

{ #category : #comparing }
GtSearchMethodsWithPackagePatternFilter >> = anObject [
	^ self class = anObject class
		and: [ self pattern asLowercase = anObject pattern asLowercase ]
]

{ #category : #accessing }
GtSearchMethodsWithPackagePatternFilter >> defaultFilterScope [
	^ (((AsyncImagePackagesStream new select: [ :eachPackage | (eachPackage name asLowercase indexOfSubCollection: pattern asLowercase) > 0 ])
		collect: [ :eachPackage | AsyncPackageBehaviorsStream forPackage: eachPackage ]) flatten
			collect: [ :eachBehavior | AsyncBehaviorAllLocalMethodsStream forBehavior: eachBehavior ])
				flatten
]

{ #category : #accessing }
GtSearchMethodsWithPackagePatternFilter >> filterValueString [
	^ self pattern
]

{ #category : #printing }
GtSearchMethodsWithPackagePatternFilter >> gtDisplayOn: stream [
	stream
		nextPutAll: self pattern printString;
		nextPutAll: ' packages matching'
]

{ #category : #comparing }
GtSearchMethodsWithPackagePatternFilter >> hash [
	^ self class hash bitXor: self pattern asLowercase hash
]

{ #category : #testing }
GtSearchMethodsWithPackagePatternFilter >> includesMethod: aCompiledMethod [
	| package |
	package := aCompiledMethod package.
	package ifNil: [ ^ false ].
	^ pattern isEmpty or: [ (package name asLowercase indexOfSubCollection: pattern asLowercase) > 0 ]
]

{ #category : #accessing }
GtSearchMethodsWithPackagePatternFilter >> pattern [
	^ pattern
]

{ #category : #accessing }
GtSearchMethodsWithPackagePatternFilter >> pattern: aString [
	pattern := aString
]
