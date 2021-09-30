Class {
	#name : #GtSearchTestClassesFilter,
	#superclass : #GtSearchClassesFilter,
	#category : 'GToolkit-Pharo-Coder-Filters'
}

{ #category : #testing }
GtSearchTestClassesFilter >> includesClass: aClass [
	^ aClass isTestCase
]
