Class {
	#name : 'GtSearchInstanceMethodsFilter',
	#superclass : 'GtSearchMethodsFilter',
	#category : 'GToolkit-Pharo-Coder-Filters'
}

{ #category : 'comparing' }
GtSearchInstanceMethodsFilter >> = anObject [
	^ self class = anObject class
]

{ #category : 'comparing' }
GtSearchInstanceMethodsFilter >> hash [
	^ self class hash
]

{ #category : 'testing' }
GtSearchInstanceMethodsFilter >> includesMethod: aCompiledMethod [
	^ aCompiledMethod methodClass isInstanceSide
]
